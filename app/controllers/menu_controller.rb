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
    @menu = Menu.find_by(id: params[:id])
  end

  def update
    p params
    @menu = Menu.find(params[:id])
    menu_params = params[:menu]
    @menu.update_attributes(:name => menu_params["name"], :description => menu_params["description"])
    @menu.save
    redirect_to hotels_show_path
  end

  def destroy
      p "********************************"
     p params
     p "********************************"
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
    redirect_to hotels_show_path
  end

  private

  def menu_params
    p params
    params.require(:menu).permit(:name, :description)
  end
end
