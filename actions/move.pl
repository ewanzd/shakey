action(
  move(From, To),
  [inroom(From), connect(From, To)],
  [del(inroom(From)), add(inroom(To))]
).
