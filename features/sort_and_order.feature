@sort @order
Feature: Sort and order the results of a serch query

  @sort_only
  Scenario: Searching repositories using multiple options
    When I execute the API request to search for repositories, sorted by "stars", using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @order_only
  Scenario: Searching repositories using multiple options
    When I execute the API request to search for repositories, ordered in ascending manner, using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @sort_and_order
  Scenario: Searching repositories using multiple options
    When I execute the API request to search for repositories, sorted by "followers" ordered in descending manner, using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"
