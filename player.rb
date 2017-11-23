require "colorize"

class Player

  # Making player name an instance variable
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  # Prompt a message to the user if move is invalid
  def alert_invalid_move(letter)
    puts "'#{letter}' is not a valid move!\n".colorize(:red)
    puts "NOTE: You must be able to form a word starting with the new fragment.\n".colorize(:blue)
    puts "-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- *\n\n"
  end
  
  # Takes an input fragment from the player
  def guess(fragment)
    puts "The current fragment is '#{fragment}'.\n".colorize(:green)
    print "Add a letter:\n"
    gets.chomp.downcase
  end
  
  def inspect
    "HumanPlayer: #{name}".colorize(:yellow)
  end
  
  def to_s
    name
  end
  
end