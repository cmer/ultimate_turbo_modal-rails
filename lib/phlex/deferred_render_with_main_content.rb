# frozen_string_literal: true

module Phlex
  module DeferredRenderWithMainContent
    def view_template(&block)
      output = capture(&block)
      super { unsafe_raw(output) }
    end
  end
end
