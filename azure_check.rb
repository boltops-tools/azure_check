require 'azure_info'
require 'azure_mgmt_resources'

class Check
  # Include SDK modules to ease access to Storage classes.
  include Azure::Resources::Profiles::Latest::Mgmt
  include Azure::Resources::Profiles::Latest::Mgmt::Models

  def initialize
    @client_id = ENV['ARM_CLIENT_ID']
    @client_secret = ENV['ARM_CLIENT_SECRET']
    @subscription_id = ENV['ARM_SUBSCRIPTION_ID'] || AzureInfo.subscription_id
    @tenant_id = ENV['ARM_TENANT_ID'] || AzureInfo.tenant_id
  end

  def call
    resource_groups = ResourceGroups.new(client)
    if resource_groups.list.empty?
      puts "No resource groups found, but was able to successfully make the Azure SDK API call."
    else
      puts resource_groups.list.map(&:name)
    end
    puts "Successfully connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET"
  rescue Exception => e
    puts "Failed to connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET"
    puts "#{e.message}: #{e.message}"
    exit 1
  end

  def client
    return @client if @client
    provider = MsRestAzure::ApplicationTokenProvider.new(@tenant_id, @client_id, @client_secret)
    credentials = MsRest::TokenCredentials.new(provider)

    @client = Client.new(
      tenant_id: @tenant_id,
      client_id: @client_id,
      client_secret: @client_secret,
      subscription_id: @subscription_id,
      credentials: credentials
    )
  end
end

if __FILE__ == $0
  Check.new.call
end

# Success looks like this:
#
#     $ bundle exec ruby azure_check.rb
#     Successfully connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET
#     $
#
# Failure looks like this:
#
#     $ ruby azure_check.rb
#     Failed to connected to Azure with your ARM_CLIENT_ID and ARM_CLIENT_SECRET
#     {
#       "message": "Couldn't login to Azure, please verify your tenant id, client id and client secret",
#       "request": null,
#       "response": null
#     }