module UltimateTurboModal::Flavors
  class Vanilla < UltimateTurboModal::Base

    private

    def modal(&)
      outer_divs do
        div_content do
          div_header
          div_main(&)
          div_footer if footer?
        end
      end
    end

    def outer_divs(&)
      div_dialog do
        div_overlay
        div_outer do
          div_inner(&)
        end
      end
    end

    def div_dialog(&)
      div(id: "modal-container",
        class: "modal-container",
        role: "dialog",
        aria: {
          labeled_by: "modal-title-h",
          modal: true
        },
        data: {
          controller: "modal",
          modal_target: "container",
          modal_advance_url_value: advance_url,
          action: "turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#outsideModalClicked click->modal#outsideModalClicked",
          transition_enter: "ease-out duration-100",
          transition_enter_start: "opacity-0",
          transition_enter_end: "opacity-100",
          transition_leave: "ease-in duration-50",
          transition_leave_start: "opacity-100",
          transition_leave_end: "opacity-0",
          padding: padding?.to_s,
          title: title?.to_s,
          header: header?.to_s,
          close_button: close_button?.to_s,
          header_divider: header_divider?.to_s,
          footer_divider: footer_divider?.to_s
        }, &)
    end

    def div_overlay
      div(id: "modal-overlay", class: "modal-overlay")
    end

    def div_outer(&)
      div(id: "modal-outer", class: "modal-outer", &)
    end

    def div_inner(&)
      div(id: "modal-inner", class: "modal-inner", &)
    end

    def div_content(&)
      div(id: "modal-content", class: "modal-content", data: {modal_target: "content"}, &)
    end

    def div_main(&)
      div(id: "modal-main", class: "modal-main", &)
    end

    def div_header(&)
      div(id: "modal-header", class: "modal-header") do
        div_title
        button_close
      end
    end

    def div_title
      div(id: "modal-title", class: "modal-title") do
        h3(id: "modal-title-h", class: "modal-title-h") { @title }
      end
    end

    def div_footer
      div(id: "modal-footer", class: "modal-footer") do
        render @footer
      end
    end

    def button_close
      div(id: "modal-close", class: "modal-close") do
        close_button_tag do
          icon_close
          span(class: "sr-only") { "Close modal" }
        end
      end
    end

    def close_button_tag(&)
      button(type: "button",
        aria: {label: "close"},
        class: "modal-close-button",
        data: {
          action: "modal#hideModal"
        }, &)
    end

    def icon_close
      svg(class: "modal-close-icon", fill: "currentColor", viewBox: "0 0 20 20") do |s|
        s.path(
          fill_rule: "evenodd",
          d: "M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z",
          clip_rule: "evenodd"
        )
      end
    end
  end
end
