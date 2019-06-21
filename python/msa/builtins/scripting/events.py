import croniter
from schema import Schema, And, Or

from msa.core.event import Event


class AddScriptEvent(Event):
    """
    AddScriptEvent schema:
    - name: The name of the script, must not include any whitespace.
    - chrontab: The chrontab interval this script should run on. Refer to https://en.wikipedia.org/wiki/Cron for 
        details on syntax.
    - scripts_contents: The contents of the script to be submitted.
    """

    def __init__(self):
        super().__init__(
            priority=100,
            schema=Schema({
                "name": And(
                    str,
                    len,
                    lambda s: (sum(c.isspace() for c in s) == 0)),
                "chrontab": And(str, len, croniter.is_valid),
                "script_contents": And(str, len)
            })
        )

class AddScriptFailedEvent(Event):
    """
    AddScriptFailedEvent schema:
    - error: A friendly title for the  error, should be humanly readable
    - description_verbose: A verbose explanation of what went wrong. May include stack traces, and is 
        intended to be displayed as raw text.
    - description: A humanly readable explanation for the error. May not include stack traces,
        and should be simple enough to use with a Text-to-Speech service.
    """
    def __init__(self):
        super().__init__(
            priority=20,
            schema=Schema({
                "error": And(str, len),
                "description": And(str, len),
                "description_verbose": And(str, len),
            })
        )

class TriggerScriptRunEvent(Event):
    """
    TriggerScriptRunEvent schema:
    - name: The name of the script that should be run
    """

    def __init__(self):
        super().__init__(
            priority=50,
            schema=Schema({
                "name": And(str, len),
            })
        )

class RunScriptResultEvent(Event):
    """
    RunScriptResultEvent schema:
    - name: The name of the script that was run
    - error: A string describing any errors, can be None or a non-empty string.
    - log: A string containing any log messages produced by the script.
    """

    def __init__(self):
        super().__init__(
            priority=50,
            schema=Schema({
                "name": And(str, len),
                "error": Or(None, And(str, len)),
                "log": And(str)
            })
        )
