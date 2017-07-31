#!/usr/bin/env ruby
class TowerOfHanoi

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

  def exit?(usr)
    usr == "q"
  end

  def match_format?(usr)
    /\A\d\,\s?\d/ =~ usr
  end

  def in_range?(usr)
    @from, @to = usr.split(",").map(&:to_i)
    @from.between?(1,3) && @to.between?(1,3)
  end

  def valid_move?
    return false if  @tower[@from].empty?
    return true if  @tower[@to].empty?
    @tower[@from].last < @tower[@to].last
  end

  def valid_input?(user)
    exit?(user) || (match_format?(user) && in_range?(user) && valid_move?)
  end

  def move_disc(from, to)
      @tower[to] << @tower[from].pop
  end

  def win?
    @tower[3] == @copy_tower[1]
  end

  def user_imput(message)
    begin
      print  "#{message}"
      user = gets.chomp!
    end until valid_input?(user)
    user
  end

  def winner_message
    puts "Great Job!!!"
  end

  def see_you
    puts "See you."
  end

  def play
    initialize_tower
    welcome
    render
    @message = "Enter move > "

    until win? do
      break if user_imput(@message) == "q"
      move_disc(@from, @to)
      render
    end
    win? ? winner_message : see_you
  end
end
