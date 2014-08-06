class Table < ActiveRecord::Base
  self.table_name = 'tb_table'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner'
  has_one :master, :class_name => 'User', :foreign_key => 'master'
  has_many :sessions

  def create_table
    ActiveRecord::Base.transaction do
      Table::create_table(self.name,self.owner,self.is_private,self.descript)
    end
  end
  def self.create_table(name,plrId,isPrivate,descript)
    begin
      priv = false
      priv = true if isPrivate != 0
      r = connection.select_all("SELECT * from create_table('#{name}',#{plrId},#{priv},'#{descript}')")
      Table::assign_player_to_table(plrId,r.rows[0][0])
      r.rows[0][0]
    rescue  StandardError => e
      e
    end
  end
  def self.assign_player_to_table(plrId,tblId)
      connection.execute("select assign_player_table(#{plrId},#{tblId})")
  end
  def self.find_all_tables()
    begin
      r = connection.select_all('SELECT * from find_all_tables()')
      r
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
      puts e
    end
    return false
  end

  def self.find_table_by_id(tblId)
    begin
      r = connection.select_all("SELECT * from find_table_by_id(#{tblId})")
      r.rows
    rescue  StandardError => e
      e
    end
  end

  def self.find_table_by_player_id(plrId)
    begin
      r = connection.select_all("SELECT * from find_table_by_player_id(#{plrId})")
      r
    rescue  StandardError => e
      e
    end
  end


  def self.invite_player(plrId,tblId)
     begin
       t = find_table_by_id(tblId)
       return -1 if(!is_master(t.rows[0],plrId))
       ActiveRecord::Base.transaction do
         r = connection.select_all("SELECT * from send_player_invite(#{plrId},#{tblId},'W')")
         r
       end
     rescue  StandardError => e
       e
     end
    -1
  end
end
