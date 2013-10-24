class Table < ActiveRecord::Base
  self.table_name = 'tb_table'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner'
  has_one :master, :class_name => 'User', :foreign_key => 'master'
  has_many :sessions
end
