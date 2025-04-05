# frozen_string_literal: true

module UltimateTurboModal::Flavors
  class Vanilla < UltimateTurboModal::Base
    DIALOG_CLASSES = "modal-container p-0 border-none bg-transparent max-width-full max-height-full width-auto height-auto margin-0"
    CONTENT_WRAPPER_CLASSES = "modal-content"
    MAIN_CLASSES = "modal-main"
    HEADER_CLASSES = "modal-header"
    TITLE_CLASSES = "modal-title"
    TITLE_H_CLASSES = "modal-title-h"
    FOOTER_CLASSES = "modal-footer"
    BUTTON_CLOSE_CLASSES = "modal-close"
    BUTTON_CLOSE_SR_ONLY_CLASSES = "sr-only"
    CLOSE_BUTTON_TAG_CLASSES = "modal-close-button"
    ICON_CLOSE_CLASSES = "modal-close-icon"
  end
end
