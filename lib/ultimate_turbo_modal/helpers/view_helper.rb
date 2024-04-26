# frozen_string_literal: true

module UltimateTurboModal::Helpers
  module ViewHelper
    def modal(**args, &)
      render(UltimateTurboModal.new(request:, **args), &)
    end
  end
end
