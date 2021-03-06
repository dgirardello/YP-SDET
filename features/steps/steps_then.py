from behave import then
from hamcrest import *
from features.steps.utils import get_order
from jsonschema import validate
import os, json

@then('The response code is "{ret_code:d}"')
def step_impl(context, ret_code):
    if context.request_response.status_code != 200:
        print(context.request_response.json())
    assert_that(context.request_response.status_code, equal_to(ret_code))


@then('In the response the field "{json_field}" is equal to "{cnt:d}"')
def step_impl(context, json_field, cnt):
    json_response = context.request_response.json()
    assert_that(json_response[json_field], equal_to(cnt))


@then('In the response the field "{json_field}" is equal or greater than "{cnt:d}"')
def step_impl(context, json_field, cnt):
    json_response = context.request_response.json()
    assert_that(json_response[json_field], greater_than_or_equal_to(cnt))


@then('In the response the list of repositories contains an item with the key "{json_field}" is equal to "{value}"')
def step_impl(context, json_field, value):
    json_response = context.request_response.json()
    assert_that(json_response['items'], has_item(has_entry(json_field, value)))


@then('In the response the all the elements in the list of repositories the key "{json_field}" is equal to "{value}"')
def step_impl(context, json_field, value):
    json_response = context.request_response.json()
    for item in json_response['items']:
        assert_that(item, has_entry(json_field, contains_string(value)))


@then('In the response the all the elements in the list of repositories the key "{json_field}" is equal to any of')
def step_impl(context, json_field):
    json_response = context.request_response.json()
    value_matchers = [str(row[0]).lower() for row in context.table]

    for item in json_response['items']:
        assert_that(str(item[json_field]).lower(), is_in(value_matchers))


@then('In the response the list of repositories contains "{cnt:d}" elements')
def step_impl(context, cnt):
    json_response = context.request_response.json()
    assert_that(len(json_response['items']), equal_to(cnt))


@then('In the response the list of repositories is ordered by the key "{json_field}"')
def step_impl(context, json_field):
    json_response = context.request_response.json()
    last_value = json_response['items'][0][json_field]
    for item in json_response['items']:
        assert_that(item[json_field], less_than_or_equal_to(last_value))
        last_value = item[json_field]


@then('In the response the list of repositories is ordered by the key "{json_field}" in {order} order')
def step_impl(context, json_field, order):
    json_response = context.request_response.json()
    last_value = json_response['items'][0][json_field]
    desc_order = (get_order(order) == 'desc')
    for i in range(1, len(json_response['items'])):
        if desc_order:
            assert_that(json_response['items'][i][json_field], less_than_or_equal_to(last_value))
        else:
            assert_that(json_response['items'][i][json_field], greater_than_or_equal_to(last_value))
        last_value = json_response['items'][i][json_field]


@then('The response header "{key}" is "{value}"')
def step_impl(context, key, value):
    assert_that(context.request_response.headers[key], contains_string(value))


@then('The response body matches the schema "{schema_file}"')
def step_impl(context, schema_file):
    file_path = os.path.dirname(os.path.realpath(__file__))
    f = open(os.path.join(file_path, schema_file), 'r')
    schema = json.load(f)
    validate(context.request_response.json(), schema=schema)
