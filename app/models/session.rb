class Session < ActiveRecord::Base
  self.table_name = 'tb_session'
  has_one :table, :foreign_key => 'mesa_id'
  has_many :posts

  def create_session(table_id,is_dynamic,session_name)
    r = connection.select_all("SELECT create_session('#{session_name}',#{table_id},#{is_dynamic})")
    r
  end

  def open_session
    connection.execute("SELECT open_session('#{self['id']}')")
  end
end
