class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
  end

  def search
    if params[:area].present?
      @rooms = Room.where("room_address LIKE ?", "%#{params[:area]}%")
    elsif params[:word].present?
      @rooms = Room.where("room_name LIKE ? OR room_introduction LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%")
    end
  end

  def create
    @room = Room.new(params.require(:room).permit(:room_name, :room_introduction, :room_fee, :room_address))
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "予約が完了しました。"
      redirect_to root_path
    else
      flash[:alert] = "予約の保存に失敗しました。"
      render :new
    end
  end
end
