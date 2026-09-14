package com.clinic.dentalclinicbooking;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class DentalclinicbookingApplication extends SpringBootServletInitializer {

  public static void main(String[] args) {
    SpringApplication.run(DentalclinicbookingApplication.class, args);
  }

  @Override
  protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
    return application.sources(DentalclinicbookingApplication.class);
  }
}
