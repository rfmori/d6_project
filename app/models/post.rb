class Post < ActiveRecord::Base
  self.table_name = 'tb_post'
  belongs_to :user, :foreign_key => 'user_id'
  has_one :session, :foreign_key => 'sessao_id'
end
