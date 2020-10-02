@queries
Feature: Queries

  @by_repo
  Scenario: Searching a repository
    When I execute the API request to search for the repository "behave" owned by "behave"
    Then The response code is "200"
    And The field "total_count" is equal to "1"

  @by_keyword
  Scenario Outline: Searching a repository by a keyword in its name, description or content of its README file
    When I execute the API request to search for all repositories that contain the keyword "<KEYWORD>" in its "<LOCATION>"
    Then The response code is "200"
    And The field "total_count" is equal or greater than "0"

    Examples:
    | KEYWORD | LOCATION           |
    | tetris  | name               |
    | python  | description,readme |


