cclass TicTacToe
    WIN_COMBINATIONS = [
        [0, 1, 2], # Top row
        [3, 4, 5], # Middle row
        [6, 7, 8], # Bottom row
        [0, 3, 6], # Left column
        [1, 4, 7], # Middle column
        [2, 5, 8], # Right column
        [0, 4, 8], # Left diagonal
        [2, 4, 6]  # Right diagonal
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, player_token = "X")
        @board[index] = player_token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn_count
        @board.count { |token| token == "X" || token == "O" }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number between 1 and 9:"
        user_input = gets.strip
        index = input_to_index(user_input)

        if valid_move?(index)
        player_token = current_player
        move(index, player_token)
        display_board
        else
        puts "Invalid move. Please try again."
        turn
        end
    end

        def won?
        WIN_COMBINATIONS.each do |combination|
        index_1, index_2, index_3 = combination
        position_1 = @board[index_1]
        position_2 = @board[index_2]
        position_3 = @board[index_3]

        if position_1 == "X" && position_2 == "X" && position_3 == "X"
            return combination
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
            return combination
        end
        end

        false
    end

    def full?
        @board.all? { |position| position == "X" || position == "O" }
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || full?
    end

    def winner
        if won?
        winning_combination = won?
        index = winning_combination[0]
        @board[index]
        end
    end

    def play
        until over?
        turn
    end

    if won?
        puts "Congratulations #{winner}!"
    else
        puts "The game ended in a draw."
    end
end

game = TicTacToe.new
game.play