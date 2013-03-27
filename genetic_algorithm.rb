@@POPULATION_SIZE = 100
@@GENETIC_SIZE = 100
@@GENERATIONS = 150000

@@MUTAION_SOLUTION_CHANCE = 0.05 # chance a solution can mutate
@@MUTATION_GENETIC_CHANCE = 0.10 # chance that a gene in a solution can mutate

# Generate the initial random population
def initialization
	@population = Array.new
	
	@@POPULATION_SIZE.times do
		#using blocks, we generate random letters for a string
		solution = (0...100).map{ ('a'..'z').to_a[rand(26)] }.join
		@population.push solution
	end

end

# Mutate a solution, to keep the population fomr stagnating (this will make changes to the class passed in)
def mutation!(solution)
	solution.length.times do |index |
		if(rand <= @@MUTATION_GENETIC_CHANCE)
			solution[index] = ('a'..'z').to_a[rand(26)]
		end
	end
end

# For tournament selection, we're going to choose 8 random solutions and return the best one

@@TORUNAMENT_SIZE = 8
def tournament_selection (population_pool)
	best_score = -1
	best_solution = nil
	@@TORUNAMENT_SIZE.times do
		solution = population_pool[population_pool.length * rand]
		score = evaluation solution
		if(score > best_score)
			best_score = score
			best_solution = solution
		end
	end
	best_solution
end

# Take two strings, and breed them to create two new solutions
def breed(solution_one, solution_two)
	# We choose a pivot point, splice the two solutions and rejoin them to the corresponding
	# side of the other solution
	pivot = solution_one.length * rand
	new_solution_one = solution_one[0...pivot] + solution_two[pivot..-1]
	new_solution_two = solution_two[0...pivot] + solution_one[pivot..-1]
	
	return new_solution_one, new_solution_two

end

#We evaluate scores based on number of vowels, and return a score (high score is betetr)
def evaluation (solution)
	#Extract vowels
	vowels = solution.scan( /[aeiouy]/)
	#Count the number of vowels
	vowels.length
end

def start
	initialization
	@best_solution = nil
	@best_solution_score = -1
	# Number of generations
	#@@GENERATIONS.times do | generation |
	generation = 0
	while @best_solution_score != 100
		generation+=1
		local_best_solution = nil
		local_best_solution_score = -1
	
		breeding_pool = Array.new
		#establish the breeding pool, weighted to allow higher performing solutions to be more likely to be picked.
		sum = 0
		@population.each do |solution|
			# See if we have a new local best solution
			score = evaluation solution
			sum = sum + score
			if(local_best_solution_score < score)
				local_best_solution_score = score
				local_best_solution = solution
			end
		end
		
		#Update best solution
		if(local_best_solution_score > @best_solution_score)
			@best_solution_score = local_best_solution_score
			@best_solution = local_best_solution
		end	
		
		# The above will be very memory intensive near the end
		# (the above array could be POPULATION_SIZE * GENETIC_SIZE, if all solutions are optimal)
		# Will implement a memory conservative solution in the near future
		
		#develop new solutions
		new_population = Array.new
		#each breed will generate 2 solutions, so we need to do it for half the population size
		(@@POPULATION_SIZE/2).times do
			#breed_1 = breeding_pool[breeding_pool.length * rand ]
			breed_1 = tournament_selection @population
			breed_2 = breed_1
			
			#This loop will ensure that the two breeders are not the same solution
			while breed_1 == breed_2
				breed_2 = tournament_selection @population
			end
			new_1, new_2 = breed(breed_1, breed_2)
			new_population.push(new_1)
			new_population.push(new_2)
		end
		
		#Handle mutation check
		new_population.each do |solution|
			if( rand > @@MUTAION_SOLUTION_CHANCE = 0.05)
				mutation!(solution)
			end
		end
		
				
		# We're also going to keep the best performing solution in the population, to make sure the
		# population is progressing towards a better solution
		new_population[-1] = @best_solution
		
		#work is done - replace the old pool with the new one for the next generation
		@population = new_population
		
		#Print best performing solution this generation
		puts "#{generation}. Best Performing solution: #{local_best_solution_score} (Average: #{sum / @@POPULATION_SIZE})"
		#puts "#{local_best_solution}"
		#puts "Best Performing solution: #{@best_solution_score}"
	end
	
	puts "Best Performing solution overall: #{@best_solution_score}"
	puts "#{@best_solution}"
end

if __FILE__ == $0
	start
end