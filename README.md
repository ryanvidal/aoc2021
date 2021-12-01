# Advent of Code 2021

This time its Swift!

I set this up as a console application that prints answers for each part when run, and you can select the day from the array in `main.swift`.

In order to minimize the boilerplate for each day, each puzzle is set up as an implementation of a `DailySolver` that actually parses the input appropriately and performs the calculations, and a concrete instance of the `DailyPuzzleBase` class that uses the solver and input strings to drive the actual puzzle solving.
