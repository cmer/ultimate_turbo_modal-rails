# frozen_string_literal: true

# A Turbo modal window component to display any kind of content
class UI::Modal < ViewComponent::Base
  # @param padding [Boolean] Whether to add padding around the modal content
  # @param close_button [Boolean] Whether to show a close button
  # @param advance_history [Boolean] Whether to update the browser history when opening and closing the modal
  # @param advance_history_url [String] Override the URL to use when advancing the history
  def initialize(
    padding: true,
    close_button: true,
    advance_history: true,
    advance_history_url: nil
  )
    @padding = padding
    @close_button = close_button
    @advance_history = advance_history
    @advance_history_url = advance_history_url
  end

  def padding?
    !!@padding
  end

  def advance_history?
    !!@advance_history
  end

  def close_button?
    !!@close_button && padding?
  end

  def padding_classes
    c =
      "relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:max-w-3xl"
    c = c + " px-4 pt-5 pb-4 sm:p-6" if padding?
    c = c + " p-2" if !padding?
    c
  end

  def x_button_classes
    "ml-auto inline-flex items-center rounded bg-transparent p-1 text-sm text-gray-400 hover:bg-gray-100 hover:text-gray-900"
  end

  def x_icon_classes
    "w-5 h-5"
  end

  def close_action
    "modal#hideModal"
  end

  def modal_action
    "turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#outsideModalClicked click->modal#outsideModalClicked"
  end

  def overlay_action
    "click->modal#outsideModalClicked"
  end

  def transition_data
    {
      transition_enter: "ease-out duration-300",
      transition_enter_start: "opacity-0",
      transition_enter_end: "opacity-100",
      transition_leave: "ease-in duration-200",
      transition_leave_start: "opacity-100",
      transition_leave_end: "opacity-0"
    }
  end

  def turbo_stream?
    request.format == :turbo_stream
  end

  def turbo_frame?
    request.headers["Turbo-Frame"].present?
  end

  def advance_history_url
    return nil unless advance_history?
    @advance_history_url || request.original_url
  end
end
