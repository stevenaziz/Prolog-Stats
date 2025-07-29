# Prolog Statistical Analysis Program

## Project Overview

For this project, I developed a Prolog program that performs basic statistical calculations and linear regression analysis on numerical data. The goal was to leverage Prolog’s declarative programming paradigm to handle data processing and inference, which is quite different from imperative or object-oriented programming styles I had worked with before.

## What I Built

I created a suite of Prolog rules that can:

* **Load a specific column of numerical data from a CSV file**, supporting files both with and without header rows.
* **Calculate the mean (average)** of a list of numbers.
* **Calculate the standard deviation** of a list of numbers using the population standard deviation formula.
* **Compute linear regression parameters** — the slope (α) and intercept (β) — for two data sets representing x and y values.
* **Calculate the Pearson correlation coefficient** to measure the strength of the linear relationship between two sets of numbers.

## How It Works

Using a CSV file as input, my program reads data columns into Prolog lists, then applies mathematical rules to compute statistical measures and derive a simple linear model $y = \alpha x + \beta$. The program can then use this model for further analysis or prediction tasks.

## Technical Highlights

* Implemented all logic using pure Prolog rules, showcasing declarative problem-solving.
* Designed meaningful predicate names and structured code for readability and maintainability.
* Developed a robust CSV parsing method to handle different file formats with minimal assumptions.
* Ensured compatibility with SWI-Prolog command line tools for automated testing and grading.

## Testing and Validation

I thoroughly tested the program by combining my code with provided test scripts and running them using SWI-Prolog’s command line interface. The output was verified against expected results using automated scripts to ensure accuracy and reliability.

## Why This Matters

This project enhanced my skills in logic programming and declarative thinking, key for AI and symbolic reasoning tasks. It also demonstrated my ability to work with less common programming paradigms and data formats, broadening my software development toolkit.
