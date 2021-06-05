class RoomsController < ApplicationController
  before_action :redirect_login, except: [:search]
  def index
    @user = User.find(current_user.id)
    @rooms = @user.rooms
  end

  def search
    @rooms = Room.all
    if params[:name_key]
      @rooms = Room.where('name LIKE ?', "%#{params[:name_key]}%")
    elsif params[:address_key]
      @rooms = Room.where('address LIKE ?', "%#{params[:address_key]}%")
    else
      @rooms = Room.all
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "#{@room.name}を登録しました。"
      redirect_to :rooms
    else
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "#{@room.name}の情報を更新しました。"
      redirect_to :rooms
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "#{@room.name}を削除しました。"
    redirect_to :rooms
  end

  private
    def room_params
      params.require(:room).permit(:name, :introduction, :price, :address, :image, :user_id)
    end
end
