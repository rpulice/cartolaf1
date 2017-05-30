class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :nome
      t.string :jogador_slug
      t.boolean :ativo, default: true

      t.timestamps
    end
  end
end
