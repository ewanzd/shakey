% ===============================================================

% load helper with stack, queue and set predicates
:- [stack].
:- [set].
:- [actions].

% ===============================================================

% planner(Current state, Goal, Made steps, Made actions).

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

% check pre conditions met set
match_conditions(State1, State2) :- subset(State1, State2).

% add/delete states from state set
change_state(State, [], State).
change_state(State, [add(Element)|Remain], New_State) :-
  change_state(State, Remain, State2),
	add_to_set(Element, State2, New_State), !.
change_state(State, [del(Element)|Remain], New_State) :-
  change_state(State, Remain, State2),
	remove_from_set(Element, State2, New_State), !.

% ===============================================================

% Start point
% go(World, Start state, Goal state).

% Start (add world state to start and goal state)
go(World, Initial, Goal) :-
  append(World, Initial, Initial_State),
  append(World, Goal, Goal_State),
  planner(Initial_State, Goal_State, [Initial_State], []).

% examples
test :-
  scenario(s1, World),
    go(
      % static world
      World,
      % start condition
      [handempty, inroom(sleeproom), onground(burger, kitchen)],
      % end condition
      [handempty, inroom(sleeproom), onground(burger, sleeproom)]
    ).
%test :- scenario(s1, World), go(World, [handempty, inroom(kitchen), onground(burger, kitchen)], [handempty, inroom(sleeproom), onground(burger, sleeproom)]).
:- include('scenarios/shakeysApartment.pl').
