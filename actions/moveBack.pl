action(
  move(From, To),
  [inroom(To), connect(From, To)],
  [del(inroom(To)), add(inroom(From))]
).
