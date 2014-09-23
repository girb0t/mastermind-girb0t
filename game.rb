class Game
	ELEMENTS = ['r', 'g', 'b', 'y']
	attr_reader :answer
	def initialize(answer = nil)
		@board = ""
		@answer = answer || ELEMENTS.map { |e| ELEMENTS.sample }.join
	end

	# returns 'win' if guess is correct
	# else returns a hash with correct positions/elements
	def evaluate(guess)
		if guess == @answer
			return 'win'
		else
			guess = guess.split("")
			answer_arr = @answer.split("")

			correct_elements = 0
			correct_positions = 0

			answer_arr.each_with_index do |answer_el, index|
				if answer_el == guess[index]
					correct_positions += 1
				end
			end

			guess.each do |guess_el|
				if answer_arr.include? guess_el
					correct_elements += 1

					#deletes one of the matched elements from answer_arr so it doesn't get couted again
					answer_arr.delete_at(answer_arr.find_index(guess_el)) 
					puts "answer_arr: #{answer_arr}"
				end
			end

			return { elements_matched: correct_elements, positions_matched: correct_positions }
		end
	end
end

# DRIVER CODE

game = Game.new('rrgy')
p game.evaluate('gyrr')