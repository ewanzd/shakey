% load search algorithm
:- load_files('searchAlgorithm/deepSearch.pl').
% load scenario
:- load_files('scenarios/shakeysApartment.pl').

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
