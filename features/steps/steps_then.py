from behave import then
from hamcrest import *


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
