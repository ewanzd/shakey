empty_stack([]).

stack(Element, Stack, [Element|Stack]).

print_stack(Stack) :- empty_stack(Stack).
print_stack(Stack) :-
  stack(Element, Rest, Stack),
	print_stack(Rest),
	write(Element), nl. % n1 -> new line
