Write-Output 'Child script' # This output won't appear in the Azure Functions response stream because it's in a different process
Start-Sleep 10
Invoke-RestMethod -Uri https://d866afe98744d907f482c50478360b13.m.pipedream.net
