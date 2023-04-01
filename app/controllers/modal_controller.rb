class ModalController < ApplicationController
  before_action :set_modal_properties

  def index
    @post = Post.first
  end
end
