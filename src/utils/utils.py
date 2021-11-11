async def send_long_message(channel, message):
    length_limit = 2000

    if len(message) < length_limit:
        await channel.send(message)
        return

    short_message = ""
    for line in message.split('\n'):
        if len(short_message) + len(line) + 1 < length_limit:
            short_message += '\n' + line
        elif len(short_message) > 0:
            await channel.send(short_message)
            short_message = ""
        else:
            very_long_line = line
            while len(very_long_line) > 2000:
                to_send = very_long_line[:2000]
                very_long_line = very_long_line[2000:]
                await channel.send(to_send)
            await channel.send(very_long_line)
    if len(short_message) > 0:
        await channel.send(short_message)
