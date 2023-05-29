class TicTacToe
    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
        [0, 4, 8], [2, 4, 6] # Diagonals
    ]
    
    def initialize
        @board = Array.new(9, " ")
    end
    
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "---+---+---"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "---+---+---"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        puts "-----------"
    end
    
    def input_to_index(user_input)
        user_input.to_i - 1
    end
    
    def move(index, current_player)
        @board[index] = current_player
    end
    
    def position_taken?(index)
        @board[index] != " "
    end
    
    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end
    
    def turn_count
        @board.count { |position| position != " " }
    end
    
    def current_player
        turn_count.even? ? "X" : "O"
    end
    
    def turn
        current_player = self.current_player # Store the current player in a variable
        puts "It's #{current_player}'s turn. Please enter a number between 1-9:"
        input = gets.strip
        index = input_to_index(input)
    
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            puts "Invalid move. Please try again."
            turn
        end
    end
    
    def won?
        WIN_COMBINATIONS.each do |combination|
            if combination.all? { |index| @board[index] == "X" } ||
            combination.all? { |index| @board[index] == "O" }
            return combination
            end
        end
        false
    end
    
    def full?
        @board.all? { |position| position != " " }
    end
    
    def draw?
        full? && !won?
    end
    
    def over?
        won? || draw?
    end
    
    def winner
        if combination = won?
            @board[combination[0]]
        end
    end
    
    def play
        puts "Welcome to Tic Tac Toe!"
        display_board
    
        until over?
            turn
        end
    
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end