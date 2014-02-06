class User < ActiveRecord::Base
  self.table_name = 'tb_user'


  def self.create_user(name)
    ActiveRecord::Base.transaction do
      connection.execute("SELECT create_user('#{name}')")
    end
  end

  def self.find_user_by_name(name)
    begin
      r = connection.select_all("select find_user_by_name('#{name}')")
      r.rows
    rescue  StandardError => e
      e
    end
  end

  def self.find_user_by_id(plrId)
    begin
      r = connection.select_all("select find_user_by_name('#{name}')")
      r.rows
    rescue  StandardError => e
      e
    end
  end

end
