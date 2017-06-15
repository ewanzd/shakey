action(
  putdown(Room, Object),
  [holding(Object), inroom(Room)],
  [del(holding(Object)), add(handempty), add(onground(Object, Room))]
).
