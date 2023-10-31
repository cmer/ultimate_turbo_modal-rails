# frozen_string_literal: true

require_relative "ultimate_turbo_modal/version"
require "ultimate_turbo_modal/railtie"
require "ultimate_turbo_modal/base"
Dir[File.join(__dir__, "ultimate_turbo_modal/flavors", "*.rb")].sort.each do |file|
  require file
end

module UltimateTurboModal
  extend self

  DEFAULT_FLAVOR = :tailwind

  def new(**)
    modal_class.new(**)
  end

  def modal_class
    "UltimateTurboModal::Flavors::#{flavor.to_s.classify}".constantize
  end

  def flavor=(flavor)
    @flavor = flavor
  end

  def flavor
    defined?(@flavor) ? @flavor&.to_sym : DEFAULT_FLAVOR
  end

  class Error < StandardError; end
end
