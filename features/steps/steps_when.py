from features.steps.utils_request import query_builder, execute_request
from features.steps.constants import VALID_LOCATIONS
from features.steps.utils import get_comparator, table_to_query_args, get_order
from behave import when
import re


@when('I execute the API request to search for the repository "{repo}" owned by "{owner}"')
def step_impl(context, repo, owner):
    query = query_builder(repo="{}/{}".format(owner, repo))
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories that contain the keyword "{key}" in its "{location}"')
def step_impl(context, key, location):
    locations = set(map(lambda x: str(x).lower(), re.split('[^a-zA-Z]', location)))
    query = query_builder(keyword=key, q_in=list(locations.intersection(VALID_LOCATIONS)))
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories from the user "{user}"')
def step_impl(context, user):
    query = query_builder(user=user)
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories from the organization "{organization}"')
def step_impl(context, organization):
    query = query_builder(org=organization)
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories "{comparator}" "{size:d}" kilobytes')
def step_impl(context, comparator, size):
    query = query_builder(size=[get_comparator(comparator), size])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories between "{size1}" and "{size2}" kilobytes')
def step_impl(context, size1, size2):
    query = query_builder(size=[size1, '..', size2])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with "{comparator}" "{cnt}" followers')
def step_impl(context, comparator, cnt):
    query = query_builder(followers=[get_comparator(comparator), cnt])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with between "{cnt1}" and "{cnt2}" followers')
def step_impl(context, cnt1, cnt2):
    query = query_builder(followers=[cnt1, '..', cnt2])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with "{comparator}" "{cnt}" forks')
def step_impl(context, comparator, cnt):
    query = query_builder(forks=[get_comparator(comparator), cnt])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with between "{cnt1}" and "{cnt2}" forks')
def step_impl(context, cnt1, cnt2):
    query = query_builder(forks=[cnt1, '..', cnt2])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with "{comparator}" "{cnt}" stars')
def step_impl(context, comparator, cnt):
    query = query_builder(stars=[get_comparator(comparator), cnt])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with between "{cnt1}" and "{cnt2}" stars')
def step_impl(context, cnt1, cnt2):
    query = query_builder(stars=[cnt1, '..', cnt2])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories {selector} "{comparator}" "{date}"')
def step_impl(context, selector, comparator, date):
    if selector in ['created']:
        query = query_builder(created=[get_comparator(comparator), date])
    elif selector in ['pushed']:
        query = query_builder(pushed=[get_comparator(comparator), date])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories {selector} between "{date1}" and "{date2}"')
def step_impl(context, selector, date1, date2):
    if selector in ['created']:
        query = query_builder(created=[date1, '..', date2])
    elif selector in ['pushed']:
        query = query_builder(pushed=[date1, '..', date2])
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories written in "{language}"')
def step_impl(context, language):
    query = query_builder(language=str(language).upper())
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with the topic in "{topic}"')
def step_impl(context, topic):
    query = query_builder(topic=topic)
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories with the licence keyword "{licence_key}"')
def step_impl(context, licence_key):
    query = query_builder(licence=licence_key)
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories that are "{public_status}"')
def step_impl(context, public_status):
    query = query_builder(q_is=str(public_status).lower())
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories that {evaluator} a mirror')
def step_impl(context, evaluator):
    if evaluator == 'is':
        is_mirror = 'True'
    else:
        is_mirror = 'False'
    query = query_builder(mirror=is_mirror)
    context.request_response = execute_request(query)


@when('I execute the API request to search for all repositories that {evaluator} archived')
def step_impl(context, evaluator):
    if evaluator == 'is':
        is_archived = 'true'
    else:
        is_archived = 'false'
    query = query_builder(archived=is_archived)
    context.request_response = execute_request(query)


@when('I execute the API request to search for repositories using the query parameters')
def step_impl(context):
    query_args = table_to_query_args(context.table)
    query = query_builder(**query_args)
    context.request_response = execute_request(query)


@when('I execute the API request to search for repositories, sorted by "{sort}", using the query parameters')
def step_impl(context, sort):
    query_args = table_to_query_args(context.table)
    query = query_builder(**query_args)
    context.request_response = execute_request(query, sort=sort)


@when('I execute the API request to search for repositories, ordered in {order} manner, using the query parameters')
def step_impl(context, order):
    query_args = table_to_query_args(context.table)
    query = query_builder(**query_args)
    context.request_response = execute_request(query, order=get_order(order))


@when(
    'I execute the API request to search for repositories, sorted by "{sort}" ordered in {order} manner, using the query parameters')
def step_impl(context, sort, order):
    query_args = table_to_query_args(context.table)
    query = query_builder(**query_args)
    context.request_response = execute_request(query, sort=sort, order=get_order(order))


@when('I execute the API request to search for repositories, sorted by "{sort}" ordered in {order} manner with "{per_page:d}" items per page, using the query parameters')
def step_impl(context, sort, order, per_page):
    query_args = table_to_query_args(context.table)
    query = query_builder(**query_args)
    context.request_response = execute_request(query, sort=sort, order=get_order(order), per_page=per_page)
