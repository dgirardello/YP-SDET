from time import sleep
from features.steps.constants import set_auth_token, HEADERS


def before_all(context):
    if 'auth_token' in context.config.userdata:
        set_auth_token(context.config.userdata['auth_token'])


def before_scenario(context, scenario):
    # The limit of requests for unauthorized searches is 5/min
    if 'Authorization' not in HEADERS:
        sleep(20)

