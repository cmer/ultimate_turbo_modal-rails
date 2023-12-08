# frozen_string_literal: true

module UltimateTurboModal::Flavors
  class Bootstrap < UltimateTurboModal::Base
    DIV_DIALOG_CLASSES = "modal-container"
    DIV_OVERLAY_CLASSES = "modal-backdrop fade show"
    DIV_OUTER_CLASSES = "modal fade show d-block"
    DIV_INNER_CLASSES = "modal-dialog"
    DIV_CONTENT_CLASSES = "modal-content"
    DIV_MAIN_CLASSES = "modal-body"
    DIV_HEADER_CLASSES = "modal-header"
    DIV_TITLE_CLASSES = "modal-title"
    DIV_TITLE_H_CLASSES = "modal-title-h"
    DIV_FOOTER_CLASSES = "modal-footer d-block"
    CLOSE_BUTTON_TAG_CLASSES = "btn-close"

    def div_title
      if @title_block.present?
        send(@title_tag, id: "modal-title", class: self.class::DIV_TITLE_CLASSES) do
          render @title_block
        end
      else
        send(@title_tag, id: "modal-title-h", class: self.class::DIV_TITLE_H_CLASSES) { @title }
      end
    end

    def button_close
      button(type:  "button",
        id:    "modal-close",
        class: self.class::CLOSE_BUTTON_TAG_CLASSES,
        data:  {
          action: @close_button_data_action
        },
        aria:  {label: "Close"})
    end
  end
end
