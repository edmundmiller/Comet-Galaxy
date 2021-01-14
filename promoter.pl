% need new rules
bacteria(_).
eukaryote(_).
% tss(S):-.

promoter(G) :-
    % tss - transcription start site
    tss(S), subsequence(S,G,IndexS),
	prefix_match(['a','t','g'],S),
	subsequence(P, G, IndexP),pribnowbox(P),
    % P appears approximately 10 nucleotides before S
	IndexS - IndexP .=. 10,
	subsequence(X, G, IndexX),
	% and X is similar to the consensus sequence “TTGACA”
	similar(X, ['t','t','g','a','c','a']),
	% and X appears approximately 35 nucleotides before S
	IndexS - IndexX .=. 35,
	bacteria(G).

pribnowbox(P) :- 
	list_length(P, 0, L1),
	L1 .=. 6,
	similar(P, ['t','a','t','a','a','t']).

promoter(G) :-
	tss(S), subsequence(S,G,IndexS),
	prefix_match(['a','t','g'],S),
	subsequence(P, G, IndexP),tatabox(P),
	IndexS - IndexP .=. 25,
	eukaryote(G)

tatabox(P) :- P .=. similar(P, ['t','a','t','a','a','a','a']).
tatabox(P) :- P .=. similar(P, ['t','a','t','a','a','a','t']).
tatabox(P) :- P .=. similar(P, ['t','a','t','a','t','a','a']).
tatabox(P) :- P .=. similar(P, ['t','a','t','a','t','a','t']).

list_length( []     , L , L ) .
list_length( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  list_length(Xs,T1,L).

% have the same base pair in at least 4 positions
similar(X, C) :- .

prefix_match([], _).
prefix_match([H | T1], [H | T2]) :- prefix_match(T1, T2).

subsequence(Pattern, Sequence, 0) :- prefix_match(Pattern, Sequence).
subsequence(Pattern, [_ | Tail], Index) :-
        subsequence(Pattern, Tail, Index2),
        Index is Index2 + 1.

% ?- prefix_match([a, b, c], [a, b, c, d, e]).
% ?- prefix_match([a, e, c], [a, b, c, d, e]).

?- subsequence([a, b], [b, c, a, b, e, a, b], I).
% ?- subsequence([a, b], [b, c, a, d, e], I).

