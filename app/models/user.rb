class User < ActiveRecord::Base
  self.table_name = 'tb_user'

  def self.create_user(name)
    ActiveRecord::Base.transaction do
      connection.execute("SELECT * from create_user('#{name}')")
    end
  end

  def self.find_user_by_name(name)
    begin
      r = connection.select_all("select * from find_user_by_name('#{name}')")
      r[0]
    rescue  StandardError => e
      e
    end
  end

  def self.find_user_by_id(plrId)
    begin
      r = connection.select_all("select * from find_user_by_name('#{plrId}')")
      r[0]
    rescue  StandardError => e
      e
    end
  end

end
