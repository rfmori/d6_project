class SessionController < ApplicationController

  def post_message
    begin
    rescue  StandardError => e
      render :text => e
    end
  end
end
