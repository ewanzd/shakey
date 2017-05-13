% Breitensuche (Queue) Welt, Start -> Goal
% Startzustand -> Zustand 1/Zustand 2/Zustand 3
% Ziel: Liste mit Operationen

% ===============================================================

% load helper with stack and set predicates
:- [lists_helper].

% ===============================================================

% planner(World, Current state, Goal, Made steps, Made actions).

% base case: print all actions
planner(State, Goal, _, Actions) :-
      equal_set(State, Goal),
			print_stack(Actions).

% find solution with depth-first search
planner(State, Goal, Made_Steps, Made_Actions) :-
      action(Action, Preconditions, Effects),
      %match_world_state(Action, World),
      match_conditions(Preconditions, State),
      change_state(State, Effects, Child_State),
      not(member_state(Child_State, Made_Steps)),
      stack(Child_State, Made_Steps, New_Made_Steps),
      stack(Action, Made_Actions, New_Actions),
      planner(Child_State, Goal, New_Made_Steps, New_Actions), !.

/*planner(_, Goal, Steps, Actions) :-
      dequeue(Steps, State, _),
      equal_set(State, Goal),
			print_stack(Actions).

planner(World, Goal, Queue_Steps, Queue_Actions) :-
      % get next stack of action/state
      dequeue(Queue_Steps, Stack_Steps, Temp_Queue_Steps),
      dequeue(Queue_Actions, Stack_Actions, Temp_Queue_Actions),
      % try all possible actions
      action(Action, Preconditions, Effects),
      match_world_state(Action, World),

      stack(Last_Step, Stack_Steps, _),
      match_conditions(Preconditions, Last_Step),
      change_state(Last_Step, Effects, Child_State),
      not(member_state(Child_State, Stack_Steps)),
      enqueue(Child_State, Temp_Queue_Steps, Next_Queue_Steps),
      % add action to queue
      stack(Action, Stack_Actions, _),
      enqueue(Stack_Actions, Temp_Queue_Actions, Next_Queue_Actions),
      planner(World, Goal, Next_Queue_Steps, Next_Queue_Actions), !.*/

% check if step is ok with world state
/*match_world_state(move(X, Y), World_State) :-
      member(connect(X, Y), World_State);
      member(connect(Y, X), World_State), !.
match_world_state(_, _).*/

% check pre conditions met set
match_conditions(State1, State2) :- subset(State1, State2).

% add/delete states from state set
change_state(S, [], S).
change_state(S, [add(P)|T], S_new) :-
        change_state(S, T, S2),
				add_to_set(P, S2, S_new), !.
change_state(S, [del(P)|T], S_new) :-
        change_state(S, T, S2),
				remove_from_set(P, S2, S_new), !.

% print all actions
print_stack(Stack) :- empty_stack(Stack).
print_stack(Stack) :-
        stack(Element, Rest, Stack),
				print_stack(Rest),
		 		write(Element), nl.

% ===============================================================

% List with possible actions
% moves(Action, Preconditions, Effects)

% move
action(move(From,To),
      [onroom(From), connect(From, To)],
      [del(onroom(From)), add(onroom(To))]).

% move back
action(move(From,To),
      [onroom(To), connect(From, To)],
      [del(onroom(To)), add(onroom(From))]).

% take object
action(pickup(Object, Room),
      [handempty, onground(Object, Room), onroom(Room)],
      [del(handempty), del(onground(Object, Room)), add(holding(Object))]).

% put object
action(putdown(Object, Room),
      [holding(Object), onroom(Room)],
      [del(holding(Object)), add(handempty), add(onground(Object, Room))]).

% ===============================================================

% Start point
% go(World, Start state, Goal state).

% Start
go(World, Initial, Goal) :-
      append(World, Initial, Initial_State),
      append(World, Goal, Goal_State),
      planner(Initial_State, Goal_State, [Initial_State], []).

%go(World, Initial, Goal) :- planner(World, Goal, [Initial], []).

% example
test :- scenario(s1, World), go(World, [handempty, onroom(sleeproom), onground(burger, kitchen)], [handempty, onroom(sleeproom), onground(burger, sleeproom)]).
%test :- scenario(s1, World), go(World, [handempty, onroom(kitchen), onground(burger, kitchen)], [handempty, onroom(sleeproom), onground(burger, sleeproom)]).

% world scenarios
scenario(s1, W) :- W = [connect(sleeproom, corridor), connect(corridor, livingroom), connect(livingroom, kitchen), connect(corridor, washroom)].

% world state
%connect(RoomA, RoomB).

% world state which could change
%onground(Object, Room).

% robo state
%handempty
%onroom(Room).
%holding(Object).
