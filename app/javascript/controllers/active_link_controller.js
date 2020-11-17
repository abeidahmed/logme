import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['link'];

  initialize() {
    this.linkTargets.forEach((el) => {
      const href = el.getAttribute('href');

      if (this.dataExact) {
        if (location.href === href || this.urlLocation === href) {
          el.classList.add(this.activeClass);
        }
      } else {
        if (
          location.href.startsWith(href) ||
          this.urlLocation.startsWith(href)
        ) {
          el.classList.add(this.activeClass);
        }
      }
    });
  }

  get urlLocation() {
    return location.pathname + location.search;
  }

  get activeClass() {
    return this.data.get('class');
  }

  get dataExact() {
    return JSON.parse(this.data.get('exact'));
  }
}
