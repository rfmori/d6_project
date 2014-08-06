class TablesController < ApplicationController
  def create_table
    begin
     t = params['table']
     tb_id = Table::create_table(t['name'],session[:user_id],t['is_private'],t['descript'])
     # render :text => "TABLE ID->#{tb_id.rows[0]}"
     if(tb_id)
       redirect_to users_logon_path(session[:user_name], messages: ["Mesa #{tb_id} criada!"]), :method =>:post,:alert => "OPA!"
       #render users_logon_path(session[:user_name], messages: ["Mesa #{tb_id} criada!"])
     end

    rescue StandardError => e
      render :text => e
    end
  end

  def find_all_tables
    begin
      tbs = Table::find_all_tables()
      return tbs.rows.to_yaml.to_s
    rescue StandardError => e
      return e
    end
  end

  def create
    @tbl = Table.new
  end

  def find_tables_by_player(plrId)

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