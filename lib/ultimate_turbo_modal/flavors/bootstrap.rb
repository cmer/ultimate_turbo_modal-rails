# frozen_string_literal: true

module UltimateTurboModal::Flavors
  class Bootstrap < UltimateTurboModal::Base
    DIV_DIALOG_CLASSES = "modal-container"
    DIV_OVERLAY_CLASSES = "modal-backdrop opacity-50"
    DIV_OUTER_CLASSES = "modal d-block"
    DIV_INNER_CLASSES = "modal-dialog"
    DIV_CONTENT_CLASSES = "modal-content"
    DIV_MAIN_CLASSES = "modal-body"
    DIV_HEADER_CLASSES = "modal-header"
    DIV_TITLE_CLASSES = "modal-title"
    DIV_TITLE_H_CLASSES = "modal-title-h"
    DIV_FOOTER_CLASSES = "modal-footer d-block"
    CLOSE_BUTTON_TAG_CLASSES = "btn-close"

    def div_dialog(&)
      div(id:    "modal-container",
          class: self.class::DIV_DIALOG_CLASSES,
          role:  "dialog",
          aria:  {
            labeled_by: "modal-title-h",
            modal: true
          },
          data:  {
            controller: "modal",
            modal_target: "container",
            modal_advance_url_value: advance_url,
            modal_allowed_click_outside_selector_value: allowed_click_outside_selector,
            action: "turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#outsideModalClicked click->modal#outsideModalClicked",
            transition_enter: "fade",
            transition_enter_start: "",
            transition_enter_end: "show",
            transition_leave: "fade",
            transition_leave_start: "show",
            transition_leave_end: "",
            padding: padding?.to_s,
            title: title?.to_s,
            header: header?.to_s,
            close_button: close_button?.to_s,
            header_divider: header_divider?.to_s,
            footer_divider: footer_divider?.to_s
          }, &)
    end

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
