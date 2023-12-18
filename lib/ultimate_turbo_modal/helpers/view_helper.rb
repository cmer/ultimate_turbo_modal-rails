# frozen_string_literal: true

module UltimateTurboModal::Helpers
  module ViewHelper
    def modal(**kwargs, &)
      render(UltimateTurboModal.new(request:, **kwargs), &)
    end
  end
end
