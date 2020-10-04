# YP-SDET

##Requirements
- Python3
- Pip3
- Virtualenv

## Installation
1. Download the repository
2. Create a virtual environment
   ```commandline
   python3 -m venv ./venv2
   ```
3. Activate the virtual environment
   ```commandline
   source venv/bin/activate
   ```
4. Install the required libraries
   ```commandline
   pip3 install -r requirements.txt
   ```
## Running tests

To run the tests simply execute 
```commandline
behave features/
```
This will execute the test scenarios and at the end of the test run summary will be shown    
```commandline
3 features passed, 0 failed, 0 skipped
59 scenarios passed, 0 failed, 0 skipped
182 steps passed, 0 failed, 0 skipped, 0 undefined
Took 2m20.914s
```
To run a single feature just instruct behave to use a single feature file 
```commandline
behave features/use_cases.feature
```
Or use the available feature tag
```commandline
behave features/ -t @use_case 
```
One or more scenarios also can be executes the available tags
```commandline
behave features/ -t @UC_001 
```
Will run the scenarui tagged *UC_001*
You can use the tags option to execute one or more scenarios
```commandline
behave features/ -t "@UC_001 or @UC_003" 
```
Or to exclude scenarios from a test run
```commandline
behave features/use_cases.feature -t "@UC_001 or @UC_003 and not @UC_002" 
```

For more information on running behave please refeer to https://behave.readthedocs.io/en/latest/behave.html#command-line-arguments

## Output
Several output options are available using the **-f** option 
I.E.: If you don't wish to see all the test execution you can use the *progress* formatter
```commandline
behave features/ -f progress 
```
This will print a dot for every scenario executed (or an F if the scenario has failed) and print the execution summary, like this
```commandline
features/errors.feature  ..
features/pagination.feature  ....
features/queries.feature  .....................................................
features/sort_and_order.feature  ...
features/use_cases.feature  .....
5 features passed, 0 failed, 0 skipped
67 scenarios passed, 0 failed, 0 skipped
212 steps passed, 0 failed, 0 skipped, 0 undefined
Took 2m32.298s
```
To which output format are available execute
```commandline
behave -f help 
```

### OAUTH Autentication
Due to restictions in the GitHub Search API that only allows 5 request/minute on unautenticated users, a simple wait method has been implemeted to avoid exceding the limit.

To avoid the wait period between scenarios an OAuth token must be provided, this can be achieved by passing the **auth_token** variable in the excecution 
```commandline
behave -D auth_token=<OAuth access token> features/ 
``` 
Or write the OAuth token in the behave.ini file
```ini
[behave.userdata]
auth_token=<OAuth access token>
```
For instructions on how to create an OAuth Personal access token on GitHub check https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token
*Note:* Personal access tokens expire after some time, please be sure you have a valid token. Is the tests fail with a **201** response code that is indicative that the token is invalid 

## Features
| Feature File | Tag | Description |
|--------------|-----|-------------|
| use_cases.feature | @use_case | A set of scenarios designed to test common use cases |
| queries.feature | @queries | A set of test scenario to verify the query string building capabilities |
| sort_and_order.feature | @sort_and_order | A set of test scenario to verify the sort and order of the search results |
| pagination.feature | @pagination | A set of test scenarios to verify the ability to limit the search results items returned | 
| errors.feature | @errors | A set of test scenarios to verify the error returned by the search api |
| schema.feature | @schema | A test to validate the schema of the json response |
