#!/usr/bin/env ruby
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end
end

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
    puts "Welcome to Tower of Hanoi!".blue
    puts "Instruccions:".blue
    puts  "Enter where you'd like to move from and to".green
    puts  "in the format '1,3'. Enter 'q' to quit.".green
    puts  "Current Board:".blue
  end
  def get_row(size, base)
    size == 0 ? "|".center(3*@discs).brown :  "#{base}".center(3*@discs).red
  end
  def get_stack(char, disc_index)
    row = ""
    (1..3).each do |pos|
      size = @tower[pos][disc_index].to_i
      base = "#{char}"*size + size.to_s + "#{char}"*size
      row <<  get_row(size, base)
    end
    row
  end
  def render
    (@discs - 1).downto(0) do |disc_index|
      puts get_stack("=", disc_index)
    end
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
      print  "Enter move > "
      user = gets.chomp!
    end until valid_input?(user)
    user
  end
  def winner_message
    if @moves == (2**@discs - 1)
      puts "Exelent #{@moves} moves. Great Job!!!.".green
    else
      puts "Great Job!!!."
    end
  end
  def see_you
    puts "See you.".blue
  end
  def play
    @moves = 0
    initialize_tower
    welcome
    render
    until win? do
      break if user_imput(@message) == "q"
      move_disc(@from, @to)
      @moves += 1
      render
    end
    win? ? winner_message : see_you
  end
end
