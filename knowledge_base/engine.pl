has_all_ingredients(RequiredIngredients, Ingredients) :-
    forall(member(Element, RequiredIngredients), member(Element, Ingredients)).


recipe("bigos", ["kiełbasa", "kapusta"]).
recipe("bigos ale lepszy", ["kiełbasa", "kapusta", "sól"]).
recipe("bigos ale bez kiełbasy", ["kapusta"]).

get_recipes(X, Ingredients) :- recipe(X, Required), has_all_ingredients(Required, Ingredients).