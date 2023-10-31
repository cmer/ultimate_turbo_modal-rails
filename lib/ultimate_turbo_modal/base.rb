class UltimateTurboModal::Base < Phlex::HTML
  INCLUDES = %w[
    Turbo::FramesHelper
    Turbo::StreamsHelper
    Phlex::Rails::Helpers::ContentTag
    Phlex::Rails::Helpers::Routes
    Phlex::Rails::Helpers::Tag
  ].freeze

  # @param padding [Boolean] Whether to add padding around the modal content
  # @param close_button [Boolean] Whether to show a close button.
  # @param advance [Boolean] Whether to update the browser history when opening and closing the modal
  # @param advance_url [String] Override the URL to use when advancing the history
  # @param request [ActionDispatch::Request] The current Rails request object
  def initialize(padding: true, close_button: true, advance: true, request: nil)
    @padding = padding
    @close_button = close_button
    @advance = advance
    @advance_url = advance if advance && advance.is_a?(String)
    @request = request

    self.class.include Turbo::FramesHelper
    self.class.include Turbo::StreamsHelper
    self.class.include Phlex::Rails::Helpers::ContentTag
    self.class.include Phlex::Rails::Helpers::Routes
    self.class.include Phlex::Rails::Helpers::Tag
  end

  def template(&)
    if turbo_frame?
      turbo_frame_tag("modal") { modal(&) }
    elsif turbo_stream?
      Turbo::StreamsHelper.turbo_stream_action_tag("update", target: "modal") do
        template { modal(&) }
      end
    else
      modal(&)
    end
  end

  private

  attr_accessor :request

  def padding?
    !!@padding
  end

  def advance?
    !!@advance
  end

  def close_button?
    !!@close_button
  end

  def turbo_stream?
    !!request&.format&.turbo_stream?
  end

  def turbo_frame?
    !!request&.headers&.key?("Turbo-Frame")
  end

  def turbo?
    turbo_stream? || turbo_frame?
  end

  def advance_url
    return nil unless advance?
    @advance_url || request.original_url
  end

  def method_missing(method, *, &block)
    INCLUDES.each { |mod| include_if_defined(mod) }

    if self.class.method_defined?(method)
      send(method, *, &block)
    else
      super
    end
  end

  def include_if_defined(mod_str)
    if defined?(mod.constantize) && !self.class.included_modules.include?(mod.constantize)
      self.class.include mod.constantize
    end
  end

  def respond_to_missing?(method, include_private = false)
    self.class.included_modules.any? { |mod| mod.instance_methods.include?(method) } || super
  end
end
