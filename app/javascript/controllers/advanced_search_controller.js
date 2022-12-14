import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="advanced-search"
export default class extends Controller {
  static targets = ["toggler", "search"];

  connect() {
    const togglerAdvanced = this.togglerTarget;
    const searchAdvanced = this.searchTarget;
    const closeAdvanced =searchAdvanced.querySelector(".back-bar a");

    togglerAdvanced.addEventListener("click", (event) => {
      event.preventDefault();
      searchAdvanced.classList.add('d-block');
    });

    closeAdvanced.addEventListener("click", (event) => {
      event.preventDefault();
      searchAdvanced.classList.remove('d-block');
    });
  }
}
