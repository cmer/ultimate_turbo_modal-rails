module UltimateTurboModal::Helpers
  module StreamHelper
    def modal(message)
      case message.to_s.downcase.to_sym
      when :close, :hide
        turbo_stream_action_tag "modal", message: "hide"
      else
        raise ArgumentError, "Unknown modal message: #{message}"
      end
    end
  end
end
