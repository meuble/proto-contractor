# coding: utf-8

class UsersController < ApplicationController

  def create
    console(request.format)
    if params["accessToken"]
      respond_to do |format|
        format.all{ render json: { user_id: params["userID"] } }
      end
    else
      @user = User.new(params[:user])
      respond_to do |format|
        if @user.save
          format.html { redirect_to root_url(tab: :users), notice: "Utilisateur enregistré" }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { redirect_to root_url(tab: :register), notice: @user.errors.full_messages.join(" - ") }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
end
