# coding: utf-8
class MessagesController < ApplicationController
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html { redirect_to :new }
    end
  end

  def create
    if params[:source]
      Contractor::Twittos.notify(params[:user_id], params[:message]) if params[:source] == :twitter
      Contractor::Faceboobs.notify(params[:user_id], params[:message]) if params[:source] == :facebook
      notice = "message “#{params[:message]}” envoyé à #{params[:user_id]}"
    elsif params[:message] && params[:message][:body].present?
      Contractor.notify(params[:message][:body])
      notice = "message envoyé: “#{params[:message][:body]}” à #{User.all.map(&:uid).join(" - ")}"
    end
    
    respond_to do |format|
      format.html { redirect_to root_url, notice: notice }
    end
  end
  
  
  # GET /users/new
  # GET /users/new.json
  def new
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

end
