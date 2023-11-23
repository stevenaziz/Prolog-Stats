/*  Authored by Steven Aziz */
/*  11-22-2023 */

:- use_module(library(csv)).

/* Square procedure
    Takes number X and outputs X^2 */
square(X, R) :-
    R is X * X.

/*  Multiply procedure
    Takes numbers X and Y and outputs X*Y */
mult(X, Y, R) :-
    R is X * Y.

/*  Square Diff procedure
    Takes numbers A and B and outputs (A-B)^2 */
square_diff(A, B, R) :-
    square(A - B, R).

/*  Round to 4 decimal places procedure
    Takes number X and outputs X rounded to 4 decimal places */
round_to_4(X, R) :-
    R is (round(X * 10000) / 10000).

/*  Mean procedure
    Takes list of numbers L and outputs the average M */
mean(L, M) :-
    sumlist(L, SUM),
    length(L, N),
    round_to_4(SUM / N, M).

/*  Standard Deviation procedure
    Takes list of numbers L and outputs the standard deviation S */
stddev(L, S) :-
    mean(L, MEAN),
    maplist(square_diff(MEAN), L, RESULT),
    sumlist(RESULT, SIGMA),
    length(L, N),
    round_to_4(sqrt(SIGMA / N), S).

/*  Regression Alpha procedure
    Takes two lists of numbers and outputs the SLOPE of the linear regression */
regressiona(X, Y, A) :-
    sumlist(X, SIGMAX),
    sumlist(Y, SIGMAY),
    maplist(square, X, SQUAREX),
    sumlist(SQUAREX, SIGMASQUAREX),
    maplist(mult, X, Y, XY),
    sumlist(XY, SIGMAXY),
    length(XY, N),
    round_to_4(((SIGMAXY * N) - (SIGMAX * SIGMAY)) / ((SIGMASQUAREX * N) - (SIGMAX * SIGMAX)), A).

/*  Regression Beta procedure
    Takes two lists of numbers and outputs the Y-INTERCEPT of the linear regression */
regressionb(X, Y, B) :-
    sumlist(X, SIGMAX),
    sumlist(Y, SIGMAY),
    maplist(square, X, SQUAREX),
    sumlist(SQUAREX, SIGMASQUAREX),
    maplist(mult, X, Y, XY),
    sumlist(XY, SIGMAXY),
    length(XY, N),
    round_to_4(((SIGMAY * SIGMASQUAREX) - (SIGMAX * SIGMAXY)) / ((SIGMASQUAREX * N) - (SIGMAX * SIGMAX)), B).

/*  Pearson Correlation procedure
    Takes two lists of numbers and outputs number between -1 and 1 corresponding to the Pearson Correlation Coefficient
    Measure strength of relationship between xvalues and yvalues */
correlation(X, Y, R) :-
    sumlist(X, SIGMAX),
    sumlist(Y, SIGMAY),
    maplist(square, X, SQUAREX),
    sumlist(SQUAREX, SIGMASQUAREX),
    maplist(square, Y, SQUAREY),
    sumlist(SQUAREY, SIGMASQUAREY),
    maplist(mult, X, Y, XY),
    sumlist(XY, SIGMAXY),
    length(XY, N),
    round_to_4(((SIGMAXY * N) - (SIGMAX * SIGMAY)) / sqrt(((SIGMASQUAREX * N) - (SIGMAX * SIGMAX)) * ((SIGMASQUAREY * N) - (SIGMAY * SIGMAY))), R).

/*  Load Data Column function
    Takes filename of .csv (as string), boolean corresponding to header present, and column number
    Outputs list of all values in that column */
