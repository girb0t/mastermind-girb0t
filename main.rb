# Created by Pei Xiong Liu 2014

require_relative 'game'

module UI
	class Program
		def initialize
			@game = nil
			@guess_count = 0
			@start_time = nil
			clear_console
			greeting
		end

		def clear_console
			print %x{clear}
		end

		def greeting
			puts "Welcome to MASTERMIND"
			puts "Would you like to (p)lay, read the (i)instructions, or (q)uit?"
			loop do
				input = gets.chomp.downcase
				case input
				when "p"
					clear_console
					start_game
				when "i"
					print_instructions
				when "q"
					puts "Goodbye then."
					exit
				else
					puts "Invalid input."
					puts "Would you like to (p)lay, read the (i)instructions, or (q)uit?"
				end
			end
		end

		def reset_game
			@game = Game.new
			@guess_count = 0
			@start_time = Time.now
		end

		def start_game
			reset_game

			puts "I have generated a beginner sequence with four elements made up of:"
			puts
			puts " (r)ed,"
			puts " (g)reen,"
			puts " (b)lue,"
			puts " (y)ellow"
			puts
			puts "Use (q)uit at any time to end the game and (h)elp for possible commands."

			
			loop do
				puts "What's your guess? (e.g. rrby)"
				puts
				input = gets.chomp.downcase
				case input
				when "q"
					puts "Are you sure you want to exit the program? (y)es / (n)o"
					if gets.chomp.downcase == "y"
						puts "Bye."
						exit
					end
				when "h"
					help
				when "answer"
					puts "I hope you're the developer..."
					puts @game.answer
				else
					if valid_guess?(input)
						@guess_count += 1
						results = @game.evaluate(input)
						if results[:win?]
							win_message
						else
							puts "#{input} has #{results[:elements_matched]} of the correct elements with #{results[:positions_matched]} in the correct positions"
							if @guess_count == 1
								puts "You've taken 1 guess"
							else
								puts "You've taken #{@guess_count} guesses"
							end
						end
					else
						puts "Invalid input!"
					end
				end
			end

		end

		def valid_guess?(input)
			elements = Game::ELEMENTS
			input_arr = input.split("")
			input_arr.length == 4 && input_arr.all? { |e| elements.include? e}
		end

		def print_instructions
			puts "Game description here"
		end

		def help
			puts "Help and commands here."
		end

		def win_message
			puts "You win!"
			puts "Turns taken: #{@guess_count}"
			puts "Time taken: #{Time.now - @start_time} seconds"
			loop do
				puts "Play again?"
				puts "(y)es, (n)o"
				input = gets.chomp.downcase
				if input == 'y'
					start_game
				elsif input == 'n'
					puts "Thanks for playing!"
					exit
				end
			end
		end

	end
end

UI::Program.new