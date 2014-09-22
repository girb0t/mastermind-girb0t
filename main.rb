require_relative 'game'

module UI
	class Program
		def initialize
			greeting
		end

		def greeting
			puts "Welcome to MASTERMIND"
			puts "Would you like to (p)lay, read the (i)instructions, or (q)uit?"
			loop do
				input = gets.chomp.downcase
				case input
				when "p"
					start_game
				when "i"
					print_instructions
				when "q"
					return
				else
					puts "Invalid input."
					puts "Would you like to (p)lay, read the (i)instructions, or (q)uit?"
				end
			end
		end

		def start_game
			game = Game.new
			game.woof
		end

		def print_instructions
			puts "Game description here"
		end

	end
end

UI::Program.new