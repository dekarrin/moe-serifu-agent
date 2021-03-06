import asyncio
from unittest import mock


def async_run(loop, coro):
    return loop.run_until_complete(coro)


def AsyncMock(*args, **kwargs):
    m = mock.MagicMock(*args, **kwargs)

    async def mock_coro(*args, **kwargs):
        return m(*args, **kwargs)

    mock_coro.mock = m
    return mock_coro
