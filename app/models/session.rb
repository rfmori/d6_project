class Session < ActiveRecord::Base
  self.table_name = 'tb_session'
  has_one :table, :foreign_key => 'mesa_id'
  has_many :posts
end
