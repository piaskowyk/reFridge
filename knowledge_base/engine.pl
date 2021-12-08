:- dynamic(ingredients/1).

has_all_ingredients(RequiredIngredients) :-
        forall(member(Element, RequiredIngredients), all_ingredients(Element)).

has_any_ingredients(PossibleIngredients) :-
        member(X, PossibleIngredients), all_ingredients(X).

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

all_ingredients(X) :- ingredients(X); recipe(X).
all_ingredients("mięso mielone") :- has_any_ingredients(["wołowina", "wieprzowina"]).
all_ingredients("wołowina") :- has_any_ingredients(["karkówka wołowa", "łopatka wołowa"]).
all_ingredients("wieprzowina") :- has_any_ingredients(["schab", "polędwiczka", "szynka", "boczek"]).
all_ingredients("drób") :- has_any_ingredients(["udka", "skrzydełka", "pierś z kurczaka"]).

all_ingredients("dżem") :- has_any_ingredients(["marmolada", "dżem truskawkowy", "dżem malinowy", "powidło"]).
all_ingredients("pieczywo") :- has_any_ingredients(["chleb", "bułka", "chleb tostowy", "chleb pszenny", "chleb razowy"]).

recipe("bigos") :- has_all_ingredients(["kiełbasa", "kapusta"]).
recipe("bitki") :- has_all_ingredients(["olej", "wołowina"]).
recipe("rosół") :- mieso_count(M), M > 0, vegetable_count(C), C > 0.
recipe("schabowy z ziemiakami") :- has_all_ingredients(["schab", "ziemniak"]).
recipe("spaghetti bolognese") :- has_all_ingredients(["mięso mielone", "pomidor", "olej", "czosnek", "makaron"]).
recipe("sałatka owocowa") :- fruits_count(C), C > 1.
recipe("sałatka warzywna") :- vegetable_count(C), C > 2.
recipe("sałatka warzywna z majonezem") :- has_all_ingredients(["sałatka warzywna", "majonez"]).
recipe("mięsne tornado") :- mieso_count(C), C > 2.
recipe("burger") :- mieso_count(C), C > 0, has_all_ingredients(["olej"]), has_any_ingredients(["chleb", "chleb tostowy"]).
recipe("basic kanapka") :- has_all_ingredients(["masło", "pieczywo"]), has_any_ingredients(["szynka", "ser"]).
recipe("tosty") :- has_any_ingredients(["chleb", "bułka"]), has_any_ingredients(["ser"]).
recipe("parówki w cieście") :- has_all_ingredients(["olej", "parówka", "mąka", "woda", "sól", "drożdże"]).
recipe("placki ziemniaczane") :- has_all_ingredients(["olej", "ziemniaki", "mąka ziemniaczana", "woda", "sól"]).
recipe("frytki") :- has_all_ingredients(["olej", "ziemniaki", "keczup", "sól"]).
recipe("naleśniki") :- has_all_ingredients(["olej", "mąka", "mleko", "jajko"]).
recipe("naleśniki z dżemem") :- has_all_ingredients(["naleśniki", "dżem"]).
recipe("gofry") :- has_all_ingredients(["olej", "mąka", "mleko", "jajko"]).
recipe("jajecznicza") :- has_all_ingredients(["olej", "jajko", "sól"]).
recipe("jajecznicza mięsna") :- has_all_ingredients(["jajecznicza"]), mieso_count(C), C > 0.
recipe("jajecznicza ważywna") :- has_all_ingredients(["jajecznicza"]), vegetable_count(C), C > 0.
recipe("beza") :- has_all_ingredients(["olej", "jajko", "cukier"]).
recipe("gorąca czekolada") :- has_all_ingredients(["mleko", "kakao", "cukier"]).
recipe("kopiec kreta") :- has_all_ingredients(["mąka", "kakao", "cukier", "proszek do pieczenia", "mleko", "masło"]).
recipe("kremówka") :- has_all_ingredients(["wafel", "margaryna"]).
recipe("gyros") :- has_all_ingredients(["drób", "przyprawa gyros","śmietana"]), vegetable_count(C), C > 1.
recipe("gyros w picie") :- has_all_ingredients(["gyros", "pita"]).

recipe(X) :- custom_recipe(X, RequiredIngredients), has_all_ingredients(RequiredIngredients).

get_recipes(X) :- recipe(X).

:- dynamic(custom_recipe/2).
