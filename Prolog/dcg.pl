sentence(sentence(S,V,O)) -->
	subject(S),
	verb(V),
	object(O).

subject(subj(M,N)) -->
	modifier(M),
	noun(N).

object(obj(M,N)) -->
	modifier(M),
	noun(N).

modifier(mod(the)) --> [the].

noun(n(cat)) --> [cat].
noun(n(mouse)) --> [mouse].
noun(n(polar,bear)) --> [polar, bear].

verb(v(chases)) --> [chases].
verb(v(eats)) --> [eats].

