class AddMyBoardToSudokus < ActiveRecord::Migration
  def change
    add_column :sudokus, :my_board, :string
  end
end
