class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :user
      t.integer :gold
      t.string :name

      t.timestamps
    end
  end
end
