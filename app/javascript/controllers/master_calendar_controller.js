import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    const month = this.element.dataset.defaultMonth || new Date().getMonth() + 1;
    const year = this.element.dataset.defaultYear || new Date().getFullYear();

    flatpickr(this.element, {
      dateFormat: "F Y",
      defaultDate: new Date(year, month-1),
      onChange: (selectedDates) => {
        const d = selectedDates[0];
        window.location.href = `/mydesks?month=${d.getMonth()+1}&year=${d.getFullYear()}`;
      }
    });
  }
}
