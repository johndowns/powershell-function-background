# Run PowerShell Azure Functions app with background jobs

This repository demonstrates some approaches to running background jobs within Azure Functions. Please see `run.ps1`.

The approaches listed include:

1. **Run `Start-Process` (without a `-Wait` flag).** This will start a new background process asynchronously, and won't wait for it to complete. The standard out/error streams will not be accessible and any errors won't be observable. Additionally, this is not a good practice since the function will return without the work actually having completed.

2. **Run `Start-Process` (with a `-Wait` flag).** This will start a new background process and then wait for it to complete before continuing. The standard out/error streams are still not accessible, but this will block the function from returning until the child process terminates.

3. **Use ThreadJobs.** This approach initiates a new ThreadJob (background job). Multiple ThreadJobs could be initiated to run in parallel and then waited on.

There are alternative approaches too, including using durable functions.
