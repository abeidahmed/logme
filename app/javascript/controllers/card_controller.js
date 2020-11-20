import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['initiator', 'confirm'];

  showConfirmation() {
    this.confirmTarget.classList.remove(this.toggleClass);
    this.initiatorTarget.classList.add(this.toggleClass);
  }

  hideConfirmation() {
    this.confirmTarget.classList.add(this.toggleClass);
    this.initiatorTarget.classList.remove(this.toggleClass);
  }

  onOutsideClick(e) {
    if (!this.element.contains(e.target)) {
      this.hideConfirmation();
    }
  }

  get toggleClass() {
    return this.data.get('toggleClass');
  }
}
