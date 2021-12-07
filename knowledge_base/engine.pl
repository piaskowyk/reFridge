:- dynamic(ingredients/1).

has_all_ingredients(RequiredIngredients) :-
    forall(member(Element, RequiredIngredients), all_ingredients(Element)).

has_any_ingredients(PossibleIngredients) :-
        findall(X, (member(X, PossibleIngredients), ingredients(X)), _).

mieso_count(Count) :- !,
        findall(X, (mieso(X), all_ingredients(X)), L),
        length(L, Count).

vegetable_count(Count) :- !,
        findall(X, (vegetable(X), all_ingredients(X)), L),
        length(L, Count).

fruits_count(Count) :- !,
        findall(X, (fruit(X), all_ingredients(X)), L),
        length(L, Count).

fruit("brzoskwinia").
fruit("grusza").
fruit("jabłko").
fruit("morela ").
fruit("śliwka").
fruit("wiśnia ").
fruit("czereśnie").
fruit("cytryna").
fruit("grejpfrut").
fruit("mandarynka ").
fruit("pomarańcza").
fruit("figa").
fruit("granat").
fruit("mango").
fruit("daktyle").
fruit("kokos").
fruit("awokado").
fruit("malina").
fruit("winogrono").
fruit("agrest").
fruit("aronia").
fruit("borówk").
fruit("jeżyna").
fruit("malina").
fruit("malinojeżyna").
fruit("pigwa").
fruit("porzeczka").
fruit("żurawina").
fruit("truskawka").
fruit("ananas").
fruit("banan").
fruit("poziomka").
fruit("truskawka").

vegetable("bakłażan").
vegetable("bób").
vegetable("brokuł").
vegetable("brukiew").
vegetable("burak").
vegetable("cebula").
vegetable("cykoria").
vegetable("czosnek").
vegetable("dynia").
vegetable("fasola").
vegetable("groch").
vegetable("jarmuż").
vegetable("kalafior").
vegetable("kalarepa").
vegetable("kapusta").
vegetable("karczoch").
vegetable("koper").
vegetable("kukurydza").
vegetable("marchew").
vegetable("ogórek").
vegetable("papryka").
vegetable("ziemniak").
vegetable("pasternak").
vegetable("pietruszka").
vegetable("pomidor").
vegetable("por").
vegetable("roszponka").
vegetable("rzepa").
vegetable("rzeżucha").
vegetable("rzodkiew").
vegetable("rzodkiewka").
vegetable("salsefia").
vegetable("sałata").
vegetable("seler").
vegetable("skorzonera").
vegetable("szalotka").
vegetable("szczypiorek").
vegetable("szpinak").

mieso("wołowina").
mieso("schab").
mieso("cięlęcina").
mieso("wieprzowina").
mieso("drób").
mieso("jagnięcina").
mieso("dziczyzna").
mieso("baranina").
mieso("konina").
mieso("parówki").

all_ingredients(X) :- ingredients(X).
all_ingredients("mięso mielone") :- all_ingredients("wołowina"); all_ingredients("wieprzowina").
all_ingredients("wołowina") :- all_ingredients("karkówka wołowa"); all_ingredients("łopatka wołowa").
all_ingredients("wieprzowina") :- all_ingredients("schab"); all_ingredients("polędwiczka"); all_ingredients("szynka").
all_ingredients("drób") :- all_ingredients("udka"); all_ingredients("skrzydełka"); all_ingredients("pierś z kurczaka").

all_ingredients("dżem") :- all_ingredients("marmolada"); all_ingredients("dżem truskawkowy");
                           all_ingredients("dżem malinowy"); all_ingredients("powidło").
all_ingredients("pieczywo") :- all_ingredients("chleb"); all_ingredients("bułka");
                               all_ingredients("chleb tostowy"); all_ingredients("chleb pszenny");
                               all_ingredients("chleb razowy");.

recipe("bigos") :- has_all_ingredients(["kiełbasa", "kapusta"]).
recipe("bitki") :- has_all_ingredients(["olej", "wołowina"]).
recipe("rosół") :- mieso_count(M), M > 0, vegetable_count(C), C > 0.
recipe("schabowy z ziemiakami") :- has_all_ingredients(["schab", "ziemniak"]).
recipe("spaghetti bolognese") :- has_all_ingredients(["mięso mielone", "pomidor", "olej", "czosnek", "makaron"]).
recipe("sałatka owocowa") :- fruits_count(C), C > 1.
recipe("sałatka warzywna") :- vegetable_count(C), C > 2.
recipe("sałatka warzywna z majonezem") :- vegetable_count(C), C>2, has_all_ingredients(["majonez"]).
recipe("mięsne tornado") :- mieso_count(C), C > 2.
recipe("burger") :- mieso_count(C), C > 0, has_all_ingredients(["olej"]), has_any_ingredients(["chleb", "chleb tostowy"]).
recipe("basic kanapka") :- has_all_ingredients(["masło", "pieczywo"]), has_any_ingredients(["szynka", "ser"]).
recipe("tosty") :- has_any_ingredients(["chleb", "bułka"]), has_any_ingredients(["ser"]).
recipe("parówki w cieście") :- has_all_ingredients(["olej", "parówka", "mąka", "woda", "sól", "drożdże"]).
recipe("placki ziemniaczane") :- has_all_ingredients(["olej", "ziemniaki", "mąka ziemniaczana", "woda", "sól"]).
recipe("frytki") :- has_all_ingredients(["olej", "ziemniaki", "keczup", "sól"]).
recipe("naleśniki") :- has_all_ingredients(["olej", "mąka", "mleko", "jajko"]).
recipe("naleśniki z dżemem") :- has_all_ingredients(["olej", "mąka", "mleko", "jajko", "dżem"]).
recipe("gofry") :- has_all_ingredients(["olej", "mąka", "mleko", "jajko"]).
recipe("jajecznicza") :- has_all_ingredients(["olej", "jajko", "sól"]).
recipe("jajecznicza mięsna") :- has_all_ingredients(["olej", "jajko", "sól"]), mieso_count(C), C > 0.
recipe("jajecznicza ważywna") :- has_all_ingredients(["olej", "jajko", "sól"]), vegetable_count(C), C > 0.
recipe("beza") :- has_all_ingredients(["olej", "jajko", "cókier"]).
recipe("gorąca czekolada") :- has_all_ingredients(["mleko", "kakao", "cókier"]).

recipe(X) :- custom_recipe(X, RequiredIngredients), has_all_ingredients(RequiredIngredients).

get_recipes(X) :- recipe(X).

:- dynamic(custom_recipe/2).
