has_all_ingredients(RequiredIngredients, Ingredients) :-
    forall(member(Element, RequiredIngredients), member(Element, Ingredients)).


recipe("bigos", ["kiełbasa", "kapusta"]).
recipe("bigos ale lepszy", ["kiełbasa", "kapusta", "sól"]).
recipe("bigos ale bez kiełbasy", ["kapusta"]).

:- dynamic(custom_recipe/2).

recipe(X, Y) :- custom_recipe(X, Y).

get_recipes(X, Ingredients) :- recipe(X, Required), has_all_ingredients(Required, Ingredients).