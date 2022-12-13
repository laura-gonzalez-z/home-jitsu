import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attendee-list"
export default class extends Controller {
  static targets = ["link", "list"];

  connect() {
    const linkAttendees = this.linkTarget;
    const listAttendees = this.listTarget;
    const count = listAttendees.childElementCount;

    if (count <= 3) {
      linkAttendees.style.display = 'none';
    } else {
      listAttendees.classList.add('hide-attendees');
      linkAttendees.addEventListener("click", (event) => {
        event.preventDefault();
        if (linkAttendees.innerText == "See all") {
          linkAttendees.innerText = "Hide";
          listAttendees.classList.remove('hide-attendees');
        } else if (linkAttendees.innerText == "Hide") {
          linkAttendees.innerText = "See all";
          listAttendees.classList.add('hide-attendees');
        }

      });
    }

  }
}
