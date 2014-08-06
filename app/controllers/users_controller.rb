class UsersController < ApplicationController
  def create_user
    begin
      User::create_user(params['name'])
      render :text => "OK"
    rescue
      render :text => "NOT OK"
    end
  end

  def find_user_by_name(plrName)
    begin
      r = User::find_user_by_name(plrName)
      return  r
    rescue
      return  "NOT OK"
    end
  end

  def index
    @usr = User.new
  end

  def new
  end

  def create
    redirect_to :logon, params
  end

  def logon
    p = params[:user]['name']
    @messages = params[:messages]
    @user = User::find_user_by_name(p)
    if(!@user)
      render :text => 'Usuário não encontrado!'
    else
      @tables =  Table::find_table_by_player_id(@user['id'])
      session[:user_id] = @user['id']
      session[:user_name] = @user['name']
    end
  end

  def create_table

  end
end