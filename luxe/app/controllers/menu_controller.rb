class MenuController < ApplicationController
  def index
    redirect_to hotel_path
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save
      @menu.hotel_id = session[:hotel_id]
      @menu.save
    redirect_to :back
  end

  def show
    @menus = Menu.find_by(hotel_id: params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
    @menu.update_attributes(:name => params[:name], :description => params[:description])
    redirect_to guest_path
  end

  def destroy
     p params
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
    redirect_to :back
  end

  private

  def menu_params
    p params
    params.require(:menu).permit(:name, :description)
  end
end
