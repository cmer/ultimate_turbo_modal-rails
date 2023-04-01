// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"

import { Turbo } from "@hotwired/turbo-rails";
import morphdom from "morphdom";
import "controllers";

window.Turbo = Turbo;

// Handle frame-missing events gracefully for redirects, like in Turbo 7.2
document.addEventListener("turbo:frame-missing", function (event) {
  if (event.detail.response.redirected) {
    event.preventDefault()
    event.detail.visit(event.detail.response)
  }
})

// Morphdom Turbo Frame rendering to allow navigation within Turbo Frames
// without having to teardown the entire frame. This is needed to prevent
// the leaving and entering animations from repeating when navigating
// within the modal. You could optionally not use the code below if you
// do not intend to allow navigation within the modal.
addEventListener("turbo:before-frame-render", (event) => {
  event.detail.render = (currentElement, newElement) => {
    morphdom(currentElement, newElement, {
      childrenOnly: true,
      onBeforeElUpdated: (fromEl, toEl) => !fromEl.isEqualNode(toEl)
    })
  }
})
