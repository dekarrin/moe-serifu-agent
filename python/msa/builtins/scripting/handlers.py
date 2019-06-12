import asyncio
import aiocron

from msa.core.event_handler import EventHandler
from msa.core import supervisor
from msa.builtins.scripting import events
from msa.builtins.scripting.entities import ScriptEntity
from msa.api import MsaLocalApiWrapper


class ScriptManager:
    def __init__(self, loop):
        self.loop = loop
        self.running_scripts = {}

        self.local_api = MsaLocalApiWrapper().get_api()

        self.globals = {
            "msa_api":  self.api
        }

    def run_script(self, script_contents):
        exec(script_contents.strip(), self.globals, {})

    def schedule_script(self, name, crontab, script_content):
        if name not in self.running_scripts:
            self.running_scripts[name] = self.loop.create_task()
        

class AddScriptHandler(EventHandler):
    """
    Handles AddScript Events
    """

    def __init__(self, loop, event_bus, database, logger, config=None):
        super().__init__(loop, event_bus, database, logger, config)


    async def handle(self):

        with self.event_bus.subscribe([events.AddScriptEvent]) as queue:

            _, event = await queue.get()

            if isinstance(event, events.AddScriptEvent):


                with self.database.connect() as conn:
                    result = await conn.execute(ScriptEntity.filter(ScriptEntity.name == event.data["name"]).count())

                    if result == 0:
                        insert_new_script = ScriptEntity.insert().values(
                            name=event.data["name"],
                            crontab=event.data["crontab"],
                            script_contents=event.data["script_contents"]
                        )
                        await conn.execute(insert_new_script)

                        self.loop.create_task()
                    else:
                        new_event = events.AddScriptFailedEvent()
                        new_event.init({
                                "error": f"Failed to add script {event.data['name']}." ,
                                "description": "A script with this name already exists.",
                                "description_verbose": "A script with this name already exists.Delete the script with this name then try again",
                        })
                        await supervisor.fire_event(
                            new_event
                        )
                

class TriggerScriptRunHandler(EventHandler):
    """
    Handles TriggerScriptRun Events
    """
    def __init__(self, loop, event_bus, database, logger, config=None):
        super().__init__(loop, event_bus, database, logger, config)

        self.started = False

    async def async_init(self):
        # load all scripts and crontabs
        with self.database.connect() as conn:
            result = await conn.execute(ScriptEntity.select())

        self.started = True

    async def handle(self):
        if not self.started:
            await self.async_init()

        with self.event_bus.subscribe([events.TriggerScriptRunEvent]):
            pass

    
