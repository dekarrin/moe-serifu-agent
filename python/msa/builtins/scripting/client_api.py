import requests


def register_endpoints(api_binder):

    @api_binder.register_method()
    async def upload_script(self, name, crontab=None, file_name=None, script_contents=None):

        if file_name and script_contents:
            raise Exception("MSA API - upload_script - cannot provide file_name and script_contents")

        if file_name:
            with open(file_name, "rb") as f:
                try:
                    script_contents = f.read().decode("utf-8")
                except:
                    raise Exception("MSA API - upload_script - failed to decode file, expects utf-8 encoding.")

        if crontab is not None:
            payload = {
                "name": name,
                "script_contents": script_contents,
                "crontab": crontab
            }
        else:
            payload = {
                "name": name,
                "script_contents": script_contents,
            }

        response = await self.client.post(
            "/scripting/script",
            payload=payload)

        if response.status_code != 200:
            raise Exception(response.raw)
        print(response.text)

