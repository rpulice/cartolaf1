class CreateTeamPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_players do |t|
    	t.references :team, index: true
    	t.text :player

      t.timestamps
    end
  end
end
