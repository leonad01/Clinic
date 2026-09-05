document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("[data-appointment-selector]").forEach((form) => {
    const service = form.querySelector("[data-service]");
    const dentist = form.querySelector("select[data-dentist]");
    const date = form.querySelector("select[data-date]");
    const time = form.querySelector("select[data-time]");
    const source = [...form.querySelectorAll("[data-schedule-source] option")].map((option) => option.dataset);
    const selected = form.dataset.selectedScheduleId || "";
    const option = (value, label) => new Option(label, value);
    const reset = (element, label) => { element.replaceChildren(option("", label)); element.disabled = true; };
    const unique = (items, key) => [...new Map(items.map((item) => [item[key], item])).values()];
    const setDentists = () => {
      reset(dentist, "-- เลือกทันตแพทย์ --"); reset(date, "-- เลือกวันที่ว่าง --"); reset(time, "-- เลือกเวลา --");
      unique(source, "dentistId").forEach((item) => dentist.add(option(item.dentistId, item.dentistName)));
      dentist.disabled = false;
    };
    const setDates = () => {
      reset(date, "-- เลือกวันที่ว่าง --"); reset(time, "-- เลือกเวลา --");
      unique(source.filter((item) => item.dentistId === dentist.value), "date").forEach((item) => date.add(option(item.date, item.date)));
      date.disabled = false;
    };
    const setTimes = () => {
      reset(time, "-- เลือกเวลา --");
      source.filter((item) => item.dentistId === dentist.value && item.date === date.value)
        .forEach((item) => time.add(option(item.id, `${item.start} - ${item.end}`)));
      time.disabled = false;
    };
    service?.addEventListener("change", setDentists); dentist.addEventListener("change", setDates); date.addEventListener("change", setTimes);
    if (selected) { const current = source.find((item) => item.id === selected); if (current) { setDentists(); dentist.value=current.dentistId; setDates(); date.value=current.date; setTimes(); time.value=current.id; } }
    else if (!service) setDentists();
  });
});
