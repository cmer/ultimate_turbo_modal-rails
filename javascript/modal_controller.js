import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["container", "content"]
  static values = {
    advanceUrl: String,
    allowedClickOutsideSelector: String
  }

  connect() {
    let _this = this

    // Use setTimeout to ensure this runs after the current call stack is cleared
    // This ensures the dialog element is fully in the DOM before trying to show it
    setTimeout(() => {
      this.showModal()
    }, 0)

    this.turboFrame = this.element.closest('turbo-frame');

    // hide modal when back button is pressed
    window.addEventListener('popstate', function (event) {
      if (_this.#hasHistoryAdvanced()) _this.#resetModalElement()
    })

    // Listen for the cancel event on the dialog (triggered by ESC key)
    this.containerTarget.addEventListener('cancel', (event) => {
      // We'll handle the event in our own way
      event.preventDefault()
      this.hideModal()
    })

    window.modal = this
  }

  disconnect() {
    window.modal = undefined
  }

  showModal() {
    // Make sure the element is a dialog and is in the DOM
    if (this.containerTarget instanceof HTMLDialogElement && document.body.contains(this.containerTarget)) {
      // Use native dialog method to show modal
      try {
        this.containerTarget.showModal()

        if (this.advanceUrlValue && !this.#hasHistoryAdvanced()) {
          this.#setHistoryAdvanced()
          history.pushState({}, "", this.advanceUrlValue)
        }
      } catch (error) {
        console.error('Error showing modal dialog:', error)
        // If showModal fails (e.g., dialog already open), try reopening it
        if (this.containerTarget.open) {
          this.containerTarget.close()
          // Try again after a brief delay
          setTimeout(() => {
            this.containerTarget.showModal()
          }, 10)
        }
      }
    } else {
      console.warn('Modal container is not a dialog element or not in DOM yet')
    }
  }

  // if we advanced history, go back, which will trigger
  // hiding the model. Otherwise, hide the modal directly.
  hideModal() {
    // Prevent multiple calls to hideModal.
    // Sometimes some events are double-triggered.
    if (this.hidingModal) return
    this.hidingModal = true

    let event = new Event('modal:closing', { cancelable: true })
    this.turboFrame.dispatchEvent(event)
    if (event.defaultPrevented) return

    this.#resetModalElement()

    event = new Event('modal:closed', { cancelable: false })
    this.turboFrame.dispatchEvent(event)

    if (this.#hasHistoryAdvanced())
      history.back()
  }

  hide() {
    this.hideModal()
  }

  refreshPage() {
    window.Turbo.visit(window.location.href, { action: "replace" })
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) this.hideModal()
  }

  outsideModalClicked(e) {
    let clickedInsideModal = this.contentTarget.contains(e.target) || this.contentTarget == e.target
    let clickedAllowedSelector = e.target.closest(this.allowedClickOutsideSelectorValue) != null

    if (!clickedInsideModal && !clickedAllowedSelector)
      this.hideModal()
  }

  #resetModalElement() {
    // Use native dialog method to close
    if (this.containerTarget instanceof HTMLDialogElement && this.containerTarget.open) {
      this.containerTarget.close()
    }

    // Clean up
    this.turboFrame.removeAttribute("src")
    this.#resetHistoryAdvanced()

    // Reset the modal state
    this.hidingModal = false
  }

  #hasHistoryAdvanced() {
    return document.body.getAttribute("data-turbo-modal-history-advanced") == "true"
  }

  #setHistoryAdvanced() {
    return document.body.setAttribute("data-turbo-modal-history-advanced", "true")
  }

  #resetHistoryAdvanced() {
    document.body.removeAttribute("data-turbo-modal-history-advanced")
  }
}

Turbo.StreamActions.modal = function () {
  const message = this.getAttribute("message")

  if (message == "hide") window.modal?.hide()
  if (message == "close") window.modal?.hide()
}
