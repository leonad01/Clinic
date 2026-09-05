package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.repository.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

@Configuration
public class SecurityConfig {
  @Bean
  public PasswordEncoder passwordEncoder() {
    // Development only: store new passwords as readable text for database demonstrations.
    // Existing BCrypt passwords remain valid so current accounts can still sign in.
    BCryptPasswordEncoder legacyBcrypt = new BCryptPasswordEncoder();
    return new PasswordEncoder() {
      @Override
      public String encode(CharSequence rawPassword) {
        return rawPassword.toString();
      }

      @Override
      public boolean matches(CharSequence rawPassword, String storedPassword) {
        if (storedPassword == null) {
          return false;
        }
        if (storedPassword.startsWith("$2a$")
            || storedPassword.startsWith("$2b$")
            || storedPassword.startsWith("$2y$")) {
          return legacyBcrypt.matches(rawPassword, storedPassword);
        }
        return rawPassword.toString().equals(storedPassword);
      }
    };
  }

  @Bean
  public UserDetailsService userDetailsService(
      PatientRepository patients,
      NurseRepository nurses,
      DentistRepository dentists,
      AdminRepository admins) {
    return username ->
        patients
            .findByUsername(username)
            .map(
                p ->
                    User.withUsername(p.getUsername())
                        .password(p.getPasswordHash())
                        .roles("PATIENT")
                        .build())
            .or(
                () ->
                    nurses
                        .findByUsername(username)
                        .map(
                            n ->
                                User.withUsername(n.getUsername())
                                    .password(n.getPassword())
                                    .roles("NURSE")
                                    .build()))
            .or(
                () ->
                    dentists
                        .findByUsername(username)
                        .map(
                            d ->
                                User.withUsername(d.getUsername())
                                    .password(d.getPassword())
                                    .roles("DENTIST")
                                    .build()))
            .or(
                () ->
                    admins
                        .findByUsername(username)
                        .map(
                            a ->
                                User.withUsername(a.getUsername())
                                    .password(a.getPassword())
                                    .roles("ADMIN")
                                    .build()))
            .orElseThrow(() -> new UsernameNotFoundException("ไม่พบชื่อผู้ใช้งาน"));
  }

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http.csrf(csrf -> csrf.disable())
        .authorizeHttpRequests(
            auth ->
                auth.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR)
                    .permitAll()
                    .requestMatchers(
                        "/",
                        "/error",
                        "/access-denied",
                        "/WEB-INF/**",
                        "/login",
                        "/patient/login",
                        "/register",
                        "/register/**",
                        "/services/**",
                        "/nurse/login",
                        "/dentist/login",
                        "/admin/login",
                        "/css/**",
                        "/js/**",
                        "/images/**")
                    .permitAll()
                    .requestMatchers("/patient/**", "/booking", "/booking/**")
                    .hasRole("PATIENT")
                    .requestMatchers("/nurse/**")
                    .hasRole("NURSE")
                    .requestMatchers("/dentist/**")
                    .hasRole("DENTIST")
                    .requestMatchers("/admin/**")
                    .hasRole("ADMIN")
                    .anyRequest()
                    .authenticated())
        .exceptionHandling(
            exceptions ->
                exceptions
                    .authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login?expired"))
                    .accessDeniedHandler(
                        (request, response, exception) ->
                            response.sendRedirect(request.getContextPath() + "/access-denied")))
        .sessionManagement(session -> session.invalidSessionUrl("/login?expired"))
        .formLogin(
            form ->
                form.loginPage("/login")
                    .failureHandler(
                        (request, response, exception) -> {
                          String loginPath = loginPathForRole(request.getParameter("loginRole"));
                          response.sendRedirect(request.getContextPath() + loginPath + "?error");
                        })
                    .successHandler(
                        (request, response, authentication) -> {
                          String role =
                              authentication.getAuthorities().iterator().next().getAuthority();
                          String requestedRole = request.getParameter("loginRole");
                          if (requestedRole != null && !requestedRole.equals(role)) {
                            clearLogin(request, response);
                            String loginPath = loginPathForRole(requestedRole);
                            response.sendRedirect(request.getContextPath() + loginPath + "?roleError");
                            return;
                          }
                          SavedRequest savedRequest =
                              new HttpSessionRequestCache().getRequest(request, response);
                          if ("ROLE_PATIENT".equals(role)
                              && savedRequest != null
                              && savedRequest.getRedirectUrl().contains("/booking")) {
                            response.sendRedirect(savedRequest.getRedirectUrl());
                            return;
                          }
                          response.sendRedirect(
                              switch (role) {
                                case "ROLE_NURSE" -> "/nurse/appointments";
                                case "ROLE_DENTIST" -> "/dentist/schedules";
                                case "ROLE_ADMIN" -> "/admin/rooms";
                                default -> "/";
                              });
                        })
                    .permitAll())
        .logout(
            logout ->
                logout
                    .logoutSuccessUrl("/?logout")
                    .invalidateHttpSession(true)
                    .clearAuthentication(true)
                    .deleteCookies("JSESSIONID", "smilecare-remember-me"));
    return http.build();
  }

  private void clearLogin(jakarta.servlet.http.HttpServletRequest request, HttpServletResponse response) {
    SecurityContextHolder.clearContext();
    if (request.getSession(false) != null) {
      request.getSession(false).invalidate();
    }
    for (String name : new String[] {"JSESSIONID", "smilecare-remember-me"}) {
      Cookie cookie = new Cookie(name, "");
      cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
      cookie.setMaxAge(0);
      response.addCookie(cookie);
    }
  }

  private String loginPathForRole(String role) {
    return switch (role == null ? "" : role) {
      case "ROLE_NURSE" -> "/nurse/login";
      case "ROLE_DENTIST" -> "/dentist/login";
      case "ROLE_ADMIN" -> "/admin/login";
      default -> "/patient/login";
    };
  }
}
