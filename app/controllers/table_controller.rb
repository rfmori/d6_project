class TableController < ApplicationController
  def create_table
    begin
      tb_id = Table::create_table(params['name'],params['plr_id'],params['is_private'],params['descript'])
      render :text => "TABLE ID->#{tb_id.rows[0]}"
    rescue
      render :text => "NOT OK"
    end
  end

  def find_all_tables
    begin
      tbs = Table::find_all_tables()
      render :text => tbs.rows.to_yaml.to_s
    rescue
      render :text => "NOT OK"
    end
  end
end