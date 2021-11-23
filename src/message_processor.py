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
        elif message == 'lista':
            response = self.list_recipes()
        elif message.startswith('?przepis'):
            response = self.get_recipes(message[len('?przepis'):])
        return True if response != "" else False, response

    def add_recipe(self, message):
        dish_name, products = message.split(':', 1)
        dish_name = dish_name.strip().lower()
        products = self.parse_products(products)
        self.prolog.assertz(f'custom_recipe("{dish_name}", {products})')
        return f"(Może) dodano przepis {dish_name}: {products}"

    def get_recipes(self, message):
        products = self.parse_products(message)
        recipes = [output['X'] for output in self.prolog.query(f'get_recipes(X, {products})')]
        recipes = [recipe if isinstance(recipe, str) else recipe.decode("utf-8") for recipe in recipes]
        if recipes is None or len(recipes) == 0:
            return "Co Pan zrobisz? Nic Pan z tego nie zrobisz"
        return "Dostępne przepisy:" + "".join([f'\n\t- {recipe}' for recipe in recipes])

    def list_recipes(self):
        recipes = [output['X'] for output in self.prolog.query(f'get_recipes(X, Y)')]
        recipes = [recipe if isinstance(recipe, str) else recipe.decode("utf-8") for recipe in recipes]
        return "Lista wszystkich przepisów:" + "".join([f'\n\t- {recipe}' for recipe in recipes])

    def parse_products(self, products):
        products = [product.strip().lower() for product in re.split(r"\s*[,.]+\s*", products)]
        products = [f'"{product}"' for product in products]
        products = "[" + ', '.join(products) + "]"
        return products