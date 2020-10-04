@errors
Feature: Error cases
  # Enter feature description here

  @invalid_type
  Scenario Outline: Invalid data type
    When I execute the API request to search for repositories using the query parameters
          | KEY             | VALUE      |
          | <PARAMETER_KEY> | <PARAMETER_VALUE> |
    Then The response code is "422"

    Examples:
    | PARAMETER_KEY | PARAMETER_VALUE |
    | created       | NOT-A-DATE      |
    | stars         | NOT-A-NUMBER    |
