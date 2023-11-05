class UltimateTurboModal::Base < Phlex::HTML
  # @param padding [Boolean] Whether to add padding around the modal content
  # @param close_button [Boolean] Whether to show a close button.
  # @param advance [Boolean] Whether to update the browser history when opening and closing the modal
  # @param header_divider [Boolean] Whether to show a divider between the header and the main content
  # @param footer_divider [Boolean] Whether to show a divider between the main content and the footer
  # @param title [String] The title of the modal
  # @param request [ActionDispatch::Request] The current Rails request object
  def initialize(
    padding: UltimateTurboModal.configuration.padding,
    close_button: UltimateTurboModal.configuration.close_button,
    advance: UltimateTurboModal.configuration.advance,
    header_divider: UltimateTurboModal.configuration.header_divider,
    footer_divider: UltimateTurboModal.configuration.footer_divider,
    title: nil, request: nil
  )
    @padding = padding
    @close_button = close_button
    @advance = !!advance
    @advance_url = advance if advance.present? && advance.is_a?(String)
    @title = title
    @header_divider = header_divider
    @footer_divider = footer_divider
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
      turbo_frame_tag("modal") do
        modal(&)
      end
    elsif turbo_stream?
      Turbo::StreamsHelper.turbo_stream_action_tag("update", target: "modal") do
        modal(&)
      end
    else
      modal(&)
    end
  end

  private

  attr_accessor :request, :title

  def padding? = !!@padding

  def close_button? = !!@close_button

  def title? = !!@title

  def footer? = !!@footer

  def header_divider? = !!@dividers && title?

  def footer_divider? = !!@dividers && footer?

  def turbo_stream? = !!request&.format&.turbo_stream?

  def turbo_frame? = !!request&.headers&.key?("Turbo-Frame")

  def turbo? = turbo_stream? || turbo_frame?

  def advance? = !!@advance && !!@advance_url

  def advance_url
    return nil unless !!@advance
    @advance_url || request&.original_url
  end

  def respond_to_missing?(method, include_private = false)
    self.class.included_modules.any? { |mod| mod.instance_methods.include?(method) } || super
  end
end
