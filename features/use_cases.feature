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

  @UC_003 @test
  Scenario: Fetch the top ten followed repositories written in python
    When I execute the API request to search for repositories, sorted by "stars" ordered in descending manner with "10" items per page, using the query parameters
          | KEY      | VALUE  |
          | language | python |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "10"
    And In the response the list of repositories contains "10" elements
    And In the response the list of repositories is ordered by the key "stargazers_count"
