 ## SUPER GHOST!!!! WITH AI!!!!11!!

 require 'set'
 require 'byebug'

 class Game
   DICTIONARY_FILE = "dictionary.txt"
   GHOST_WORD = "GHOST"

   def initialize(players)
     @players = players
     @fragment = ""
     @dictionary = Set.new(File.readlines(DICTIONARY_FILE).map(&:chomp))
     @points = Hash.new { |hash, key| hash[key] = 0 }
   end

   def play
     informatize_players
     play_round until players.length == 1
     puts "\n#{players.first.name} won."
   end

   private

   attr_reader :dictionary, :players, :points
   attr_accessor :fragment

    def informatize_players
      players.each do |player|
        player.receive_dictionary(dictionary)
        player.receive_num_players(players.length)
      end
    end

   def current_player
     players.first
   end

   def next_player!
     players << players.shift
   end

   def valid_play?(letter, position)
     dictionary.any? do |word|
       if position == :front
         word.include?(letter + fragment)
       else
         word.include?(fragment + letter)
       end
     end
   end

   def add_letter_to_position(letter, position)
     position == :front ? self.fragment = letter + fragment : fragment << letter
   end

   def lost_round?
     dictionary.include?(fragment)
   end

   def next_round
     points[current_player] += 1
     announce_next_round
     self.fragment = ""
     remove_player! if points[current_player] == GHOST_WORD.length
   end

   def remove_player!
     puts "\n#{current_player.name} has been eliminated!"
     players.shift
   end

   def take_turn
     display_fragment
     letter, position = get_valid_letter_and_position
     add_letter_to_position(letter, position)
   end

   def get_valid_letter_and_position
     loop do
       position = get_position
       letter = get_letter
       return letter, position if valid_play?(letter, position)
       current_player.tell_to_redo
     end
   end

   def get_position
     position = current_player.get_position
     position == 'f' ? :front : :back
   end

   def get_letter
     current_player.get_letter
   end

   def display_fragment
     current_player.receive_fragment(fragment)
     puts "\nCurrent fragment: #{fragment}"

   end

   def ghost(player)
     GHOST_WORD[0...points[player]]
   end

   def play_round
     until lost_round?
       next_player!
       take_turn
     end

     next_round
   end

   def announce_next_round
     puts "\n\"#{fragment.capitalize}\" is a word! #{current_player.name} gets a point."
     puts "#{current_player.name}'s status: #{ghost(current_player)}"
   end
end

class HumanPlayer
  def self.type_string
    "human"
  end

 def self.make_player
    puts "\nEnter a name."
    print "> "
    self.new(gets.chomp.capitalize)
  end

 attr_accessor :name

 def initialize(name)
   @name = name
 end

 def get_position
   puts "\n#{name}, enter a position, front or back? (f/b)"
   print "> "
   gets.chomp
 end

 def get_letter
   puts "\n#{name}, enter a letter."
   print "> "
   gets.chomp
 end

 def tell_to_redo
   puts "This just won't work! Try something else."
 end

 def receive_fragment(fragment)
 end

 def receive_dictionary(dictionary)
 end

 def receive_num_players(num_player)
 end
end

class ComputerPlayer
  NAMES = ["Jack", "Hal", "C3000", "Apple II", "Watson"]

  def self.type_string
    "computer"
  end

  def self.make_player
     self.new(NAMES.sample)
  end

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_position
    puts "\n#{name} is computating...."
    letter, position = winning_move
    unless letter
      letter, position = non_losing_move
      letter, position = losing_move unless letter
    end
    @chosen_letter = letter
    position == :front ? "f" : "b"
  end

  def get_letter
    chosen_letter
  end

  def tell_to_redo
  end

  def receive_fragment(current_fragment)
    self.fragment = current_fragment
  end

  def receive_dictionary(dictionary)
    self.dictionary = dictionary
  end

  def receive_num_players(num_players)
    self.num_players = num_players
  end

  private

  attr_accessor :fragment, :chosen_letter, :dictionary, :num_players

  def losing_move
    each_combination do |position, letter, potential_fragment|
      return [letter, position] unless possible_words(potential_fragment).empty?
    end

    raise "This should never happen."
  end

  def non_losing_move
    moves = []
    each_combination do |position, letter, potential_fragment|
      if !possible_words(potential_fragment).empty? &&
         !dictionary.include?(potential_fragment)
          moves << [letter, position]
      end
    end
    moves.sample
  end

  def winning_move
    each_combination do |position, letter, potential_fragment|
      return [letter, position] if will_win?(potential_fragment)
    end
    [nil, nil]
  end

  def each_combination(&prc)
    [:front, :back].each do |position|
      ("a".."z").each do |letter|
        potential_fragment = new_fragment(letter, position)
        prc.call(position, letter, potential_fragment)
      end
    end
  end

  def will_win?(potential_fragment)
    return false if possible_words(potential_fragment).empty?

    possible_words(potential_fragment).all? do |word|
      word.length - potential_fragment.length > 0 &&
      (word.length - potential_fragment.length) % num_players != 0
    end
  end

  def possible_words(potential_fragment)
    dictionary.select {|word| word.include?(potential_fragment)}
  end

  def new_fragment(letter, position)
    position == :back ? fragment + letter : letter + fragment
  end
end

class Ghost

  def self.establish_players
    players = []

    [HumanPlayer, ComputerPlayer].each do |player_type|
      puts "How many #{player_type.type_string} players?"
      print "> "
      gets.chomp.to_i.times { players << player_type.make_player }
    end

    players.shuffle
  end

  def self.run
    Game.new(self.establish_players).play
  end
end

if __FILE__ == $PROGRAM_NAME
  Ghost.run
end
