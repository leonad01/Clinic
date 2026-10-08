package com.clinic.dentalclinicbooking.util;

import org.springframework.stereotype.Component;

/** Converts internal status codes into Thai labels for JSP views. */
@Component("statusLabel")
public class StatusLabel {

  public String appointment(String status) {
    if (status == null) return "-";
    return switch (status) {
      case "PENDING" -> "รออนุมัติ";
      case "APPROVED" -> "รอรับบริการ";
      case "IN_PROGRESS" -> "กำลังรักษา";
      case "COMPLETED" -> "เสร็จแล้ว";
      case "CANCELLED" -> "ยกเลิกแล้ว";
      case "REJECTED" -> "ปฏิเสธแล้ว";
      default -> status;
    };
  }

  public String schedule(String status) {
    if (status == null) return "-";
    return switch (status) {
      case "AVAILABLE" -> "ว่าง";
      case "UNAVAILABLE" -> "ไม่ว่าง";
      case "PENDING" -> "รออนุมัติ";
      case "APPROVED" -> "รอรับบริการ";
      case "IN_PROGRESS" -> "กำลังรักษา";
      case "COMPLETED" -> "เสร็จแล้ว";
      case "CANCELLED" -> "ยกเลิกแล้ว";
      default -> status;
    };
  }

  public String room(String status) {
    if (status == null) return "-";
    return switch (status) {
      case "AVAILABLE" -> "พร้อมใช้งาน";
      case "UNAVAILABLE" -> "ปิดใช้งาน";
      default -> status;
    };
  }
}
