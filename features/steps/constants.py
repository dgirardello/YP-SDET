ENDPOINT = 'https://api.github.com/search/repositories'
VALID_LOCATIONS = ('name', 'description', 'readme')
AUTH_TOKEN = None
HEADERS = {}



def set_auth_token(token):
    if token is not None and len(token) >= 1:
        HEADERS.update({'Authorization': 'token {}'.format(token)})
