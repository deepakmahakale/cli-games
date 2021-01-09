class TicTacToe
  def initialize
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @turn = 'X'
    @winner = nil
    @tie = false
  end

  def next_turn
    @turn
  end

  def move(player, x, y)
    return 'not empty' unless @board[x][y].strip.empty?

    @board[x][y] = player.upcase
    check_winner
    @turn = @turn == 'X' ? 'O' : 'X'
  end

  def draw_board
    puts @board.map { |row| row.join(' | ') }.join("\n--+---+---\n")
  end

  def check_winner
    return if @winner

    (0..2).each do |col|
      # Check rows
      game_over and return if @board[col][0] == @board[col][1] && @board[col][1] == @board[col][2] && !@board[col][0].strip.empty?

      # Check columns
      game_over and return if @board[0][col] == @board[1][col] && @board[1][col] == @board[2][col] && !@board[0][col].strip.empty?
    end

    # Check Diagonal
    game_over and return if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && !@board[0][0].strip.empty?

    game_over and return if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && !@board[0][2].strip.empty?

    game_tie
    @winner
  end

  def game_tie
    @tie = true unless @board.map.any?{ |e| e.map.any?{ |y| y.strip.empty? } }
    game_over(tie: true) if @tie
    @tie
  end

  def game_over(tie: false)
    if tie
      puts 'Tie: No one won'
      draw_board
    else
      @winner = @turn
      puts "Player #{@turn} wins"
    end
    tie
  end
end

t = TicTacToe.new
while t.check_winner.nil? && !t.game_tie
  puts "Player #{t.next_turn}'s turn"
  t.draw_board
  puts 'enter cordinates separated by space or comma'
  coords = $stdin.gets.chomp
  coords = coords.include?(',') ? coords.split(',') : coords.split(' ')
  coords.map!(&:to_i)
  t.move(t.next_turn, coords[0], coords[1])
end

# t.move('X', 0, 0)
# t.move('O', 0, 2)
# t.move('X', 1, 0)
# t.move('O', 1, 2)
# t.move('X', 2, 1)
# t.draw_board
