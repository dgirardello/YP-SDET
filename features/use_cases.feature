@use_case
Feature: Use Cases for searching repositories

  @UC_001
  Scenario: Fetch all the repositories for a specific organization
    When I execute the API request to search for repositories using the query parameters
          | KEY | VALUE  |
          | org | behave |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "4"
    And In the response the list of repositories contains an item with the key "name" is equal to "behave"

  @UC_002
  Scenario: Fetch all the repositories created on a date filtering by more than one language
    When I execute the API request to search for repositories using the query parameters
          | KEY      | VALUE      |
          | created  | 2020-07-29 |
          | language | python     |
          | language | javascript |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "1"
    And In the response the all the elements in the list of repositories the key "created_at" is equal to "2020-07-29"
    And In the response the all the elements in the list of repositories the key "language" is equal to any of
        | LANGUAGE   |
        | python     |
        | javascript |

  @UC_003
  Scenario: Fetch the top ten followed repositories written in python
    When I execute the API request to search for repositories, sorted by "stars" ordered in descending manner with "10" items per page, using the query parameters
          | KEY      | VALUE  |
          | language | python |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "10"
    And In the response the list of repositories contains "10" elements
    And In the response the list of repositories is ordered by the key "stargazers_count"

  @UC_004
  Scenario: Fetch the top ten last updated repositories written in Java, Python or JavaScript
    When I execute the API request to search for repositories, sorted by "updated" ordered in ascending manner with "10" items per page, using the query parameters
          | KEY      | VALUE      |
          | language | java       |
          | language | python     |
          | language | javascript |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "10"
    And In the response the list of repositories contains "10" elements
    And In the response the list of repositories is ordered by the key "updated_at" in ascending order

  @UC_005
  Scenario: Fetch all the public repositories written in Java that are archived
    When I execute the API request to search for repositories using the query parameters
          | KEY      | VALUE      |
          | language | java       |
          | public   | true       |
          | archived | true       |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "1"
