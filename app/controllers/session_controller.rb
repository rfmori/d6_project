class SessionController < ApplicationController

  def post_message
    begin
      v = Post::post_message()
    rescue  StandardError => e
      render :text => e
    end
  end
end
