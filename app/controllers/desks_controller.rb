class DesksController < ApplicationController
  def index
    @desks = Desk.all
  end

  # used to show one specific desk:
  def show
    @desk = Desk.find(params[:id])
  end

  def new
    @desk = Desk.new
  end

  def create
    @desk = Desk.new(desk_params)
    @desk.user = current_user #"Devise" gives us access to current_user automatically when someone is signed in
    if @desk.save
      redirect_to desks_path
    else
      render :new #if doesn't work, it just shows the form again
    end
  end

  private

  def desk_params
    params.require(:desk).permit(:title, :description, :price, :address, :location, :shared, photos: [])
  end
end
