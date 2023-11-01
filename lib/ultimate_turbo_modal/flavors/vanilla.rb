module UltimateTurboModal::Flavors
  class Vanilla < UltimateTurboModal::Base
    private

    def modal(&)
      div_dialog do
        div_overlay
        div_outer_container do
          div_inner_container do
            div_border do
              button_close if close_button?
              yield
            end
          end
        end
      end
    end

    def div_dialog(&)
      div(id: "modal-container",
        class: "modal-container",
        role: "dialog",
        aria: {
          labeled_by: "modal-title",
          modal: true
        },
        data: {
          controller: "modal",
          modal_target: "container",
          modal_advance_url_value: advance_url,
          action: "turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#outsideModalClicked click->modal#outsideModalClicked",
          transition_enter: "ease-out duration-300",
          transition_enter_start: "opacity-0",
          transition_enter_end: "opacity-100",
          transition_leave: "ease-in duration-200",
          transition_leave_start: "opacity-100",
          transition_leave_end: "opacity-0"
        }, &)
    end

    def div_overlay(&)
      div(id: "modal-overlay",
        class: "modal-overlay",
        data: {
          modal_target: "overlay",
          action: "click->modal#outsideModalClicked"
        })
    end

    def div_outer_container(&)
      div(id: "modal-outer",
        class: "modal-outer",
        data: {
          modal_target: "modal"
        }, &)
    end

    def div_inner_container(&)
      div(id: "modal-inner",
        class: "modal-inner",
        data: {
          modal_target: "innerModal"
        }, &)
    end

    def div_border(&)
      klass = "modal-border"
      klass = "#{klass} modal-padding" if @padding == true
      klass = "#{klass} #{@padding}" if @padding.is_a?(String)
      div(id: "modal-border", class: klass, &)
    end

    def button_close(&)
      div(class: "modal-close") do
        button(type: "button",
          aria: {label: "close"},
          data: {
            action: "modal#hideModal"
          }) { icon_close }
      end
    end

    def icon_close
      svg(
        xmlns: "http://www.w3.org/2000/svg",
        fill: "none",
        viewbox: "0 0 24 24",
        stroke_width: "1.5",
        stroke: "currentColor",
      ) do |s|
        s.path(
          stroke_linecap: "round",
          stroke_linejoin: "round",
          d: "M6 18L18 6M6 6l12 12"
        )
      end
    end
  end
end
