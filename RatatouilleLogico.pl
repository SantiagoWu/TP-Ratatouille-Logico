%rata(Nombre,Restaurante).
rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

%cocina(Nombre,Plato,Experiencia).
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5). 
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

%trabajaEn(Restaurante,Nombre).
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

%PUNTO 1
inspeccionSatisfactoria(Restaurante):-
	not(rata(_,Restaurante)).

%PUNTO 2
chef(Empleado,Restaurante):-
	trabajaEn(Restaurante,Empleado),
	cocina(Empleado,Plato,_).

%PUNTO 3
chefcito(Rata):-
	rata(Rata,Restaurante),
	trabajaEn(Restaurante,linguini).

%TAMBIEN PODRIA HABER SIDO
%chefcito(Rata):-
%	rata(Rata,Restaurante),
%	Restaurante=gusteaus.

%PUNTO 4
cocinaBien(Alguien,Plato):-
	cocina(Alguien,Plato,Experiencia),
	Experiencia>7.

cocinaBien(remy,_).

%PUNTO 5
encargadoDe(Alguien,Plato,Restaurante):-
	cocina(Alguien,Plato,Exp),
	trabajaEn(Restaurante,Alguien),
	forall((cocina(AlguienMas,Plato,Exp2),trabajaEn(Restaurante,AlguienMas),Alguien\=AlguienMas),Exp>Exp2).

%forall(condiciones para quien, que debe cumplir).

%PUNTO 6

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
	plato(Plato,entrada(Ingredientes)),
	length(Ingredientes,Cant),
	Calorias is Cant*15,
	Calorias<75.

saludable(Plato):-
	plato(Plato,principal(pure,HdeC)),
	Calorias is HdeC*5+20,
	Calorias<75.

saludable(Plato):-
	plato(Plato,principal(papasFritas,HdeC)),
	Calorias is HdeC*5+50,
	Calorias<75.

saludable(Plato):-
	plato(Plato,principal(ensalada,HdeC)),
	Calorias is HdeC*5,
	Calorias<75.

saludable(Plato):-
	plato(Plato, postre(Calorias)),
	Calorias<75.

grupo(carrizo-rizzato-wu).

saludable(NombGrupo):-grupo(NombGrupo).

%PUNTO 7

criticaPositiva(Restaurante,antonEgo):-
	inspeccionSatisfactoria(Restaurante),
	especialistasEnRatatouille(Restaurante).

especialistasEnRatatouille(Restaurante):-
	forall(trabajaEn(Alguien,Restaurante),cocinaBien(Alguien,ratatouille)).
