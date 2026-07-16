package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.repository.PatientRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
    @Bean public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
    @Bean public UserDetailsService userDetailsService(PatientRepository patientRepository) {
        return username -> patientRepository.findByUsername(username)
            .map(patient -> User.withUsername(patient.getUsername()).password(patient.getPasswordHash()).roles("PATIENT").build())
            .orElseThrow(() -> new UsernameNotFoundException("Patient not found"));
    }
    @Bean public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers("/", "/login", "/register", "/register/**", "/css/**", "/js/**", "/images/**").permitAll()
                .requestMatchers("/booking", "/booking/**", "/appointments/**").hasRole("PATIENT")
                .requestMatchers("/nurse/**", "/dashboard/**", "/dashboard", "/h2-console/**").permitAll()
                .anyRequest().authenticated())
            .formLogin(form -> form.loginPage("/login").defaultSuccessUrl("/booking", true).permitAll())
            .logout(logout -> logout.logoutSuccessUrl("/"));
        return http.build();
    }
}
