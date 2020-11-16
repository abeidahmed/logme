import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['container'];

  connect() {
    if (this.isPreview) {
      this.hide();
    }
  }

  open() {
    this.containerTargets.forEach((target) => {
      target.classList.add(this.toggleClass);
    });
  }

  toggle() {
    this.containerTargets.forEach((target) => {
      target.classList.toggle(this.toggleClass);
    });
  }

  close() {
    this.containerTargets.forEach((target) => {
      target.classList.remove(this.toggleClass);
    });
  }

  onOutsideClick(e) {
    if (!this.element.contains(e.target)) {
      this.close();
    }
  }

  get toggleClass() {
    return this.data.get('class');
  }

  get isPreview() {
    return document.documentElement.hasAttribute('data-turbolinks-preview');
  }
}
