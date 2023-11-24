%   Authored by Steven Aziz
%   11-23-2023

:- use_module(library(csv)).

%   Square procedure
%   Takes number X and outputs X^2
square(X, R) :-
    R is X * X.

%   Multiply procedure
%   Takes numbers X and Y and outputs X*Y
mult(X, Y, R) :-
    R is X * Y.

%   Square Diff procedure
%   Takes numbers A and B and outputs (A-B)^2
square_diff(A, B, R) :-
    square(A - B, R).

%   Round to 4 procedure
%   Takes number X and outputs X rounded to 4 decimal places
round_to_4(X, R) :-
    R is (round(X * 10000) / 10000).

%   Mean procedure
%   Takes list of numbers L and outputs the rounded average M
mean(L, M) :-
    sumlist(L, SUM),
    length(L, N),
    (N = 0 -> M is 0; round_to_4(SUM / N, M)).

%   Standard Deviation procedure
%   Takes list of numbers L and outputs the rounded standard deviation S
stddev(L, S) :-
    mean(L, MEAN),
    maplist(square_diff(MEAN), L, RESULT),
    sumlist(RESULT, SIGMA),
    length(L, N),
    (N = 0 -> S is 0; round_to_4(sqrt(SIGMA / N), S)).

%   Regression Alpha procedure
%   Takes two lists of numbers and outputs the rounded SLOPE of the linear regression
regressiona(X, Y, A) :-
    sumlist(X, SIGMAX),
    sumlist(Y, SIGMAY),
    maplist(square, Y, SQUAREY),
    sumlist(SQUAREY, SIGMASQUAREY),
    maplist(mult, X, Y, XY),
    sumlist(XY, SIGMAXY),
    length(XY, N),
    round_to_4(((SIGMAXY * N) - (SIGMAX * SIGMAY)) / ((SIGMASQUAREY * N) - (SIGMAY * SIGMAY)), A).

%   Regression Beta procedure
%   Takes two lists of numbers and outputs the rounded Y-INTERCEPT of the linear regression
regressionb(X, Y, B) :-
    sumlist(X, SIGMAX),
    sumlist(Y, SIGMAY),
    maplist(square, Y, SQUAREY),
    sumlist(SQUAREY, SIGMASQUAREY),
    maplist(mult, X, Y, XY),
    sumlist(XY, SIGMAXY),
    length(XY, N),
    round_to_4(((SIGMAX * SIGMASQUAREY) - (SIGMAY * SIGMAXY)) / ((SIGMASQUAREY * N) - (SIGMAY * SIGMAY)), B).

%   Pearson Correlation procedure
%   Takes two lists of numbers and outputs rounded number between -1 and 1 corresponding to the Pearson Correlation Coefficient
%   Measure strength of relationship between xvalues and yvalues
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

%   Load Data Column function
%   Takes filename of csv (as string), boolean corresponding to header present, and column number
%   Outputs List of values in that column
load_data_column(File, Header, C, List) :-
    ColNum is (C + 1), % The predicate arg\3 starts counting at 1
    (csv_read_file(File, Rows, []) -> % Creates array of terms; each term has N arguments
        true;
        writeln('Error: Could not open the file.'),
        fail
    ),
    (Header ->
        Rows = [_|Rest], % Rest is an array with the first element of Rows discarded
        Data = Rest; % Data is the final array of terms to be processed
        Data = Rows
    ),
    (maplist(arg(ColNum), Data, List) -> % Applies arg\3 predicate to each element (term) in Data
        true;
        writeln('Error: Could not extract the column from the file.'),
        fail
    ).
%       Test File for Prolog Assignment

%       Data Definitions

sat([1714,1664,1760,1685,1693,1764,1764,1792,1850,1735]).
gpa([2.4,2.52,2.54,2.74,2.83,3,3,3.01,3.01,3.02]).

writeln(T) :- write(T), nl.

main :-
        gpa(Gpa), % Get GPA List
        sat(Sat), % Get SAT List
        mean(Gpa, MeanG), % Get Mean GPA
        mean(Sat, MeanS), % Get Mean SAT
        stddev(Gpa, SDG), % Get Standard Deviation of GPA
        stddev(Sat, SDS), % Get Standard Deviation of SAT
        regressiona(Gpa, Sat, A), % Get Regression alpha parameter
        regressionb(Gpa, Sat, B), % Get Regression beta parameter
        correlation(Gpa, Sat, R), % Get Pearson Correlation Coefficient
        % [10,11,12,14,9]
        load_data_column('data1.csv', false, 0, ListOne), % Load Data from CSV
        % [10,11,12,14,9]
        load_data_column('data2.csv', true, 0, ListTwo), % Load Data from CSV
        % [1714,1664,1760,1685,1693,1764,1764,1792,1850,1735]
        load_data_column('sat-gpa.csv', true, 1, ListThree), % Load Data from CSV

        % 2.8070
        writeln(MeanG),
        % 1742.1
        writeln(MeanS),
        % 0.2295
        writeln(SDG),
        % 52.9367
        writeln(SDS),
        % 0.0025 Wolfram Alpha: 0.00252447
        writeln(A),
        % -1.5909 Wolrfram Alpha: -1.59088
        writeln(B),
        % 0.5823 Wolfram Alpha: 0.582348
        writeln(R),
        % [10,11,12,14,9]
        writeln(ListOne),
        % [10,11,12,14,9]
        writeln(ListTwo),
        % [1714,1664,1760,1685,1693,1764,1764,1792,1850,1735]
        writeln(ListThree).
