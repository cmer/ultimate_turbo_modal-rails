module TurboModal
  module Controller
    extend ActiveSupport::Concern

    def inside_modal?
      request.headers["Turbo-Frame"] == "modal"
    end

    included do
      helper_method :inside_modal?
    end
  end
end

require_relative 'stream_helper'
