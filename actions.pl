% List with possible actions
% action(Action, Preconditions, Effects).

% move
action(
  move(From, To),
  [inroom(From), connect(From, To)],
  [del(inroom(From)), add(inroom(To))]
).

% move back
action(
  move(From, To),
  [inroom(To), connect(From, To)],
  [del(inroom(To)), add(inroom(From))]
).

% take object
action(
  pickup(Room, Object),
  [handempty, onground(Object, Room), inroom(Room)],
  [del(handempty), del(onground(Object, Room)), add(holding(Object))]
).

% put object
action(
  putdown(Room, Object),
  [holding(Object), inroom(Room)],
  [del(holding(Object)), add(handempty), add(onground(Object, Room))]
).
