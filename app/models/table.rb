class Table < ActiveRecord::Base
  self.table_name = 'tb_table'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner'
  has_one :master, :class_name => 'User', :foreign_key => 'master'
  has_many :sessions

  def self.create_table(name,plrId,isPrivate,descript)
    begin
      r = connection.select_all("SELECT create_table('#{name}',#{plrId},#{isPrivate},'#{descript}')")
      r.rows
    rescue  StandardError => e
      e
    end
  end
  def self.find_all_tables()
    begin
      r = connection.select_all('SELECT find_all_tables()')
      r.rows
    rescue  StandardError => e
      e
    end
  end
  #Se TBL for numérico pega a tabla,
  #se não, compara TBL como se fosse um registro de tabela no banco
  def self.is_master(tbl,plrId)
    begin
      if(tbl.is_a? Numeric)
        t = find_table_by_id(tbl)
        if(t)
          return t.rows[0]['owner'] == plrId
        end
      else
        return tbl['owner'] == plrId
      end
    rescue  StandardError => e
      e
    end
    return false
  end

  def self.find_table_by_id(tblId)
    begin
      r = connection.select_all("SELECT find_table_by_id(#{tblId})")
      r.rows
    rescue  StandardError => e
      e
    end
  end


  def self.invite_player(plrId,tblId)
     begin
       t = find_table_by_id(tblId)
       return nil if(!is_master(t.rows[0],plrId))
       ActiveRecord::Base.transaction do
         r = connection.select_all("SELECT send_player_invite(#{plrId},#{tblId},'W')")
         r
       end
     rescue  StandardError => e
       e
     end
    -1
  end
end
