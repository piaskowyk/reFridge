import discord
from src.message_processor import MessageProcessor
from src.utils.utils import send_long_message


class ReFridgeBotClient(discord.Client):
    message_processor: MessageProcessor = None
    services: list = []
    is_ready: bool = False

    async def on_ready(self):
        print(f'{self.user} Ultimate discord BOT connected!')
        self.message_processor = MessageProcessor()
        self.is_ready = True

    async def on_message(self, message):
        if not self.is_ready:
            return
        if message.author == self.user:
            return
        is_response, response_message = await self.message_processor.parse(message, self)
        if is_response:
            await send_long_message(message.channel, response_message)
