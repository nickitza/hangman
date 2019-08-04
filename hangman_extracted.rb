#-for future to do's: add difficult level in both word arrays, guesses_left and
# introduce a bet multiplier for those difficulties. 
# -add ability to add money without going back to cashier.
# -add gradual ascii print outs (head on first wrong guess, then body 2/3 wrong)

require 'colorize'
# require 'pry'

class Hangman
  attr_accessor :letters_left
  def initialize
    @letters_left = ('a'..'z').to_a.join(" ")
    @user_word = ""
    
    main_menu
  end

class Person
  attr_accessor :person_name, :wallet
  def initialize(name, wallet)
    @person_name = name
    @wallet = wallet
  end
end

  def main_menu 
    @still_running = true
    while @still_running
      clear
      stars
      hang_ascii
      stars
      puts "  HANGMAN  "
      stars 
      user_choice = get_menu_choice 
      case user_choice
        when "1"
          @person = init_person()
          if @person.wallet <= 0
            puts 'Your wallet is empty.'
            # puts "Press enter to go back to the Casino to get more money."
            # gets
            # Casino.new(@person.wallet)
            main_menu
          else
          place_bet
          end
        when "2"
          puts "Thank you for playing. We hope to see you again soon!"
          @still_running = false
        else
          clear
          stars
          puts "That is not a valid selection.".colorize(:red)
          puts "Please choose either 1 or 2.".colorize(:red)
          stars
          puts
          puts "Press Enter to return to menu"
          gets
      end
    end
  end

  def get_menu_choice
    puts "1) New Game"
    puts "2) Exit"
    gets.strip
  end

  def init_person
    print "Please enter your name: "
    name = gets.strip
    print "Hello #{name}! Please enter your available funds: $"
    wallet = gets.to_i
    customer = Person.new(name, wallet)
  end

  def place_bet
    clear
    puts "How much would you like to bet?"
    print ">$ "
    @bet = gets.strip.to_i
    if @bet > @person.wallet
        clear
        stars
        puts "You do not have enough money to make that bet.".colorize(:red)
        puts "You have $#{@person.wallet} in your wallet for betting.".colorize(:red)
        stars
        puts "Would you like to make an ATM withdrawl to add more money to your wallet? (Y/N) "
        answer = gets.strip.downcase
        if answer == "y"
          clear
          print "ATM: 'How much would you like to withdraw?' $".colorize(:green)
          amount = gets.strip.to_i
          @person.wallet += amount
          print "You have successfully withdrawn $#{amount}. Thank you."
          place_bet
        else
          puts "Thank you for playing. We hope to see you again soon!"
          @still_running = false
        end
      else
      generate_word
      end
  end


  def generate_word
    clear
    puts "Your word is being generated."
    print "."
    sleep(1)
    print "."
    sleep(1)
    puts "."
    sleep(1)
    pick_word
    @word_arr = @game_word.chars.to_a
    @user_word = "_" * @word_arr.length
    @user_word = @user_word.chars.to_a
    puts "Your word has been chosen. "
    @guesses_left = @game_word.length
    puts "You have #{@guesses_left} guesses left."
    puts "Choose your letter wisely!"
    puts
    puts "Press enter to continue.".colorize(:red)
    gets
    clear
    get_guess
  end

  def get_guess
    while !game_over
      puts
      puts
      puts "Which of the available letters would you like to choose?"
      puts @letters_left
      @user_guess = gets.strip.downcase
      if @letters_left.include?(@user_guess)
        if @word_arr.include?(@user_guess)
          right_guess
          get_guess
          else
            wrong_guess
            get_guess
        end
        else
          puts "Please choose one of the remaining letters to guess."
          get_guess
      end
    end
    game_end
  end

  def right_guess
    remove_letter
    clear
    puts "Hooray!! You're right! That letter is in the word!"
    puts "You have #{@guesses_left} guesses left.".colorize(:red)
    @word_arr.each_with_index do |w, i|
      if @word_arr[i].include?(@user_guess)
        @user_word[i] = @user_guess
        else
      end
    end
    print @user_word.join(" ")
    puts
  end

  def wrong_guess
    remove_letter
    clear
    @guesses_left -= 1
    puts "Oh no! That letter is not in your word!"
    puts "You have #{@guesses_left} guesses left.".colorize(:red)
    puts
    print @user_word.join(" ")    
  end

  def remove_letter
    @letters_left = @letters_left.delete(@user_guess)
  end

  def game_over
    (@guesses_left == 0) || (@user_word.eql?(@word_arr))
  end

  
  def game_end
    if @guesses_left == 0
      puts
      puts "GAME OVER".colorize(:red)
      puts "You ran out of guesses! Your man hangs!"
      @person.wallet -= @bet
      puts "You lose $#{@bet}!"
      puts "You now have a total of $#{@person.wallet} in your wallet."
      # puts your wallet total is now:
      puts "Your word was #{@game_word.colorize(:yellow)}."
      hang_ascii
      puts "Would you like to play again? (Y/N) ".colorize(:red)
      answer = gets.strip.downcase
      if answer == "y"
        reset
        place_bet
      else
        puts "You are leaving with a total of $#{@person.wallet} in your wallet."
        puts "Come back soon!"
        @still_running = false
      end

    else
      puts "\nCONGRATULATIONS!".colorize(:green)
      puts "You guessed the word! Your man goes free!"
      @person.wallet += @bet
      puts "You win $#{@bet}!"
      puts "You now have a total of $#{@person.wallet} in your wallet."
      puts "Would you like to play again? (Y/N) ".colorize(:red)
      answer = gets.strip.downcase
      if answer == "y"
        reset
        place_bet
      else
        puts "You are leaving with a total of $#{@person.wallet} in your wallet."
        puts "Come back soon!"
        @still_running = false
      end
    end
  end

  def reset
    @letters_left = ('a'..'z').to_a.join(" ")
    @user_word = ""
  end

  def add_word
  end

  def pick_word
    @words = [
      "hippopotamus",
      "puzzled",
      "fungus",
      "flourish",
      "royal",
      "branch",
      "embezzle",
      "supernatural",
      "cottage",
      "ambitious",
      "pervasive",
      "ridiculous",
      "superimpose",
      "appliance",
      "flawless",
      "redundant",
      "raucous",
      "apparatus",
      "castle",
      "sweltering",
      "heartbreaking",
      "dynamic",
      "saxophone",
      "juggle",
      "regret",
      "rustic",
      "petite",
      "exotic",
      "bushel",
      "mellow",
      "fairies",
      "computer",
      "obtain",
      "vampire",
      "music",
      "mouse",
      "plant"
    ]
    @game_word = @words.sample
  end

  def stars
    puts "******".colorize(:yellow) * 2
    puts "******".colorize(:yellow) * 2
  end

  def clear
    print `clear`
  end

  def hang_ascii  
    print " ____________  \n"
    print "|         |    \n"
    print "|         0    \n"
    print "|        /|\\  \n"
    print "|        / \\  \n"
    print "|              \n"
    print "|              \n"
    print "|              \n"
    print "/~\_/~\_/~\_/~\_/\n"
  end
end

Hangman.new