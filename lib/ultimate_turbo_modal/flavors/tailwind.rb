module UltimateTurboModal::Flavors
  class Tailwind < UltimateTurboModal::Base
    private

    def modal(&)
      div_dialog do
        div_overlay
        div_outer do
          div_inner do
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
        class: "relative z-10",
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
        class: "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity",
        data: {
          modal_target: "overlay",
          action: "click->modal#outsideModalClicked"
        })
    end

    def div_outer(&)
      div(id: "modal-outer",
        class: "fixed inset-0 z-10 overflow-y-auto sm:max-w-[80%] md:max-w-3xl sm:mx-auto m-4",
        data: {
          modal_target: "modal"
        }, &)
    end

    def div_inner(&)
      div(id: "modal-inner",
        class: "flex min-h-full items-center justify-center p-1 sm:p-4",
        data: {
          modal_target: "innerModal"
        }, &)
    end

    def div_border(&)
      klass = "relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:max-w-3xl"
      klass = "#{klass} p-2 sm:p-4 md:p-6" if @padding == true
      klass = "#{klass} #{@padding}" if @padding.is_a?(String)
      div(id: "modal-border", class: klass, &)
    end

    def button_close(&)
      div(class: "absolute top-3 right-3") do
        button(type: "button",
          aria: {label: "close"},
          class: "ml-auto inline-flex items-center rounded bg-transparent p-1 text-sm text-gray-400 bg-white bg-opacity-20 hover:bg-gray-100 hover:bg-opacity-70 hover:text-gray-900",
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
        class: "w-5 h-5"
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
