class ApplicationController < ActionController::Base
  def inside_modal?
    request.headers["Turbo-Frame"] == "modal"
  end
  helper_method :inside_modal?

  def set_modal_properties
    @frame = !(params[:frame] == "0")
    @advance_history = params[:advance] == "1"
    @override_url = request.url.split("?").first if @advance_history
  end
end
