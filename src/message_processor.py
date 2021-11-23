from pyswip import Prolog
import re

class MessageProcessor:
    prolog = Prolog()

    def __init__(self):
        self.prolog.consult('knowledge_base/engine.pl')

    async def parse(self, message_object, client) -> (bool, str):
        products = self.parse_products(message_object.content)
        recipes = self.get_recipes(products)
        response = self.prepare_response(recipes)
        return True, response

    def parse_products(self, message):
        products = message.split(':')[1]
        products = [product.strip().lower() for product in re.split(r"\s*[,.]+\s*", products)]
        return products

    def get_recipes(self, products):
        products = [f'"{product}"' for product in products]
        products = "[" + ', '.join(products) + "]"
        return [output['X'].decode("utf-8") for output in self.prolog.query(f'get_recipes(X, {products})')]

    def prepare_response(self, recipes):
        if recipes is None or len(recipes) == 0:
            return "Co Pan zrobisz? Nic Pan z tego nie zrobisz"
        return "Dostępne przepisy:" + "".join([f'\n\t- {recipe}' for recipe in recipes])
