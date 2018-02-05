class ProgressController < ApplicationController
  before_action :authenticate_user!

  def progress
    progress = current_user.progresses.find params[:id]
    render json: progress
  end

  def machine
    new_machine = current_user.new_machines.find params[:id]
    render json: new_machine
  end
end
