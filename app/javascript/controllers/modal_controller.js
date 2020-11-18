import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['opener', 'body', 'container', 'overlay'];

  showModal() {
    this.containerTarget.classList.remove(this.toggleClass);
    this.animateModal;
  }

  hideModal() {
    this.stopAnimation;
    setTimeout(() => {
      this.containerTarget.classList.add(this.toggleClass);
    }, 100);
  }

  onOutsideClick(e) {
    if (
      !this.openerTarget.contains(e.target) &&
      !this.bodyTarget.contains(e.target)
    ) {
      this.hideModal();
    }
  }

  get animateModal() {
    this.bodyTarget.classList.add('animation--scale');
    this.overlayTarget.classList.add('animation--opacity');
  }

  get stopAnimation() {
    this.bodyTarget.classList.remove('animation--scale');
    this.overlayTarget.classList.remove('animation--opacity');
  }

  get toggleClass() {
    return 'modal--hidden';
  }
}
