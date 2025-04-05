import UltimateTurboModalController from './modal_controller';
import './styles/vanilla.css';

function setupUltimateTurboModal(application) {
  // Register the Stimulus controller
  application.register("modal", UltimateTurboModalController);

  // Set up Turbo.StreamActions.modal function
  Turbo.StreamActions.modal = function () {
    const message = this.getAttribute("message");
    if (message == "hide") window.modal?.hide();
    if (message == "close") window.modal?.hide();
  };

  // Ensure dialog is shown after Turbo frame updates
  document.addEventListener("turbo:frame-render", function (event) {
    if (event.target && event.target.id === "modal") {
      // Find dialog element that may have been just added
      const dialog = event.target.querySelector('dialog[data-controller="modal"]');
      if (dialog && dialog instanceof HTMLDialogElement && !dialog.open) {
        // Give a small delay to allow DOM to settle
        setTimeout(() => {
          if (!dialog.open && document.body.contains(dialog)) {
            try {
              dialog.showModal();
            } catch (e) {
              console.warn("Could not show modal dialog after frame render:", e);
            }
          }
        }, 10);
      }
    }
  });

  // Escape modal from the backend on redirects
  document.addEventListener("turbo:frame-missing", function (event) {
    if (event.detail.response.redirected &&
      event.target == document.querySelector("turbo-frame#modal")) {
      event.preventDefault()
      event.detail.visit(event.detail.response)
    }
  });
}

export default setupUltimateTurboModal;
