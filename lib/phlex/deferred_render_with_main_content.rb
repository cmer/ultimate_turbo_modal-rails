# frozen_string_literal: true

module Phlex
  module DeferredRenderWithMainContent
    def template(&block)
      output = capture(&block)
      super { unsafe_raw(output) }
    end
  end
end
