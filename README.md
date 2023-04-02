# Rosalind problems

This repo contains my solutions to the bioinformatics problems at https://rosalind.info/problems

## To run the solutions

- `ruby runner.rb` runs all the solutions.
- `ruby runner.rb PROBLEM_ID` runs a single solution.
- `ruby runner.rb -o PROBLEM_ID` copies an input from `~/Downloads`, then runs the solution.

## Some fun ruby stuff I used along the way

### Zeitwerk

The runner module uses the [Zeitwerk](https://github.com/fxn/zeitwerk) autoloader to eager load all the code for the project, based on the directory structure. This saves me writing lots of 'require' statements.

### Characterization testing

The runner uses [characertization testing](https://en.wikipedia.org/wiki/Characterization_test) to ensure my previous solutions don't break when refactoring code.

This works great for exercises like this, since my definition of working code is simply: "does it produce a solution that was marked correct?".

### Data classes

Ruby 3.2 added a new data class for defining immutable value objects. I use it in the `GeneticString` module for modelling DNA and RNA.

I made the classes themselves private and provided factory methods to make sure sequences are valid when constructing these values.
