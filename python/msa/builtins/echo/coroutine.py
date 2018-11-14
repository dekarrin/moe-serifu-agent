import asyncio

from msa import supervisor
from msa.coroutine import Coroutine, reschedule

from msa.builtins.command.event import RegisterCommandEvent, CommandEventFactory
from msa.builtins.echo.event import EchoCommandEvent
from msa.builtins.print.event import PrintTextEvent

class EchoCoroutine(Coroutine):

    def __init__(self):
        super().__init__()

    async def init(self):

        factory = CommandEventFactory(
                EchoCommandEvent,
                invoke="echo",
                describe="Echo provided text back through the terminal",
                usage="$echo [text]")

        register_event = RegisterCommandEvent()
        register_event.init(factory)

        await supervisor.propogate_event(register_event)

    @reschedule
    async def work(self, event_queue):
        event = await event_queue.get()
        event_queue.task_done()

        if not event.propogate:
            await asyncio.sleep(0.01)
            return

        if isinstance(event, EchoCommandEvent):
            await self.echo_command(event)

        await asyncio.sleep(0.1)

    async def echo_command(self, event):
        text = event.data["text"]

        print_event = PrintTextEvent()
        print_event.init(text)
        await supervisor.propogate_event(print_event)