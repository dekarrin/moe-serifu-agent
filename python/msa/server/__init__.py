import asyncio
from msa.data import start_db_engine, stop_db_engine
from msa.server.route_adapter import RouteAdapter
from msa.server.default_routes import register_default_routes

from aiohttp import web

# create global route adapter
route_adapter = RouteAdapter()
register_default_routes(route_adapter)


async def start_supervisor(app):
    app["supervisor"].start()

async def stop_supervisor(app):
    app["supervisor"].logger.info("*** trigger shutdown")
    await app["supervisor"].exit()


def start_server(config_context):
    app = web.Application()

    app["config_context"] = config_context

    # get loop and db
    loop = asyncio.get_event_loop()

    # init supervisor
    from msa import core as msa_core
    from msa.core.supervisor import Supervisor
    supervisor =  Supervisor()
    msa_core.supervisor = supervisor
    app["supervisor"] = supervisor
    supervisor.init(loop, app["config_context"], route_adapter)
    loop.run_until_complete(start_db_engine())

    app.add_routes(route_adapter.get_route_table())
    app.on_startup.append(start_supervisor)

    app.on_cleanup.append(stop_supervisor)
    app.on_cleanup.append(stop_db_engine)
    web.run_app(app)
