# Azure Check

Simple script to check azure access with `AZURE_CLIENT_ID` and `AZURE_CLIENT_SECRET`.

Success looks like this:

    $ bundle exec ruby azure_check.rb
    Successfully connected to Azure with your AZURE_CLIENT_ID and AZURE_CLIENT_SECRET
    $

Failure looks like this:

    $ ruby azure_check.rb
    Failed to connected to Azure with your AZURE_CLIENT_ID and AZURE_CLIENT_SECRET
    {
      "message": "Couldn't login to Azure, please verify your tenant id, client id and client secret",
      "request": null,
      "response": null
    }