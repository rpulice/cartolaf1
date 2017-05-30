class CreateAlysson < ActiveRecord::Migration[5.0]
  def change
  	drop_table :alyssons
    create_table :alyssons do |t|
      t.text :pontos
      t.timestamps
    end
  end
end
