using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

Write-Output "started"

# Approach 1 - run Start-Process (without a -Wait)
Start-Process PowerShell.exe '.\Child.ps1'

# Approach 2 - run Start-Process with a -Wait
Start-Process PowerShell.exe '.\Child.ps1' -Wait

# Approach 3 - use ThreadJobs
$job = Start-ThreadJob { Invoke-RestMethod -Uri https://d866afe98744d907f482c50478360b13.m.pipedream.net/Job }
$job | Wait-Job

Write-Output "completed main"

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name. This HTTP triggered function executed successfully."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
