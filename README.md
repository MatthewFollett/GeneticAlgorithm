Genetic Algorithm

This is an implementation of a Genetic Algorithm using Ruby. The problem it is solving is finding a String with the most amount of vowels.

Selection
	Roulette Wheel (Phase 1)
		The first version of this software used a Roulette Wheel - giving higher scoring solutions a higher chance of being selected for crossover. The first implementation was memory intesive, only as a quick fix
		
	Tournament Selection
		The second phase switched the selection algorithm to Tournament Selection - it picks 8 random solutions, and selects the best performing solution for crossover.

Other Ideas:
	Implement Tournament-Style Selection
	Implement multiple crossover algorithms (for breeding)