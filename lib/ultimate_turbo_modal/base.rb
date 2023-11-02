class UltimateTurboModal::Base < Phlex::HTML
  # @param padding [Boolean] Whether to add padding around the modal content
  # @param close_button [Boolean] Whether to show a close button.
  # @param advance [Boolean] Whether to update the browser history when opening and closing the modal
  # @param advance_url [String] Override the URL to use when advancing the history
  # @param request [ActionDispatch::Request] The current Rails request object
  def initialize(
    padding: UltimateTurboModal.configuration.padding,
    close_button: UltimateTurboModal.configuration.close_button,
    advance: UltimateTurboModal.configuration.advance,
    request: nil
  )
    @padding = padding
    @close_button = close_button
    @advance = !!advance
    @advance_url = advance if advance.present? && advance.is_a?(String)
    @request = request

    unless self.class.include?(Turbo::FramesHelper)
      self.class.include Turbo::FramesHelper
      self.class.include Turbo::StreamsHelper
      self.class.include Phlex::Rails::Helpers::ContentTag
      self.class.include Phlex::Rails::Helpers::Routes
      self.class.include Phlex::Rails::Helpers::Tag
    end
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

  def include_if_defined(mod_str)
    if defined?(mod.constantize) && !self.class.included_modules.include?(mod.constantize)
      self.class.include mod.constantize
    end
  end

  def respond_to_missing?(method, include_private = false)
    self.class.included_modules.any? { |mod| mod.instance_methods.include?(method) } || super
  end
end
