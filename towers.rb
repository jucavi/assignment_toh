#!/usr/bin/env ruby
class TowerOfHanoi
  attr_accessor :tower

  def initialize(discs)
    @discs = discs
  end

  def populate(tower)
      (1..3).each do |pos|
        tower[pos] = []
        @discs.downto(1) {|disc| tower[1] << disc} if pos == 1
      end
  end

  def initialize_tower
    populate(@tower = Hash.new)
    populate(@copy_tower = Hash.new)
  end

  def welcome
    puts "Welcome to Tower of Hanoi!"
    puts "Instruccions:"
    puts  "Enter where you'd like to move from and to"
    puts  "in the format '1,3'. Enter 'q' to quit."
    puts  "Current Board:"
  end

  def render
    (@discs-1).downto(0)  do |disc|
      puts  ("o"*@tower[1][disc].to_i).rjust(@discs + 10) +  ("o"*@tower[2][disc].to_i).rjust(@discs + 10) +  ("o"*@tower[3][disc].to_i).rjust(@discs + 10)
    end
    puts "1".rjust(@discs + 10) + "2".rjust(@discs + 10) + "3".rjust(@discs + 10)
  end

  def in_range(move)
     @from, @to = move.split(",").map(&:to_i)
    (@from.between?(1,3) && @to.between?(1,3)) ? true : false
  end

  def valid_move?(move)
    return false if  @tower[@from].empty?
    return true if  @tower[@to].empty? || move == "q"
    @tower[@from].last < @tower[@to].last
  end

  def unvalid?(move)
    if move == "q"
      ["", true]
    elsif /\A\d\,\s?\d/ =~ move
      if in_range(move) && valid_move?(move)
        ["", true]
      else
        ["Wrong move... enter move", false]
      end
    else
      ["Wrong format... enter move", false]
    end
  end

  def move_disc(from, to)
      @tower[to] << @tower[from].pop
  end

  def win?
    @tower[3] == @copy_tower[1]
  end

  def winner_message
    puts "Great Job!!!"
  end

  def play
    initialize_tower
    welcome
    render

    until win? do
      print "Enter move > "
      move = gets.chomp!

      until unvalid?(move)[1] do
        print  "#{unvalid?(move)[0]} > "
        move = gets.chomp!
      end

      break if move == "q"
      move_disc(@from, @to)
      render
    end
    winner_message if win?
  end
end
