class WowgramsController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_wowgram ,only: %i[ show edit update destroy ]
  def index
    @wowgram= Wowgram.where(:user_id=>current_user.id)
  end

  def allpost
    @wowgram= Wowgram.all
  end

  def home
    @wowgram= Wowgram.all
  end

  def follow
    p 2222222222222222222222222222222222222222222222222
    p params
    followed_user_id = params[:id]
    # followed_user_id = params[:format]
    respond_to do |format|
    if Follow.find_by(:followed_user_id=>followed_user_id,:follower_id=>current_user.id).present?
       format.html{ redirect_to userpost_wowgrams_path(followed_user_id),notice:"already followed"}
    else
       Follow.create(:followed_user_id=>followed_user_id,:follower_id=>current_user.id)
       format.html{ redirect_to userpost_wowgrams_path(followed_user_id),notice:"successfully followed"}
    end
    end
  end

  def comment
    @wowgram_id = params[:format]
    @wowgram = Wowgram.find(@wowgram_id)
    @comment = Comment.where(:wowgram_id=>@wowgram_id)
  end

  def submit_comment
     wowgram_id = params[:id]
     comment = params[:uname]
     Comment.create(:comment=>comment,:wowgram_id=>wowgram_id,:user_id=>current_user.id)
     redirect_to comment_wowgrams_path(wowgram_id)
  end

  def userpost
    @user_id=params[:format]
    @wowgram= Wowgram.all.where(:user_id=>@user_id)
  end

  def new
    @wowgram = Wowgram.new
  end

  def show
  end
   
  def create
    @wowgram = Wowgram.new(wowgram_params)
    @wowgram.user_id = current_user.id

    respond_to do |format|
      if @wowgram.save
        format.html { redirect_to :action=>:show, :id=>@wowgram, notice:"created succfully"}
        # format.json { render :show , status: :created}
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @wowgram.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @wowgram.update(wowgram_params)
        format.html { redirect_to :action=>:show, :id=>@wowgram, notice:"updated succfully"}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wowgram.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def destroy
    @wowgram.destroy
    respond_to do |format|
      format.html { redirect_to wowgrams_path, notice: "Wow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private   

  def set_wowgram
    @wowgram = Wowgram.find(params[:id])
  end

  def wowgram_params
    params.require(:wowgram).permit(:description, :body,:picture)
  end

end
