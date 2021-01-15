#include ('list_input.pl').

% need new rules
prokaryote(G) :- not eukaryote(G).
eukaryote(G) :- not prokaryote(G).

promoter(G, IndexStartSite, IndexPribnow, IndexSecond) :-
    	% tss - transcription start site
    	tss(G, S, IndexStartSite), 
	subsequence(P, G, IndexPribnow),pribnowbox(P),
    	% P appears approximately 10 nucleotides before S
	IndexStartSite - IndexPribnow .=. 10,
	subsequence(X, G, IndexSecond),
	% and X is similar to the consensus sequence “TTGACA”
	similar(X, ['t','t','g','a','c','a']),
	% and X appears approximately 35 nucleotides before S
	IndexStartSite - IndexSecond .=. 35,
	prokaryote(G).

pribnowbox(P) :- 
	list_length(P, 0, L1),
	L1 .=. 6,
	similar(P, ['t','a','t','a','a','t']).

promoter(G, IndexStartSite, IndexTata, -1) :-
    	tss(G, S, IndexStartSite), 
	subsequence(P, G, IndexTata),tatabox(P),
	IndexStartSite - IndexTata .=. 25,
	eukaryote(G).

tatabox(P) :- similar(P, ['t','a','t','a','a','a','a']).
tatabox(P) :- similar(P, ['t','a','t','a','a','a','t']).
tatabox(P) :- similar(P, ['t','a','t','a','t','a','a']).
tatabox(P) :- similar(P, ['t','a','t','a','t','a','t']).

stop_codon(['t', 'a', 'g']).
stop_codon(['t', 'a', 'a']).
stop_codon(['t', 'g', 'a']).

reversed_stop_codon(P) :-
	stop_codon(Q),
	reverse_list(Q, P).

% Generate all O(N^2) sublists of the input list
generate_sublists([Head | Tail], Result, 0) :-
	generate_prefixlists([Head | Tail], Result).
generate_sublists([_ | Tail], Result, Index) :-
	generate_sublists(Tail, Result, Index2),
	Index is Index2 + 1.

% Generate prefixes of the given list
generate_prefixlists([Head | _], [Head | []]).
generate_prefixlists([Head | Tail], [Head | Result]) :-
	generate_prefixlists(Tail, Result).	

% Finds all transcription sections in the Genome.
% Transcription sections should start with a start codon and end with a stop codon.
% However, there should not be any stop codons in the 'body' of the section.
tss(Genome, Candidate, Index) :-
	generate_sublists(Genome, Candidate, Index),
	reverse_list(Candidate, ReverseCandidate),
	prefix_match(['a', 't', 'g'], Candidate),
	reversed_stop_codon(Stop2),
	prefix_match(Stop2, ReverseCandidate).

reverse_list(InputList, OutputList) :- reverse_list(InputList, [], OutputList).

reverse_list([], Acc, Acc).
reverse_list([Head | Tail], Acc, Reversed) :- reverse_list(Tail, [Head | Acc], Reversed).  

list_length( []     , L , L ) .
list_length( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  list_length(Xs,T1,L).

% have the same base pair in at least 4 positions
similar(X, C) :- 
	num_match(X, C, NumMatches),
	NumMatches >= 4.

% Returns the number of positions in the two lists that match
num_match(_, [], 0).
num_match([], _, 0).
num_match([Head | Tail1], [Head | Tail2], Result) :-
	num_match(Tail1, Tail2, Result2),
	Result is Result2 + 1.
num_match([Head1 | Tail1], [Head2 | Tail2], Result) :-
	Head1 \= Head2,
	num_match(Tail1, Tail2, Result).

prefix_match([], _).
prefix_match([H | T1], [H | T2]) :- prefix_match(T1, T2).

subsequence(Pattern, Sequence, 0) :- prefix_match(Pattern, Sequence).
subsequence(Pattern, [_ | Tail], Index) :-
        subsequence(Pattern, Tail, Index2),
        Index is Index2 + 1.

% Searches for `Pattern` in `Sequence` but ignores the subsequence
% if it begins at index 0
subsequence_ignore0(Pattern, Sequence) :-
	subsequence(Pattern, Sequence, Index),
	Index > 0.

% ?- prefix_match([a, b, c], [a, b, c, d, e]).
% ?- prefix_match([a, e, c], [a, b, c, d, e]).

% ?- subsequence([a, b], [b, c, a, b, e, a, b], I).
% ?- subsequence([a, b], [b, c, a, d, e], I).

% ?- sequence(DNA), promoter(DNA).

% ?- similar([a, b, d, e], [a, b, d, e]).

% ?- generate_sublists([a, b, c, d], X).

% ?- reverse_list([a, b, c, d], R).

% ?- subsequence_ignore0([a, b], [a, b, c, b], X).
% ?- subsequence_ignore0([a, b], [a, b, a, b], X).

% ?- tts(['a', 't', 'g', 't', 'a', 'g'], X).
% ?- tts(['a', 't', 'g', 'c', 'c', 't', 'a', 'a', 't', 'a', 'g'], X). 
% ?- tts(['a', 't', 'c', 'c', 't', 'a', 'a', 't', 'a', 'g'], X). 

% ?- sequence(X), tss(X, S).
?- sequence(X), promoter(X, A, B, C).
