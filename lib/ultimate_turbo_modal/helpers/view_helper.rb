# frozen_string_literal: true

module UltimateTurboModal::Helpers
  module ViewHelper
    def modal(**, &)
      render(UltimateTurboModal.new(request:, **), &)
    end
  end
end
