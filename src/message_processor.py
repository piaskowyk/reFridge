from pyswip import Prolog
import re

class MessageProcessor:
    prolog = Prolog()

    def __init__(self):
        self.prolog.consult('knowledge_base/engine.pl')

    async def parse(self, message_object, client) -> (bool, str):
        message = message_object.content
        response = ""
        if message.startswith('+przepis'):
            response = self.add_recipe(message[len('+przepis'):])
        elif message.startswith('+'):
            response = self.add_ingredient(message[len('+'):])
        elif message == 'czysc':
            response = self.clear_ingredients()
        elif message == 'owoce':
            response = self.owoce()
        elif message == '?przepisy':
            response = self.get_recipes()
        elif message == '?s':
            response = self.get_ingredients()
        return True if response != "" else False, response

    def add_recipe(self, message):
        dish_name, products = message.split(':', 1)
        dish_name = dish_name.strip().lower()
        products = self.parse_products(products)
        if list(self.prolog.query(f'custom_recipe("{dish_name}", {products})')):
            return "Składnik został już dodany"
        self.prolog.assertz(f'custom_recipe("{dish_name}", {products})')
        return f"(Może) dodano przepis {dish_name}: {products}"

    def add_ingredient(self, message):
        ingredient = message.strip().lower()
        if list(self.prolog.query(f'ingredients("{ingredient}")')):
            return "Składnik został już dodany"
        self.prolog.assertz(f'ingredients("{ingredient}")')
        return f"(Może) dodano składnik {ingredient}"

    def clear_ingredients(self):
        self.prolog.retractall(f'ingredients(_)')
        return f"Wyczyszczono listę składników"

    
    def owoce(self):
        fruits_count = list(self.prolog.query(f'fruits_count(X)'))[0]['X']
        return str(fruits_count)

    def get_recipes(self):
        recipes = [output['X'] for output in self.prolog.query(f'get_recipes(X)')]
        recipes = [recipe if isinstance(recipe, str) else recipe.decode("utf-8") for recipe in recipes]
        if recipes is None or len(recipes) == 0:
            return "Co Pan zrobisz? Nic Pan z tego nie zrobisz"
        return "Dostępne przepisy:" + "".join([f'\n\t- {recipe}' for recipe in recipes])

    def get_ingredients(self):
        ingredients = [output['X'] for output in self.prolog.query(f'ingredients(X)')]
        ingredients = [ingredient if isinstance(ingredient, str) else ingredient.decode("utf-8") for ingredient in ingredients]
        if ingredients is None or len(ingredients) == 0:
            return "Brak składników"
        return "Składniki:" + "".join([f'\n\t- {ingredient}' for ingredient in ingredients])

    def list_recipes(self):
        recipes = [output['X'] for output in self.prolog.query(f'get_all_recipes(X)')]
        recipes = [recipe if isinstance(recipe, str) else recipe.decode("utf-8") for recipe in recipes]
        return "Lista wszystkich przepisów:" + "".join([f'\n\t- {recipe}' for recipe in recipes])

    def parse_products(self, products):
        products = [product.strip().lower() for product in re.split(r"\s*[,.]+\s*", products)]
        products = [f'"{product}"' for product in products]
        products = "[" + ', '.join(products) + "]"
        return products