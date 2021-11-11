from pyswip import Prolog


class MessageProcessor:
    prolog = Prolog()

    def __init__(self):
        self.prolog.consult('knowledge_base/engine.pl')

    async def parse(self, message_object, client) -> (bool, str):
        output = ""
        for response in self.prolog.query("set_response(Response)"):
            output = output + str(response['Response'])
        return True, output
