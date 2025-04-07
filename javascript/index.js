import UltimateTurboModalController from './modal_controller.js';
import { Idiomorph } from 'idiomorph';
import './styles/vanilla.css';

Turbo.StreamActions.modal = function () {
  const message = this.getAttribute("message");
  if (message == "hide") window.modal?.hide();
  if (message == "close") window.modal?.hide();
};

// Escape modal from the backend on redirects
const handleTurboFrameMissing = (event) => {
  if (event.detail.response.redirected &&
    event.target == document.querySelector("turbo-frame#modal")) {
    event.preventDefault()
    event.detail.visit(event.detail.response)
  }
};

// Morph the innerHTML of the modal to prevent flickering and transition animations
const handleTurboBeforeFrameRender = (event) => {
  if (event.target.id === "modal") {
    event.detail.render = (currentElement, newElement) => {
      Idiomorph.morph(currentElement, newElement, {
        morphstyle: 'innerHTML'
      })
    }
  }
};

document.removeEventListener("turbo:frame-missing", handleTurboFrameMissing);
document.addEventListener("turbo:frame-missing", handleTurboFrameMissing);

document.removeEventListener("turbo:before-frame-render", handleTurboBeforeFrameRender);
document.addEventListener("turbo:before-frame-render", handleTurboBeforeFrameRender);

export { UltimateTurboModalController };
