scenario(s1, W) :- W = [
  connect(sleeproom, corridor),
  connect(corridor, livingroom),
  connect(livingroom, kitchen),
  connect(corridor, washroom)
].
