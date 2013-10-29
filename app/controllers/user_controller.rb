class UserController < ApplicationController
  def create_user
    begin
      User::create_user(params['name'])
      render :text => "OK"
    rescue
      render :text => "NOT OK"
    end
  end

  def find_user_by_name
    begin
      r = User::find_user_by_name(params['name'])
      render :text => r.to_yaml
    rescue
      render :text => "NOT OK"
    end
  end
end