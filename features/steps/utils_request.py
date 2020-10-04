import requests
import re
from features.steps.constants import ENDPOINT, HEADERS

QUERY_QUALIFIERS = ['size', 'followers', 'forks', 'stars', 'topics', 'good-first-issues', 'help-wanted-issues']
QUERY_KEY_VALUE  = ['repo', 'user', 'org', 'language', 'topic', 'licence', 'mirror', 'archived']
QUERY_DATE       = ['created', 'pushed']


def query_builder(**kwargs):
    query_string = ""
    for key, value in kwargs.items():
        q_str = ''
        if key == 'keyword':
            q_str = '{} '.format(value)
        elif key == 'q_in':
            q_str = "in:{}".format(','.join(value))
        elif key == 'q_is':
            q_str = "is:{}".format(value)
        elif key in QUERY_KEY_VALUE:
            q_str = "{}:{}".format(key, value)
        elif key in QUERY_QUALIFIERS:
            q_str = "{}:{}".format(key, ''.join(map(str, value)))
        elif key in QUERY_DATE:
            q_str = "{}:{}".format(key, ''.join(map(str, value)))

        if len(query_string) > 0 and re.search(':', query_string):
            query_string += '+'
        query_string = query_string + q_str if re.search(':', q_str) else q_str + query_string

    return query_string.strip()


def execute_request(query, **kwargs):
    params = "q=%s" % query
    if 'sort' in kwargs:
        params += "&sort=%s" % kwargs['sort']
    if 'order' in kwargs:
        params += "&order=%s" % kwargs['order']
    if 'per_page' in kwargs:
        params += "&per_page=%s" % kwargs['per_page']
    if 'page' in kwargs:
        params += "&page=%s" % kwargs['page']

    return requests.get(ENDPOINT, params=params, headers=HEADERS, verify=False)
