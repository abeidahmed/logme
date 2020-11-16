import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['container'];

  connect() {
    this.element.classList.add(this.enteringClass);

    setTimeout(() => {
      this.element.classList.add(this.enteredClass);
    }, 100);

    this.timerId = setTimeout(() => {
      this.hide();
    }, this.duration || 4000);
  }

  hide() {
    this.element.classList.remove(this.enteredClass);
    this.element.classList.add(this.leavingClass);

    setTimeout(() => {
      this.element.remove();
    }, 100);

    clearTimeout(this.timerId);
  }

  get enteringClass() {
    return this.data.get('entering');
  }

  get enteredClass() {
    return this.data.get('entered');
  }

  get leavingClass() {
    return this.data.get('leaving');
  }

  get duration() {
    return parseInt(this.data.get('duration'));
  }
}
