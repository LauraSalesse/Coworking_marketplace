class DesksController < ApplicationController
  before_action :authenticate_user!

  def index
    @desks = Desk.all.order(created_at: :desc)
  end

  def new
    @desk = current_user.desks.build
  end

  def create
    @desk = current_user.desks.build(desk_params)
    if @desk.save
      redirect_to desks_path, notice: "Your listing was successfully created."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new
    end
  end

  private

  def desk_params
    params.require(:desk).permit(:description, :address, :location, :shared)
  end
end
