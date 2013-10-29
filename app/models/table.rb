class Table < ActiveRecord::Base
  self.table_name = 'tb_table'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner'
  has_one :master, :class_name => 'User', :foreign_key => 'master'
  has_many :sessions

  def self.create_table(name,plrId,isPrivate,descript)
    r = connection.select_all("SELECT create_table('#{name}',#{plrId},#{isPrivate},'#{descript}')")
    r
  end
  def self.find_all_tables()
    r = connection.select_all('SELECT find_all_tables()')
    r
  end
end
