class PrototypesController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  before_action :re_direct_toppage, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit

  end

  def update

    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    
    if @prototype.destroy
    redirect_to root_path
    else
      render :show
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.all
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def re_direct_toppage
    redirect_to root_path unless current_user.id == @prototype.user.id
  end

end