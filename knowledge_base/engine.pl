:- dynamic(ingredients/1).

has_all_ingredients(RequiredIngredients) :-
    forall(member(Element, RequiredIngredients), all_ingredients(Element)).

mieso_count(Count) :- !,
        findall(X, (mieso(X), all_ingredients(X)), L),
        length(L, Count).

mieso("wołowina") .
mieso("wieprzowina"). 
mieso("drób").

all_ingredients(X) :- ingredients(X).

all_ingredients("mięso mielone") :- all_ingredients("wołowina"); all_ingredients("wieprzowina").

all_ingredients("wołowina") :- all_ingredients("karkówka wołowa"); all_ingredients("łopatka wołowa").
all_ingredients("wieprzowina") :- all_ingredients("schab"); all_ingredients("polędwiczka"); all_ingredients("szynka").
all_ingredients("drób") :- all_ingredients("udka"); all_ingredients("skrzydełka"); all_ingredients("pierś z kurczaka").

fruits_count(Count) :- !,
        findall(X, (fruit(X), all_ingredients(X)), L),
        length(L, Count).

fruit("jabłko").
fruit("truskawka").
fruit("banan").

vegetable_count(Count) :- !,
        findall(X, (vegetable(X), all_ingredients(X)), L),
        length(L, Count).

vegetable("marchewka").
vegetable("ziemniak").
vegetable("cebula").
vegetable("pomidor").
vegetable("ogórek").


recipe("bigos") :- has_all_ingredients(["kiełbasa", "kapusta"]).
recipe("rosół") :- mieso_count(M), M > 0, vegetable_count(C), C>0.
recipe("schabowy z ziemiakami") :- has_all_ingredients(["schab", "ziemniak"]).
recipe("spaghetti bolognese") :- has_all_ingredients(["mięso mielone", "pomidor", "olej", "czosnek"]).
recipe("sałatka owocowa") :- fruits_count(C), C>1.
recipe("sałatka warzywna") :- vegetable_count(C), C>2.

recipe(X) :- custom_recipe(X, RequiredIngredients), has_all_ingredients(RequiredIngredients).

get_recipes(X) :- recipe(X).

:- dynamic(custom_recipe/2).