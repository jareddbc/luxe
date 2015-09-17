class HotelsController < ApplicationController

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(params[:hotel])
    if @hotel.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
  end

  def destroy
  end

end
