@queries
Feature: Queries

  @by_repo
  Scenario: Searching a repository
    When I execute the API request to search for the repository "behave" owned by "behave"
    Then The response code is "200"
    And In the response the field "total_count" is equal to "1"

  @by_keyword
  Scenario Outline: Searching a repositories by a keyword in its name, description or content of its README file
    When I execute the API request to search for all repositories that contain the keyword "<KEYWORD>" in its "<LOCATION>"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | KEYWORD | LOCATION           |
    | tetris  | name               |
    | python  | description,readme |


  @by_user
  Scenario: Searching for repositories of the user
    When I execute the API request to search for all repositories from the user "behave"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "4"

  @by_org
  Scenario: Searching for repositories of the organization
    When I execute the API request to search for all repositories from the organization "behave"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "4"

  @by_size
  Scenario Outline: Searching a repositories that match a certain size (in Kb)
    When I execute the API request to search for all repositories "<COMPARATOR>" "<SIZE>" kilobytes
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR            | SIZE |
    | exactly               | 1000 |
    | less than             | 5000 |
    | greater than          | 100  |
    | less or equal than    | 1500 |
    | greater or equal than | 150  |

  @by_size
  Scenario: Searching a repositories that match a certain size (in Kb)
    When I execute the API request to search for all repositories between "123" and "1234" kilobytes
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_followers
  Scenario Outline: Searching a repositories based on the number of followers
    When I execute the API request to search for all repositories with "<COMPARATOR>" "<FOLLOWERS>" followers
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR         | FOLLOWERS |
    | exactly            | 100       |
    | less than          | 500       |
    | more than          | 10        |
    | less or equal than | 150       |
    | more or equal than | 15        |

  @by_followers
  Scenario: Searching a repositories based on the number of followers
    When I execute the API request to search for all repositories with between "12" and "123" followers
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_forks
  Scenario Outline: Searching a repositories based on the number of forks
    When I execute the API request to search for all repositories with "<COMPARATOR>" "<FORKS>" forks
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR         | FORKS |
    | exactly            | 100   |
    | less than          | 500   |
    | more than          | 10    |
    | less or equal than | 150   |
    | more or equal than | 15    |

  @by_forks
  Scenario: Searching a repositories based on the number of forks
    When I execute the API request to search for all repositories with between "12" and "123" forks
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_stars
  Scenario Outline: Searching a repositories based on the number of stars
    When I execute the API request to search for all repositories with "<COMPARATOR>" "<STARS>" stars
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR         | STARS |
    | exactly            | 100   |
    | less than          | 500   |
    | more than          | 10    |
    | less or equal than | 150   |
    | more or equal than | 15    |

  @by_stars
  Scenario: Searching a repositories based on the number of stars
    When I execute the API request to search for all repositories with between "12" and "123" stars
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_creation_date
  Scenario Outline: Searching a repositories based on the creation date
    When I execute the API request to search for all repositories created "<COMPARATOR>" "<DATE>"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR   | DATE       |
    | on           | 2020-08-27 |
    | before       | 2020-08-27 |
    | after        | 2020-08-27 |
    | on or before | 2020-08-27 |
    | on or after  | 2020-08-27 |

  @by_creation_date
  Scenario: Searching a repositories based on the creation date
    When I execute the API request to search for all repositories created between "2020-07-29" and "2020-08-25"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_push_date
  Scenario Outline: Searching a repositories based on the latest push date
    When I execute the API request to search for all repositories pushed "<COMPARATOR>" "<DATE>"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | COMPARATOR   | DATE       |
    | on           | 2020-08-27 |
    | before       | 2020-08-27 |
    | after        | 2020-08-27 |
    | on or before | 2020-08-27 |
    | on or after  | 2020-08-27 |

  @by_push_date
  Scenario: Searching a repositories based on the latest push date
    When I execute the API request to search for all repositories pushed between "2020-07-29" and "2020-08-25"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"


  @by_language
  Scenario Outline: Searching a repositories by the main language
    When I execute the API request to search for all repositories written in "<LANGUAGE>"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

    Examples:
    | LANGUAGE   |
    | python     |
    | javascript |
    | pascal     |


  @by_topic
  Scenario: Searching a repositories that are classified with a topic
    When I execute the API request to search for all repositories with the topic in "jekyll"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_licence
  Scenario: Searching a repositories by a licence keyword
    When I execute the API request to search for all repositories with the licence keyword "python-3.16.0"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_public
  Scenario: Searching repositories based on whether is public or private
    When I execute the API request to search for all repositories that are "public"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_private
  Scenario: Searching repositories based on whether is public or private
    When I execute the API request to search for all repositories that are "private"
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_mirror
  Scenario: Searching repositories based on whether is or is not a mirror
    When I execute the API request to search for all repositories that is a mirror
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_mirror
  Scenario: Searching repositories based on whether is or is not a mirror
    When I execute the API request to search for all repositories that is not a mirror
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"


  @by_archived
  Scenario: Searching repositories based on whether is or is not a archived
    When I execute the API request to search for all repositories that is archived
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"

  @by_archived
  Scenario: Searching repositories based on whether is or is not a archived
    When I execute the API request to search for all repositories that is not archived
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"


  @by_multiple_options
  Scenario: Searching repositories using multiple options
    When I execute the API request to search for repositories using the query parameters
          | KEY      | VALUE            |
          | keyword  | game             |
          | is       | public           |
          | created  | >2000-07-29      |
          | language | python           |
          | stars    | >100             |
    Then The response code is "200"
    And In the response the field "total_count" is equal or greater than "0"
