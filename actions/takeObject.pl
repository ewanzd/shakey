action(
  pickup(Room, Object),
  [handempty, onground(Object, Room), inroom(Room)],
  [del(handempty), del(onground(Object, Room)), add(holding(Object))]
).
