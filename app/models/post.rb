class Post < ActiveRecord::Base
  self.table_name = 'tb_post'
  belongs_to :user, :foreign_key => 'user_id'
  has_one :session, :foreign_key => 'sessao_id'

  def post_message(ses_id, plr_id,message,status)
    r = connection.select_all("SELECT post_message('#{ses_id}',#{plr_id},#{message},#{status})")
    r
  end
end
