@pagination
Feature: Paginate and limit the items shown in the response

  @per_page
  Scenario Outline: Searching repositories using multiple options and limiting the results shown to a number of items
    When I execute the API request to search for repositories, sorted by "updated" ordered in descending manner with "<ITEMS>" items per page, using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"
    And In the response the list of repositories contains "<ITEMS>" elements

    Examples:
    | ITEMS |
    | 5     |
    | 10    |
    | 25    |
    | 99    |
