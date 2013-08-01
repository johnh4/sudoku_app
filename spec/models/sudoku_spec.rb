require 'spec_helper'

describe Sudoku do
	
	let (:sudoku) { FactoryGirl.create(:sudoku, my_board: "530070000600195000098000060800060003400803001700020006060000280000419005000080079") }
	
	subject { sudoku }

	it { should respond_to(:my_board) }
	it { should respond_to(:solution) }

	its(:id) { should_not be_nil }

	#its(:board) { should be_valid }
	#its(:solution) { should be_valid }

	describe "for a new board" do

		before do
			sudoku.my_board = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
			sudoku.save
			#sodoku.solve
			print sudoku.my_board
			print sudoku.solution
		end

		its(:solution) { should_not be_blank }

		its(:solution) { should eq("483921657967345821251876493548132976729564138136798245372689514814253769695417382") }
	end
end
