module UltimateTurboModal::Flavors
  class Tailwind < UltimateTurboModal::Base
    def footer(&block)
      @footer = block
    end

    private

    def modal(&)
      div_dialog do
        div_overlay
        div_outer do
          div_inner do
            div_content do
              div_header do
                div_title
                button_close
              end
              div_main(&)
              div_footer if footer?
            end
          end
        end
      end
    end

    def div_dialog(&)
      div(id: "modal-container",
        class: "relative group",
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
          close_button: close_button?.to_s,
          header_divider: header_divider?.to_s,
          footer_divider: footer_divider?.to_s
        }, &)
    end

    def div_overlay
      div(id: "modal-overlay",
        class: "fixed inset-0 bg-gray-900 bg-opacity-50 transition-opacity dark:bg-opacity-80 z-40",
        data: {
          modal_target: "overlay",
          action: "click->modal#outsideModalClicked"
        })
    end

    def div_outer(&)
      div(id: "modal-outer",
        class: "fixed inset-0 z-50 overflow-y-auto sm:max-w-[80%] md:max-w-3xl sm:mx-auto m-4",
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

    def div_content(&)
      div(id: "modal-content",
        class: "relative transform overflow-hidden rounded-lg bg-white text-left shadow transition-all
                sm:my-8 sm:max-w-3xl dark:bg-gray-800",
        data: {
          modal_target: "content"
        },
      &)
    end

    def div_main(&)
      div(id: "modal-main", class: "group-data-[padding=true]:p-4 group-data-[padding=true]:pt-2", &)
    end

    def div_header(&)
      div(id: "modal-header",
        class: "flex justify-between items-center py-4 rounded-t dark:border-gray-600 group-data-[header-divider=true]:border-b",
        &)
    end

    def div_title
      div(id: "modal-title", class: "text-lg font-semibold text-gray-900 dark:text-white pl-4") do
        h3(id: "modal-title-h", class: "group-data-[title=false]:hidden") { @title }
      end
    end

    def div_footer
      div(id: "modal-footer",
        class: "flex justify-end items-center py-4 rounded-b dark:border-gray-600 group-data-[footer-divider=true]:border-t")
    end

    def button_close
      div(class: "mr-4") do
        button(type: "button",
          aria: {label: "close"},
          class: "text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 mt-1.5 mr-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white",
          data: {
            action: "modal#hideModal"
          }) do
            icon_close
            span(class: "sr-only") { "Close modal" }
          end
      end
    end

    def icon_close
      svg(class: "w-5 h-5", fill: "currentColor", viewBox: "0 0 20 20") do |s|
        s.path(
          fill_rule: "evenodd",
          d: "M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z",
          clip_rule: "evenodd"
        )
      end
    end
  end
end
