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
      # @client
      # auth_token_txter
      p "!!!!!!!!!!!!!!!!!!!!!"
    p @menu
    redirect_to :back
  end

  # def show
  #   @menus = Menu.find_by(hotel_id : params[:id])
  # end

  def edit
  end

  def destroy
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
  end

  private

  def menu_params
    p params
    params.require(:menu).permit(:name, :description)
  end
end
