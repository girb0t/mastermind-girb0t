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
		results = {}

		if guess == @answer
			results[:win?] = true
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
					#deletes one of the matched elements from answer_arr so it doesn't get counted again
					answer_arr.delete_at(answer_arr.find_index(guess_el)) 
				end
			end

			results[:win?] = false
			results[:elements_matched] = correct_elements
			results[:positions_matched] = correct_positions
		end
		return results
	end
end