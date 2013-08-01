require 'spec_helper'

describe "Sudoku Pages" do

	#let(:sudoku) { FactoryGirl.create(:sudoku) }

	subject { page }

	describe "Sudoku Index" do

		describe "adding a board" do

			let(:sudoku) { Sudoku.find(1) }

			before do
				visit sudokus_path
				fill_in "sudoku_my_board", with: "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
				click_button "New Board"
				visit sudoku_path(sudoku)
			end

			it "should have the correct new board" do
				should have_content("003020600900305001001806400008102900700000008006708200002609500800203009005010300")		
			end

			it "should have the correct solution" do
				should have_content("483921657967345821251876493548132976729564138136798245372689514814253769695417382")		
			end
		end
	end
end