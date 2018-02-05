class GuestsController < ApplicationController
  layout 'raw'

  before_action do
    redirect_to machines_path if user_signed_in?
  end


  def index
  end

  def create
    sign_in User.create_guest!
    redirect_to machines_path
  end
end
