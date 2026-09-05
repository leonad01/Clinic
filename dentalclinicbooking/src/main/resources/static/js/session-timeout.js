(() => {
  const inactivityLimit = 30 * 60 * 1000;
  const storageKey = "smilecare-last-activity";
  let lastWrite = 0;
  let loggingOut = false;

  function markActivity() {
    const now = Date.now();
    // Avoid writing to storage for every mouse movement.
    if (now - lastWrite > 1000) {
      localStorage.setItem(storageKey, String(now));
      lastWrite = now;
    }
  }

  function signOutForInactivity() {
    if (loggingOut) return;
    loggingOut = true;
    localStorage.removeItem(storageKey);

    const form = document.createElement("form");
    form.method = "post";
    form.action = `${window.smileCareContextPath || ""}/logout`;
    document.body.appendChild(form);
    form.submit();
  }

  function checkInactivity() {
    const lastActivity = Number(localStorage.getItem(storageKey)) || Date.now();
    if (Date.now() - lastActivity >= inactivityLimit) {
      signOutForInactivity();
    }
  }

  ["click", "keydown", "touchstart", "mousemove", "scroll"].forEach((eventName) =>
    document.addEventListener(eventName, markActivity, { passive: true })
  );
  window.addEventListener("focus", markActivity);
  markActivity();
  window.setInterval(checkInactivity, 15000);
})();
