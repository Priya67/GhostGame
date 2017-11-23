# Ghost game class
require "set"
require 'colorize'
require_relative "player"

class Game
  
  ALPHABET = Set.new("a".."z")
  MAX_LOSS_COUNT = 5
    
  # Constructor that initializes all properties of an object
   # We have given players name from console as multiple params hence used *
  def initialize(*players)
    
    # Extracting all words from the dictionary and saving it in a Set
    words = File.readlines("dictionary.txt").map(&:chomp)
    @dictionary = Set.new(words)
    
    # Assigning the players array to contain the players name
    @players = players    
    
    # Keep check of losses of each player in a HashMap
    @losses = Hash.new { |losses, player| losses[player] = 0 }
  end
  
  # Starts a new game
  def run
    # it will continue the game until it's over and displays the winner
    play_round until game_over?
    puts "#{winner} wins!".colorize(:green)
  end
  
  private
  # All of the following methods are private
  
  attr_reader :fragment, :dictionary, :losses, :players

  # check if only one player is left
  def game_over?
    remaining_players == 1
  end
  
  # play_round will play each round until the game is over
  def play_round
    # initializing the fragment at the start of each game
    @fragment = ""
    system("clear")
    
    puts "Let's play a round of Ghost!\n".colorize(:green)
    
    display_standings
    
    # until the round is over, the game will continue
    until round_over?
      take_turn
      next_player!
    end
    
    # update the scores after each round
    update_standings
  end
  
  def valid_play?(letter)
    return false unless ALPHABET.include?(letter)
    
    new_fragment = fragment + letter
    
    dictionary.any? { |word| word.start_with?(new_fragment) }
  end
  
  def is_word?(fragment)
    dictionary.include?(fragment)
  end
  
  def round_over?
    is_word?(fragment)
  end
  
  # update fragment with the input
  def add_letter(letter)
    fragment << letter
  end
  
  def current_player
    players.first
  end
  
  def previous_player
    players.last
  end
  
  def next_player!
    players.rotate!
   # keep rotating until we find a player who hasn't been eliminated
   players.rotate! until losses[current_player] < MAX_LOSS_COUNT
  end
  
  def remaining_players
    losses.count { |_, v| v < MAX_LOSS_COUNT }
  end
  
  def winner
    (player, _) = losses.find { |_, losses| losses < MAX_LOSS_COUNT }
    player
  end
  
  def record(player)
    count = losses[player]
    "GHOST".slice(0, count)
  end
  
  def take_turn
    system("clear")
    print "It's " 
    print "#{current_player}'s ".colorize(:red)
    print "turn!\n"
    letter = nil
    
    until letter
      letter = current_player.guess(fragment)
      
      unless valid_play?(letter)
        current_player.alert_invalid_move(letter)
        letter = nil
      end
    end
    
    add_letter(letter)
    puts "#{current_player} added the letter '#{letter}' to the fragment."
  end
  
  def display_standings
    system("clear")
    puts "Current standings:\n".colorize(:blue)

    players.each do |player|
      puts "#{player}: #{record(player)}\n".colorize(:yellow)
    end

    sleep(2)
  end
  
  def update_standings
    system("clear")
    puts "#{previous_player} spelled #{fragment}.\n".colorize(:red)
    puts "** #{previous_player} gets a letter! **\n\n"
    
    losses[previous_player] += 1

    if losses[previous_player] == MAX_LOSS_COUNT
      puts "-- * -- * -- * -- * -- * -- * -- * -- *\n"
      puts "#{previous_player} has been eliminated!\n"
      puts "-- * -- * -- * -- * -- * -- * -- * -- *"
    end
    
    sleep(2)

    display_standings

  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new("Suyash"), Player.new("Priya"))
  game.run
end