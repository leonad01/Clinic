document.addEventListener("DOMContentLoaded", () => {
  const dialog = document.querySelector("[data-detail-dialog]");
  const content = dialog?.querySelector("[data-detail-content]");
  if (!dialog || !content) return;

  const loading = '<div class="detail-modal-loading">กำลังโหลดข้อมูล...</div>';

  document.addEventListener("click", async (event) => {
    const link = event.target.closest("a[data-detail-modal]");
    if (!link) return;
    event.preventDefault();
    content.innerHTML = loading;
    dialog.showModal();

    try {
      const response = await fetch(link.href, { headers: { "X-Requested-With": "XMLHttpRequest" } });
      if (!response.ok) throw new Error("Unable to load detail");
      const page = new DOMParser().parseFromString(await response.text(), "text/html");
      const detail = page.querySelector("main .card") || page.querySelector("main");
      if (!detail) throw new Error("Detail content was not found");
      detail.querySelectorAll('a[href$="/appointments"], a[href$="/schedules"]').forEach((element) => element.remove());
      detail.classList.remove("col-lg-8", "mx-auto", "shadow-sm");
      content.replaceChildren(detail);
      const cancelForm = detail.querySelector("[data-confirm-cancel]");
      if (cancelForm) {
        cancelForm.addEventListener("submit", (submitEvent) => {
          if (!window.confirm("ยืนยันการยกเลิกนัดหมายหรือไม่?\nการดำเนินการนี้ไม่สามารถย้อนกลับได้")) {
            submitEvent.preventDefault();
          }
        });
      }
    } catch (error) {
      window.location.assign(link.href);
    }
  });

  dialog.querySelector("[data-detail-close]").addEventListener("click", () => dialog.close());
  dialog.addEventListener("click", (event) => {
    if (event.target === dialog) dialog.close();
  });
});
