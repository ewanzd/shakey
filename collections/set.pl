% add to set
add_to_set(Element, Set, Set) :- member(Element, Set), !.
add_to_set(Element, Set, [Element|Set]).

% remove from set
remove_from_set(_, [], []).
remove_from_set(Element, [Element|Set], Set) :- !.
remove_from_set(Element, [H|T], [H|Set_New]) :- remove_from_set(Element, T, Set_New), !.

% check if set are equal
equal_set(Set1, Set2) :- subset(Set1, Set2), subset(Set2, Set1).

% check if set is part of the list of sets
member_state(S, [H|_]) :- equal_set(S, H).
member_state(S, [_|T]) :- member_state(S, T).
