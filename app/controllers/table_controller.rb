class TableController < ApplicationController
  def create_table
    begin
      tb_id = Table::create_table(params['name'],params['plr_id'],params['is_private'],params['descript'])
      render :text => "TABLE ID->#{tb_id.rows[0]}"
    rescue StandardError => e
      render :text => e
    end
  end

  def find_all_tables
    begin
      tbs = Table::find_all_tables()
      render :text => tbs.rows.to_yaml.to_s
    rescue StandardError => e
      render :text => e
    end
  end

  def create_session
    begin
      table_id = params['table_id'].to_i
      session_name = params['name']
      is_dynamic = params['dynamic']
      s_id = Session::create_session(table_id,is_dynamic,session_name)
      render :text => "Session ID->#{s_id.rows[0]}"
    rescue StandardError => e
      render :text => e
    end
  end

  def enter_table
    begin
      table_id = params['table_id'].to_i
      sessions = Session::get_sessions_by_table(table_id)
      str = ''
      sessions.each do |s|
        str +=   "Session: #{s[2].to_s}\n"
      end
      render :text => str
    rescue StandardError => e
      render :text => e
    end
  end

end