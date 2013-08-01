class CreateSudokus < ActiveRecord::Migration
  def change
    create_table :sudokus do |t|
      t.string :board
      t.string :solution

      t.timestamps
    end
  end
end
