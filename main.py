from dotenv import load_dotenv
load_dotenv()
import os
from src.client import ReFridgeBotClient

TOKEN = os.getenv('PRIVATE_KEY', None)

if not TOKEN:
    print('Missing discord token')
    exit(1)

client = ReFridgeBotClient()
client.run(TOKEN)
