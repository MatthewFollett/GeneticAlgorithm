@@POPULATION_SIZE = 100
@@GENETIC_SIZE = 100

@@MUTAION_SOLUTION_CHANCE = 0.05 # chance a solution can mutate
@@MUTATION_GENETIC_CHANCE = 0.10 # chance that a gene in a solution can mutate

# Generate the initial random population
def initialization
	@population = Array.new
	
	POPULATION_SIZE.times do
		#using blocks, we generate random letters for a string
		solution = (0...100).map{ ('a'..'z').to_a[rand(26)] }.join
		@population.push solution
	end

end

# Mutate a solution, to keep the population fomr stagnating (this will make changes to the class passed in)
def mutation!(solution)
	solution.length.times do
		if(rand <= @@MUTATION_GENETIC_CHANCE)
			solution[length] = ('a'..'z').to_a[rand(26)]
		end
	end
end

# Take two strings, and breed them to create two new solutions
def breed(solution_one, solution_two)
	# We choose a pivot point, splice the two solutions and rejoin them to the corresponding
	# side of the other solution
	pivot = solution_one.length * rand
	new_solution_one = solution_one(0...pivot).join solution_two(pivot..-1)
	new_solution_two = solution_two(0...pivot).join solution_ont(pivot..-1)
	
	new_solution_one, new_soultion_two

end

#We evaluate scores based on number of vowels, and return a score (high score is betetr)
def evaluation (solution)
	#Extract vowels
	vowels = solution.scan( /[aeiou]/)
	#Count the number of vowels
	vowels.length
end

