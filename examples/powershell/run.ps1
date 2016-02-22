
Import-Module $PSScriptRoot\..\..\powershell\bitbucket_rest_api.psm1 -Force

$values = GetListOfCommits "user@onbitbucket.com" "strongpassword" "meyteam" "uirepo" -branchOrTag "master" -exclude "tag.2016.02.11.0"


ForEach ($value in $values) {
    Write-Host $value.message
}