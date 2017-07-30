#!/usr/bin/env ruby
class TowerOfHanoi

  def initialize(towers)
    @towers = towers
  end

  def populate(tower)
      (1..@towers).each {|value| tower[0][@towers-value] = value}
      3.times {|i| tower[i] ||= [0]}
  end

  def init_towers
    @tower = [[]]
    @copy_tower = [[]]
    populate(@tower)
    populate(@copy_tower)
  end

  def welcome
    init_towers
    puts "Welcome to Tower of Hanoi!"
    puts "Instruccions:"
    puts  "Enter where you'd like to move from and to"
    puts  "in the format '1,3'. Enter 'q' to quit."
    puts  "Current Board:"
    render
  end

  def render
    (@towers-1).step(0, -1) do |disc|
      puts  ("o"*@tower[0][disc].to_i).rjust(@towers + 10) +  ("o"*@tower[1][disc].to_i).rjust(@towers + 10) +  ("o"*@tower[2][disc].to_i).rjust(@towers + 10)
    end
    puts "1".rjust(@towers + 10) + "2".rjust(@towers + 10) + "3".rjust(@towers + 10)
  end

  def in_range(move)
    ary = move.split(",")
    @from = ary[0].to_i - 1
    @to = ary[1].to_i - 1
    (@from.between?(0,2) && @to.between?(0,2)) ? true : false
  end

  def valid_move?(move)
    if  @tower[@to].empty? || @tower[@to].last == 0 || move == "q"
      true
    elsif @tower[@from].empty? || @tower[@from].last == 0
      false
    elsif @tower[@from].last < @tower[@to].last
      true
    else
      false
    end
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
    if @tower[to].last == 0 || @tower[to].last == nil
      @tower[to][0] = @tower[from].pop.to_i
    else
      @tower[to] << @tower[from].pop.to_i
    end
  end

  def winer
    puts "FANTASTIC!! you win."
  end

  def play
    welcome

    looping_var = true
    while looping_var do
      print "Enter move > "
      move = gets.chomp!

      until unvalid?(move)[1] do
        print  "#{unvalid?(move)[0]} > "
        move = gets.chomp!
      end

      break if move == "q"
      move_disc(@from, @to)
      render
      if @tower.last == @copy_tower.first
        looping_var = false
        winer
      end
    end
  end
end
