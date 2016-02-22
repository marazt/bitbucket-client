
#bitbucket-client


Version 1.0.1

Author marazt

Copyright marazt

License The MIT License (MIT)

Last updated 02 February 2016


##About

Bunch of scripts for querying Bitbucket REST API.
* Some people are too lazy to open code repository and check what has been changed with the new release and thay ask other.
* Some people are too lazy to reply them every time or write tham all commit messages.
* That is the reason why decided to write a few script that can solve this problem.
* I want to write scripts in multiple languages to be little bit multiplatform :) - PowerShell, Python, Bash
* *If you want to contribute with other calls and languages, just send pull request, you are welcome*


##Versions

**1.0.1 - 2016/02/21**

* Initial release with first method to get list of commits in particular team/respository/branch



##Example Execution

###### PowerShell

```powershell
    # get list of commit messages from master branch from the top to the previous release
    Import-Module $PSScriptRoot\bitbucket_rest_api.psm1 -Force
    $values = GetListOfCommits "user@onbitbucket.com" "strongpassword" "meyteam" "uirepo" -branchOrTag "master" -exclude "tag.2016.02.11.0"
    ForEach ($value in $values) {
        Write-Host $value.message
    }
```

###### Python

```python
    # get list of commit messages from master branch from the top to the previous release
    from bitbucket_rest_api import BitbucketRestUtils

    bitbucket_utils = BitbucketRestUtils()
    values = bitbucket_utils.get_list_of_commits("user@onbitbucket.com", "strongpassword", "meyteam", "uirepo", branch_or_tag="master", exclude="tag.2016.02.11.0")
    for value in values:
        print value["message"]
```