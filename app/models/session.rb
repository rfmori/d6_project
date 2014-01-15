class Session < ActiveRecord::Base
  self.table_name = 'tb_session'
  has_one :table, :foreign_key => 'mesa_id'
  has_many :posts

  def self.create_session(table_id,is_dynamic,session_name)
    r = connection.select_all("SELECT create_session(#{session_name},#{table_id},#{is_dynamic})")
    r
  end

  def self.open_session
    connection.execute("SELECT open_session('#{self['id']}')")
  end

  def self.close_session
    connection.execute("SELECT close_session('#{self['id']}')")
  end

  def self.get_sessions_by_table(table_id)
    r = connection.select_all("SELECT get_sessions_by_table(#{table_id})")
    a = []
    r.each do |s|
      v = s['get_sessions_by_table'].split(',')
      v[0]=v[0].gsub('(','')
      v[v.length-1]=v[v.length-1].gsub(')','')
      a.push(v)
    end
    a
  end
end
