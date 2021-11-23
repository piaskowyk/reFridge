from pyswip import Prolog


class MessageProcessor:
    prolog = Prolog()

    def __init__(self):
        self.prolog.consult('knowledge_base/engine.pl')

    async def parse(self, message_object, client) -> (bool, str):
        # TODO ten kod jest chujowy jak cos
        output = ""
        query = '[' + message_object.content.split('[')[1]
        for response in self.prolog.query(f'get_recipes(X, {query})'):
            output = output + response['X'].decode("utf-8") + "\n"
        if output == "":
            output = "gówno"
        return True, output
