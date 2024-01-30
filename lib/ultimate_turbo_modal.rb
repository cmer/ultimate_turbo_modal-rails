# frozen_string_literal: true

require_relative "ultimate_turbo_modal/version"
require "phlex/deferred_render_with_main_content"
require "ultimate_turbo_modal/configuration"
require "ultimate_turbo_modal/railtie"
require "ultimate_turbo_modal/base"
Dir[File.join(__dir__, "ultimate_turbo_modal/flavors", "*.rb")].sort.each do |file|
  require file
end

module UltimateTurboModal
  extend self

  def new(**)
    modal_class.new(**)
  end

  def modal_class
    "UltimateTurboModal::Flavors::#{flavor.to_s.classify}".constantize
  end

  class Error < StandardError; end
end
