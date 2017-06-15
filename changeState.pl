% add/delete states from state set
change_state(State, [], State).
change_state(State, [add(Element)|Remain], New_State) :-
  change_state(State, Remain, State2),
	add_to_set(Element, State2, New_State), !.
change_state(State, [del(Element)|Remain], New_State) :-
  change_state(State, Remain, State2),
	remove_from_set(Element, State2, New_State), !.
