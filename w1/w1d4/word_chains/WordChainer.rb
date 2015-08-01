require 'set'

class WordChainer
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(word)
    dictionary.select do |entry|
      difference_count = 0
      (0...word.length).each do |char|
        difference_count += 1 if word[char] != entry[char]
      end
      difference_count == 1 && word.length == entry.length
    end
  end

  def run(source, target)
    @current_words = Set.new([source])
    @all_seen_words = {source => nil}

    until current_words.empty? || @all_seen_words.include?(target)
      new_current_words = explore_current_words(target)
      self.current_words = new_current_words
    end

    p build_path(target)
  end

  def explore_current_words(target)
    new_current_words = Set.new

    current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        unless all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          all_seen_words[adjacent_word] = current_word
          return new_current_words if adjacent_word == target
        end
      end
    end

    new_current_words.each do |key|
      puts "#{key}: #{all_seen_words[key]}"
    end

    new_current_words
  end

  def build_path(target)
    path = []

    word = target

    until word.nil?
      path << word
      word = all_seen_words[word]
    end

    path
  end
end
