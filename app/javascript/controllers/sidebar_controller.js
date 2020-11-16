import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['sidebar', 'sidebarExtended', 'overlay'];

  connect() {
    if (this.isPreview) {
      this.close();
      this.sidebarExtendedTarget.classList.remove(this.sidebarExClass);
    }
  }

  open() {
    this.sidebarTarget.classList.add(this.sidebarClass);
    this.overlayTarget.classList.remove(this.overlayClass);
  }

  close() {
    this.sidebarTarget.classList.remove(this.sidebarClass);
    this.overlayTarget.classList.add(this.overlayClass);
  }

  toggleExtended() {
    this.sidebarExtendedTarget.classList.toggle(this.sidebarExClass);
  }

  get overlayClass() {
    return 'overlay--hidden';
  }

  get sidebarClass() {
    return 'sidebar--active';
  }

  get sidebarExClass() {
    return 'sidebar__extended__container--active';
  }

  get isPreview() {
    return document.documentElement.hasAttribute('data-turbolinks-preview');
  }
}
