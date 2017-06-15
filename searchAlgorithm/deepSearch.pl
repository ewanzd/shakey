:- load_files('../collections/stack.pl').
:- load_files('../collections/set.pl').
:- load_files('../matchConditions.pl').
:- load_files('../changeState.pl').
:- load_files('../actions.pl').

% base case: print all actions
planner(State, Goal, _, Actions) :-
  equal_set(State, Goal),
  print_stack(Actions).

% find solution with depth-first search
planner(State, Goal, Made_Steps, Made_Actions) :-
  action(Action, Preconditions, Effects),
  match_conditions(Preconditions, State),
  change_state(State, Effects, Child_State),
  not(member_state(Child_State, Made_Steps)),
  stack(Child_State, Made_Steps, New_Made_Steps),
  stack(Action, Made_Actions, New_Actions),
  planner(Child_State, Goal, New_Made_Steps, New_Actions), !.
