class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
    @player_options = Player.all.map{|p| [p.name,p.id]}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @game = Game.create(user_id: @user.id,boss_id: Boss.all.first.id, bosses_defeated: 0, image: "", user_health: @user.player.health, boss_health: Boss.all.first.health)
      redirect_to @game
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:player_id)
  end

end
