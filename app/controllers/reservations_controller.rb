class ReservationsController < ApplicationController
  before_action :redirect_login
  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def new
    @room = Room.find(params[:room_id])
    @user = User.find(@room.user_id)
    @reservation = Reservation.new
  end

  def confirm_new
    @reservation = current_user.reservations.new(reservation_params)
    @room = Room.find(@reservation.room_id)
    @user = User.find(@room.user_id)
    unless @reservation.valid?
      render "new"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
    flash[:notice] = "予約を確定しました"
    redirect_to reservation_path(@reservation.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = Room.find(@reservation.room_id)
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "#{@reservation.room.name}(#{@reservation.start_date})の予約を取り消しました"
    redirect_to :reservations
  end

  private
  def reservation_params
    params.require(:reservation).permit(
      :start_date,
      :end_date,
      :number,
      :user_id,
      :room_id)
  end
end
