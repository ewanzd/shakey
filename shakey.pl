% ===============================================================

% load helper with stack, queue and set predicates
:- [stack].
:- [queue].
:- [set].

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

% print all actions (nl = new Line)
print_stack(Stack) :- empty_stack(Stack).
print_stack(Stack) :-
    stack(Element, Rest, Stack),
	print_stack(Rest),
	write(Element), nl.

% ===============================================================

% List with possible actions
% moves(Action, Preconditions, Effects).

% move
action(move(From, To),
    [inroom(From), connect(From, To)],
    [del(inroom(From)), add(inroom(To))]).

% move back
action(move(From, To),
    [inroom(To), connect(From, To)],
    [del(inroom(To)), add(inroom(From))]).

% take object
action(pickup(Room, Object),
    [handempty, onground(Object, Room), inroom(Room)],
    [del(handempty), del(onground(Object, Room)), add(holding(Object))]).

% put object
action(putdown(Room, Object),
    [holding(Object), inroom(Room)],
    [del(holding(Object)), add(handempty), add(onground(Object, Room))]).

% ===============================================================

% Start point
% go(World, Start state, Goal state).

% Start (add world state to start and goal state)
go(World, Initial, Goal) :-
    append(World, Initial, Initial_State),
    append(World, Goal, Goal_State),
    planner(Initial_State, Goal_State, [Initial_State], []).

% examples
test :- scenario(s1, World), go(World, [handempty, inroom(sleeproom), onground(burger, kitchen)], [handempty, inroom(sleeproom), onground(burger, sleeproom)]).
%test :- scenario(s1, World), go(World, [handempty, inroom(kitchen), onground(burger, kitchen)], [handempty, inroom(sleeproom), onground(burger, sleeproom)]).

% world scenarios
scenario(s1, W) :- W = [connect(sleeproom, corridor), connect(corridor, livingroom), connect(livingroom, kitchen), connect(corridor, washroom)].

% world state
%connect(RoomA, RoomB).

% world state which could change
%onground(Object, Room).

% robo state
%handempty
%inroom(Room).
%holding(Object).
