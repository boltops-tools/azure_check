# Azure Check

Simple script to check azure access with `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET`.

## Usage

Export the `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET` variables.  It's recommended to put it in your `~/.bashrc`

    export ARM_CLIENT_ID=REPLACE_ME
    export ARM_CLIENT_SECRET=REPLACE_ME

Make sure you run `source ~/.bashrc` or open a new terminal. Then run:

    bundle install
    ruby azure_check.rb

## Example

Success looks like this:

    $ ruby azure_check.rb
    Successfully connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET
    $

Failure looks like this:

    $ ruby azure_check.rb
    Failed to connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET
    {
      "message": "Couldn't login to Azure, please verify your tenant id, client id and client secret",
      "request": null,
      "response": null
    }