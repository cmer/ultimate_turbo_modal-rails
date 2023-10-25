import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["modal", "overlay", "container", "innerModal"]
  static values = { advanceHistoryUrl: String }

  connect() {
    let _this = this
    this.showModal()

    this.turboFrame = this.element.closest('turbo-frame');

    // hide modal when back button is pressed
    window.addEventListener('popstate', function (event) {
      if (_this.#hasHistoryAdvanced()) _this.#resetModalElement()
    })
  }

  showModal() {
    enter(this.containerTarget)
    this.#lockBodyScroll()

    if (this.advanceHistoryUrlValue && !this.#hasHistoryAdvanced()) {
      this.#setHistoryAdvanced()
      history.pushState({}, "", this.advanceHistoryUrlValue)
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
    this.#unlockBodyScroll()

    event = new Event('modal:closed', { cancelable: false })
    this.turboFrame.dispatchEvent(event)

    if (this.#hasHistoryAdvanced())
      history.back()
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) this.hideModal()
  }

  // hide modal when clicking ESC
  // action: "keyup@window->modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") this.hideModal()
  }

  // hide modal when clicking outside of modal
  // action: "click@window->modal#outsideModalClicked"
  outsideModalClicked(e) {
    if (e.target == this.overlayTarget || e.target == this.innerModalTarget)
      this.hideModal()
  }

  #resetModalElement() {
    leave(this.containerTarget).then(() => {
      this.turboFrame.removeAttribute("src")
      this.containerTarget.remove()
      this.#resetHistoryAdvanced()
    })
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

  #lockBodyScroll() {
    document.body.style.overflow = "hidden"
  }

  #unlockBodyScroll() {
    document.body.style.overflow = "auto"
  }
}
