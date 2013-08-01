class Sudoku
	attr_accessor :board_a

	def initialize(board_s)
		@board_a = board_s.split("").map { |s| s.to_i }
		puts "initialize method started"
		#@board_a.push(10)
		@col_solve_1_found = false
		@row_solve_1_found = false
		@col_solve_2_found = false
		@row_solve_2_found = false
		@box_solve_found = false
		@presolve = true
	end

	def get_row(index)
		row_num = index/9.floor
		#print "row_num:"
		#puts row_num
		row = Array.new
		for i in 0...9
			row[i] = @board_a[row_num*9+i]
		end
		#print "row:"
		#print row
		return row
	end

	def get_col(index)
		col_num = index % 9
		#puts "."
		#print "col_num:"
		#puts col_num
		col = Array.new
		for i in 0...9
			col[i] = @board_a[i*9+col_num]
		end
		#print "col:"
		#print col
		return col
	end

	def print_board
	   print "printing board method:"
	   print @board_a
	end

	def get_box(index)
		row_num = index/9.floor
		col_num = index % 9
		#print "row_num:"
		#puts row_num
		#print "col_num:"
		#puts col_num
		box = Array.new
		row_num = row_num/3.floor*3 #change row_num to 0,3,or 6.
		col_num = col_num/3.floor*3 #change col_num to 0,3, or 6.
		for i in 0...9
			if(i<3)
				box[i] = @board_a[row_num*9+col_num+i]
			elsif(i>2 && i <6)
				box[i] = @board_a[(row_num+1)*9+col_num+i-3]
			elsif(i>5 && i <9)
				box[i] = @board_a[(row_num+2)*9+col_num+i-6]
			end			
		end
		#print "box:"
		#print box
		return box
	end

	def update_board(answer, index)
		@board_a[index] = answer
		#print "@board_a[#{index}]:"
		#print @board_a[index]
	end

	def get_missing(type, index)
		missing = Array.new
		if(type=="row")
			row = get_row(index)
			for i in 1..9
				unless row.include?(i)
					missing.push(i)
				end
			end
		end
		if(type=="col")
			col = get_col(index)
			for i in 1..9
				unless col.include?(i)
					missing.push(i)
				end
			end
		end
		if(type=="box")
			box = get_box(index)
			for i in 1..9
				unless box.include?(i)
					missing.push(i)
				end
			end
		end
		#print "missing: "
		#print missing
		return missing
	end

	def get_empty(type, index)
		empty_cells = Array.new
		if(type=="row")
			row = get_row(index)
			row_num = index/9.floor
			offset = 
			for i in 0..8
				empty_cells.push(row_num*9+i) if row[i]==0
			end
		end
		if(type=="col")
			col = get_col(index)
			col_num = index % 9
			for i in 0..8
				empty_cells.push(i*9+col_num) if col[i]==0
			end
		end
		if(type=="box")
			row_num = index/9.floor
			col_num = index % 9
			box = Array.new
			row_num = row_num/3.floor*3 #change row_num to 0,3,or 6.
			col_num = col_num/3.floor*3 #change col_num to 0,3, or 6.
			box = get_box(index)
			for i in 0..8
				if(i<3)
					empty_cells.push(row_num*9+col_num+i) if box[i]==0
				elsif(i>2 && i<6)
					empty_cells.push((row_num+1)*9+col_num+i-3) if box[i]==0
				elsif(i>5 && i<9)
					empty_cells.push((row_num+2)*9+col_num+i-6) if box[i]==0
				end
			end
		end
		#print "empty_cells: "
		#print empty_cells
		return empty_cells
	end

	def is_valid(number, index)
		box = get_box(index)
		#print "from is_valid, box:"
		#print box
		if(@board_a[index]!=0)
			return false
		end
		if(box.include?(number))
			return false
		end
		row = get_row(index)
		#print "row:"
		#print row
		if(row.include?(number))
			return false
		end
		col = get_col(index)
		#print "col:"
		#print col
		if(col.include?(number))
			return false
		end
		return true
	end

	def col_solve_1(missing, index)
		#@col_solve_1_found = false
		col = get_col(index)
		empty_in_col = get_empty("col", index)
		num_valid = 0
		for i in 0..empty_in_col.length-1
			if is_valid(missing, empty_in_col[i])
				num_valid += 1 
				answer_index = empty_in_col[i]
			end
		end
		if num_valid == 1
			update_board(missing,answer_index)
			puts "col_solve_1: updated board at #{answer_index} with #{missing}."
			#@col_solve_1_found = true
		end
	end

	def row_solve_1(missing, index)
		#@row_solve_1_found = false
		row = get_row(index)
		empty_in_row = get_empty("row", index)
		num_valid = 0
		for i in 0..empty_in_row.length-1
			if is_valid(missing, empty_in_row[i])
				num_valid += 1 
				answer_index = empty_in_row[i]
			end
		end
		if num_valid == 1
			update_board(missing,answer_index)
			puts "row_solve_1: updated board at #{answer_index} with #{missing}."
			#@row_solve_1_found = true
		end
	end

	def col_solve_2(index)
		#@col_solve_2_found = false
		empty_in_col = get_empty("col", index)
		missing_from_col = get_missing("col", index)
		
		for i in 0..empty_in_col.length-1
			num_valid = 0
			answer = 0
			for j in 0..missing_from_col.length-1
				if is_valid(missing_from_col[j],empty_in_col[i])
					num_valid += 1
					answer = missing_from_col[j]
					answer_index = empty_in_col[i]
				end
			end
			if num_valid == 1
				update_board(answer, answer_index)
				puts "col_solve_2: updated board at #{answer_index} with #{answer}."
				#@col_solve_2_found = true
			end
		end
	end

	def row_solve_2(index)
		#@row_solve_2_found = false
		empty_in_row = get_empty("row", index)
		missing_from_row = get_missing("row", index)
		
		for i in 0..empty_in_row.length-1
			num_valid = 0
			answer = 0
			for j in 0..missing_from_row.length-1
				if is_valid(missing_from_row[j],empty_in_row[i])
					num_valid += 1
					answer = missing_from_row[j]
					answer_index = empty_in_row[i]
				end
			end
			if num_valid == 1
				update_board(answer, answer_index)
				puts "row_solve_2: updated board at #{answer_index} with #{answer}."
				#@row_solve_2_found = true
			end
		end
	end

	def box_solve(index)
		#@box_solve_found = false
		empty_in_box = get_empty("box", index)
		missing_from_box = get_missing("box", index)
		for i in 0..missing_from_box.length-1
			num_valid = 0
			answer = 0
			for j in 0..empty_in_box.length-1
				if is_valid(missing_from_box[i],empty_in_box[j])
					num_valid += 1
					answer = missing_from_box[i]
					answer_index = empty_in_box[j]
				end
			end
			if num_valid == 1
				update_board(answer, answer_index)
				puts "box_solve: updated board at #{answer_index} with #{answer}."
				#@box_solve_found = true
			end
		end
	end

	def board
		puts " "
		puts "---------------------"
		for i in 0..8
			row = get_row(i*9)
			for j in 0..8
				print row[j] 
				print " "
				if j==2 || j==5
					print "| "
				end
				if j==8
					puts " "
				end
			end
			if(i==2 || i==5 || i==8)
				puts "---------------------"
			end
		end
	end

	def get_all_empty_cells
		all_empty_cells = Array.new
		for i in 0..80
			if @board_a[i]==0
				all_empty_cells.push(i)
			end
		end
		return all_empty_cells
	end

	def guess
		board_start = Array.new
		board_start = @board_a.dup
		#@board_a = Array.new

		#find all empty cells, contains cell location
		all_empty_cells = get_all_empty_cells()

		#for each empty cell, find all of the values with is_valid==true for a cell, & randomly pick one
		while all_empty_cells.length > 0
			puts "in while loop."
			#board()
			#@board_a = board_start.dup
			#puts "board reset"
			#board
			for i in 0...all_empty_cells.length
				puts "in for loop"
				valid_nums = Array.new
				val_num = 0
				#find vals that are valid
				for j in 1..9
					if is_valid(j,all_empty_cells[i])
						val_num = j
						valid_nums.push(val_num)
					end
				end
				#pick one, randomly
				if valid_nums.length > 0
					answer = valid_nums.sample
					#answer[0].to_i
					update_board(answer, all_empty_cells[i])
					puts "guess: updated board at #{all_empty_cells[i]} with #{answer}."
					solve()
				elsif valid_nums.length == 0 && @board_a[all_empty_cells[i]] ==0
					print "valid_nums.length: "
					puts valid_nums.length
					puts "there are no valid numbers for cell #{all_empty_cells[i]}"
					board()
					puts "board_start: "
					print board_start
					@board_a = board_start.dup
					puts "board reset"
					board()
					break
					#guess()
				end
			end
			puts "just exited the for loop."
			board()
			all_empty_cells = get_all_empty_cells()
		end

		#if the solution fails, start over (if there are no is_valid==true for an empty cell)
	end

	def solve
		print "using .., i: "
		for i in 0..5
			print i
		end
		print "using ..., i: "
		for i in 0...5
			print i
		end
		puts "sample of [1,2,3,4,5]: "
		test_arr = Array.new
		test_arr = [1,2,3,4,5]
		print test_arr.sample

		#run col_solve_1 for each col, until board solved
		until(@board_a.include?(0)==false)
		#until(@col_solve_1_found == false && @col_solve_2_found == false && @row_solve_1_found == false \
		#	         && @presolve == false && @row_solve_2_found == false && @box_solve_found == false)
			@col_solve_1_found = true
			@row_solve_1_found = true
			@col_solve_2_found = true
			@row_solve_2_found = true
			@box_solve_found = true
			@presolve = false			
			board_pre = Array.new
			board_post = Array.new

			board_pre = @board_a
			for i in 0..8
				col = get_col(i)
				missing_from_col = get_missing("col",i)
				for j in 0..missing_from_col.length-1
					col_solve_1(missing_from_col[j], i)
				end
			end
			board_post = @board_a 
			if board_pre == board_post
				@col_solve_1_found = false 
			else 
				@col_solve_1_found = true
			end

			board_pre = @board_a
			for i in 0..8
				row = get_row(i)
				missing_from_row = get_missing("row",i*9)
				for j in 0..missing_from_row.length-1
					row_solve_1(missing_from_row[j], i*9)
				end
			end
			board_post = @board_a 
			if board_pre == board_post 
				@row_solve_1_found = false
			else 
				@row_solve_1_found = true
			end

			board_pre = @board_a
			for i in 0..8
				col_solve_2(i)
			end
			board_post = @board_a
			if board_pre == board_post 
				@col_solve_2_found = false 
			else 
				@col_solve_2_found = true
			end

			board_pre = @board_a
			for i in 0..8
				row_solve_2(i*9)
			end
			board_post = @board_a
			if board_pre == board_post 
				@row_solve_2_found = false 
			else 
				@row_solve_2_found = true
			end

			board_pre = @board_a
			for i in 0..8
				if(i<3)
					box_solve(3*i+3)
				elsif(i>2 && i <6)
					box_solve(3*i+18)
				elsif(i>5 && i <9)
					box_solve(3*i+36)
				end	
			end
			board_post = @board_a
			if board_pre == board_post 
				@box_solve_found = false 
			else 
				@box_solve_found = true
			end

		if(@col_solve_1_found == false && @col_solve_2_found == false && @row_solve_1_found == false \
			         && @presolve == false && @row_solve_2_found == false && @box_solve_found == false)
			break
		end
			
		end
		if(@board_a.include?(0)==false)
			puts "Solved:"
		else
			puts "Board Unsolved. Make me stronger."
		end
		board
	end
end

#!/usr/bin/env ruby

#sud = Sudoku.new('003020600900305001001806400008102900700000008006708200002609500800203009005010300')
#sud = Sudoku.new('483921657967345821251876493548132976729564138136798245372689514814253769695417382')
#sud = Sudoku.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
sud = Sudoku.new('700000002004207900030080040070020090001509700090060010040050060009402500300000008')
#sud = Sudoku.new('005400008090030010600005300400006500050080020008500006009200004020040030700009100')
#sud.update_board(2,1)
#sud.get_row(1)
#sud.is_valid(2,5)
#puts sud.is_valid(1,72)
#sud.get_empty("box",70)
#sud.col_solve_1(8, 41)
#sud.row_solve_1(8,45)
#sud.col_solve_2(7)
sud.board
sud.guess
#sud.guess
#sud.box_solve(61)