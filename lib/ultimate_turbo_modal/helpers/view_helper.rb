module UltimateTurboModal::Helpers
  module ViewHelper
    def modal(**)
      render UltimateTurboModal.new(request:, **) do
        yield
      end
    end
  end
end
