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
  end

  def welcome
    puts "Welcome to Tower of Hanoi!"
    puts "Instruccions:"
    puts  "Enter where you'd like to move from and to"
    puts  "in the format '1,3'. Enter 'q' to quit."
    puts  "Current Board:"
  end

  def get_stack(disc_index)
    row = ""
    (1..3).each do |pos|
      disc_size = @tower[pos][disc_index].to_i
      if disc_size == 0
        row << ' '*(2*@discs + 1)
      else
        row << ' '*(@discs - disc_size) + '='*(2*disc_size + 1) + ' '*(@discs - disc_size)
      end
    end
    row
  end

  def render
    (@discs - 1).downto(0) do |disc_index|
      puts get_stack(disc_index)
    end
    puts ' '*(@discs) + '1' + ' '*(@discs) + ' '*(@discs) + '2' + ' '*(@discs) + ' '*(@discs) + '3' + ' '*(@discs)
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
    @tower[3].size == @discs
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
