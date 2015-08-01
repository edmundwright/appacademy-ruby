class Keypad
  attr_reader :code_length, :mode_keys, :key_history, :code_bank

  def initialize(code_length, mode_keys)
    @code_length = code_length
    @mode_keys = mode_keys
    @key_history = Array.new(code_length + 1)
    @code_bank = []
  end

  def press(key_value)
    key_history << key_value
    key_history.shift
    check_code
  end

  def check_code
    if mode_keys.include?(key_history.last) && !key_history.first.nil?
      add_to_code_bank
    end
  end

  def add_to_code_bank
    code_bank << key_history[0...code_length].join("")
  end

  def all_codes_entered?
    code_bank.uniq.sort == all_possible_codes
  end

  def all_possible_codes
    first_possible_code = '0' * code_length
    last_possible_code = '9' * code_length
    (first_possible_code..last_possible_code).to_a
  end
end

class KeypadTester
  attr_reader :code_length, :mode_keys, :keypad

  def initialize(code_length = 4, mode_keys = [1,2,3])
    @code_length = code_length
    @mode_keys = mode_keys
    @keypad = Keypad.new(code_length, mode_keys)
  end

  def run
    keypad.all_possible_codes.each do |code|
      digits = code.split("").map(&:to_i)
      digits.each { |digit| keypad.press(digit) }
      keypad.press(mode_keys.first)
    end
    puts keypad.all_codes_entered?
  end
end

if __FILE__ == $PROGRAM_NAME
  KeypadTester.new.run
end
