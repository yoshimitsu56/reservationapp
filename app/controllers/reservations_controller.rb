class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    @room = Room.find(params[:id])
    @reservation = @room.reservations.new
  end

  def create
    @reservation = @user.reservations.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      flash[:notice] = "予約が完了しました。"
      redirect_to root_path
    else
      flash[:alert] = "予約の保存に失敗しました。"
      render :new
    end
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user_id = current_user.id

    if @reservation.invalid?
      render :new
    else
      @reservation.rev_lengthofstay = stay_duration
      @reservation.rev_finalbill = total_price
    end
  end

  def index
    @reservations = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def stay_duration
    rev_lengthofstay = (@reservation.rev_checkout - @reservation.rev_checkin).to_i
  end

  def total_price
    rev_finalbill = stay_duration * @room.room_fee * @reservation.rev_headcount
  end

  def reservation_params
    params.require(:reservation).permit(:rev_checkin, :rev_checkout, :created_at, :rev_finalbill, :rev_headcount, :room_id, :user_id )
  end

  def set_user
    @user = current_user
  end
end
