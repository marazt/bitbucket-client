
Import-Module $PSScriptRoot\common.psm1 -Force

# https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html#commitsorcommitResource-GETacommitslistforarepositoryorcomparecommitsacrossbranches
# https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html


$bitbucketUrl = "https://api.bitbucket.org/2.0"


<#
.SYNOPSIS
Method to get list of commits in particluar team repository.

.DESCRIPTION
Method to get list of commits in particluar team repository.

.PARAMETER username on Bitbucket
User name

.PARAMETER password on Bitbucket
User password

.PARAMETER team
Name of the team on Bitbucket

.PARAMETER repository
Name of the repository on Bitbucket

.PARAMETER branchOrTag
Name of the branch or tag or commit hash, optional

.PARAMETER include
Name of branch or tag to be included, optional

.PARAMETER exclude
Name of branch or tag to be exluded, optional


.EXAMPLE
Get list of all commits in repository 'ui': GetListOfCommitMessages "user@example.org" "12345678" "exampleorg" "ui"
Get list of all commits in repository 'ui' in branch 'master': GetListOfCommitMessages "user@example.org" "12345678" "exampleorg" "ui" "master"
Get list of all commits in repository 'ui' of the last release (between last and previous tag): GetListOfCommitMessages "user@example.org" "12345678" "exampleorg" "ui" "2016.02.18.0" "" "2016.02.18.0"

#>
Function GetListOfCommits ([string] $username, [string] $password, [string] $team, [string]$repository, [string]$branchOrTag = "", [string]$include = "", [string]$exclude = "") {

    $arguments = ""
    $argumentsSet = $false

    # create url argument list
    @{"include"=$include; "exclude"=$exclude}.GetEnumerator() | Foreach-Object {
        if ([string]::IsNullOrEmpty($_.Value) -ne $true) {
           $arguments += (IIf $argumentsSet "&" "") + $_.Name + "=" +$_.Value
           $argumentsSet = $true
        }
    }

    $url = "$bitbucketUrl/repositories/$team/$repository/commits/$branchOrTag" + (IIf $argumentsSet "?$arguments" "")
    $auth = (CreateBasicAuthHeader $username $password)
    $method = "Get"
 
    $data = (CallResource $url $method $auth)
    $result = $data.values
              
    # try to get more data if possible
    while ([bool]($data.PSobject.Properties.name -match "next")) {
            $data = (CallResource $data.next $method $auth)
            $result += $data.values
    }
    
    return $result
}

