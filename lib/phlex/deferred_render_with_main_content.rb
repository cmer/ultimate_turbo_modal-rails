module Phlex
  module DeferredRenderWithMainContent
    def template(&)
      output = capture(&)
      super { unsafe_raw(output) }
    end
  end
end
