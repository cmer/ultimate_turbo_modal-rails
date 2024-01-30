require "rails"
require "rails/railtie"
require "phlex-rails"
require "turbo-rails"
require "ultimate_turbo_modal/helpers/controller_helper"
require "ultimate_turbo_modal/helpers/view_helper"
require "ultimate_turbo_modal/helpers/stream_helper"

module UltimateTurboModal
  class Railtie < Rails::Railtie
    initializer "ultimate_turbo_modal.action_controller" do
      ActiveSupport.on_load(:action_controller_base) do
        include UltimateTurboModal::Helpers::ControllerHelper
      end
    end

    initializer "ultimate_turbo_modal.action_view" do
      ActiveSupport.on_load(:action_view) do
        include UltimateTurboModal::Helpers::ViewHelper
      end
      Turbo::Streams::TagBuilder.include(UltimateTurboModal::Helpers::StreamHelper)
    end
  end
end
