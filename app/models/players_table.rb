class PlayersTable < ActiveRecord::Base
  self.table_name = 'tb_players_table'
  has_one :table, :foreign_key => 'table'
  has_many :users, :foreign_key => 'player'
end
