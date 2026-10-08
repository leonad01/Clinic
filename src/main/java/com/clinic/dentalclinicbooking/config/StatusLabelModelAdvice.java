package com.clinic.dentalclinicbooking.config;

import com.clinic.dentalclinicbooking.util.StatusLabel;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

/** Makes Thai status labels available to every JSP view. */
@ControllerAdvice
public class StatusLabelModelAdvice {

  private final StatusLabel statusLabel;

  public StatusLabelModelAdvice(StatusLabel statusLabel) {
    this.statusLabel = statusLabel;
  }

  @ModelAttribute("statusLabel")
  public StatusLabel statusLabel() {
    return statusLabel;
  }
}
