class User < ActiveRecord::Base
  self.table_name = 'tb_user'


  def self.create_user(name)
    connection.execute("SELECT create_user('#{name}')")
  end

  def self.find_user_by_name(name)
    r = connection.select_all("select find_user_by_name('#{name}')")
    r.rows
  end

end
