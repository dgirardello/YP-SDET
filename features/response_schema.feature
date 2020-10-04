@schema
Feature: Verify the schema of the request response
  # Enter feature description here

  @search_schema @test@
  Scenario: Verify that the search response matches the given schema
    When I execute the API request to search for repositories using the query parameters
          | KEY | VALUE  |
          | org | behave |
    Then The response code is "200"
    And The response header "content-type" is "application/json"
    And The response body matches the schema "search.schema"

