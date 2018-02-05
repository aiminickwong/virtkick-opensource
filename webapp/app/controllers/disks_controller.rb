class DisksController < ApplicationController
  include FindMachine
  find_machine_before_action :machine_id


  def index
    redirect_to machine_path @machine, anchor: 'storage'
  end

  def show
    index
  end

  def create
    disk_params = params.require(:disk).permit(:size_plan, :type)
    render_progress DiskCreateJob.perform_later current_user, @meta_machine.id, disk_params
  end

  def destroy
    render_progress DiskDeleteJob.perform_later current_user, @meta_machine.id, params[:id]
  end
end
