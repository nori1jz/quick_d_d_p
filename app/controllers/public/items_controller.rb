class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
    @favorite = Favorite.new
  end
  
  def show
    @item = Item.find(params[:id])
    @favorite = Favorite.new
  end
  
end
