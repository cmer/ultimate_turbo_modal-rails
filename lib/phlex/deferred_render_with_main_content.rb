# frozen_string_literal: true

module Phlex
  module DeferredRenderWithMainContent
    def view_template(&block)
      output = capture(&block)
      super { respond_to?(:unsafe_raw) ? unsafe_raw(output) : raw(output) }
    end
  end
end
