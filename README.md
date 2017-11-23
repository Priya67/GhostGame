# Ghost Game
* It is a multi-player game where each player have to select a letter from the alphabets and that letter can be joined at the end of the fragment.
* The letter must be selected in such a way that it does not form a word, if it forms a word of the dictionary, then the player will get a point.
* Each player will be given maximum 5 points in the form of assigning letters from the word 'GHOST', if a player gets GHOST, then he/she will loose.
* The game will continue until there's a winner, every time a player acquire 5 points, i.e. 'GHOST', then the respective player gets eliminated and the game goes on with the remaining players.

## GHOST Game Demo

<p align="center" border-style: solid>
<img width=100% border="5" src="https://github.com/Priya67/GhostGame/blob/master/ghost1.gif">
</p>

### Code for each turn
```ruby
def take_turn
  letter = nil

  until letter
    letter = current_player.guess(fragment)

    #check if it is a valid move
    # checking if a word with these letters exist in the dictionary
    # If not then generate an alert for invalid move
    unless valid_play?(letter)
      current_player.alert_invalid_move(letter)
      letter = nil
    end
  end

  add_letter(letter)
  puts "#{current_player} added the letter '#{letter}' to the fragment."
end
````

### Code to check if Game is over
```ruby
def game_over?
  remaining_players == 1
end
````

#### Link to the documentation of the game:
https://en.wikipedia.org/wiki/Ghost_(game)


#### Ruby's magic underscore
http://po-ru.com/diary/rubys-magic-underscore/
