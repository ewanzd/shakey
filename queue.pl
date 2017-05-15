% add to queue
enqueue(Element, Queue, NewQueue) :- append(Queue, [Element], NewQueue).

% remove from queue
dequeue([], [], []).
dequeue([Element|RestQueue], Element, RestQueue).
