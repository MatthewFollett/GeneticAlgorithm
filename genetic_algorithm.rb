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


end

#We evaluate scores based on number of vowels
def evaluation (solution)

end

