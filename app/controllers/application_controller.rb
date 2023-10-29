class ApplicationController < ActionController::Base
  include TurboModal::Controller

  def set_modal_properties
    @padding = !(params[:padding] == "0")
    @advance_history = params[:advance] == "1"
    @override_url = request.url.split("?").first if @advance_history
  end
end
