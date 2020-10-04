@sort_and_order
Feature: Sort and order the results of a search query

  @sort_only
  Scenario: Searching repositories using multiple options and soring the results
    When I execute the API request to search for repositories, sorted by "stars", using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"
    And In the response the list of repositories is ordered by the key "stargazers_count" in descending order

  @order_only
  Scenario: Searching repositories using multiple options and specifying an order
    When I execute the API request to search for repositories, ordered in ascending manner, using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"


  @sort_order
  Scenario: Searching repositories using multiple options and soring the results specifying the order
    When I execute the API request to search for repositories, sorted by "stars" ordered in ascending manner, using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"
    And In the response the list of repositories is ordered by the key "stargazers_count" in ascending order
