require 'aws-sdk'
require 'pry'

AWS.config(:use_ssl => false,
           :dynamo_db_endpoint => '0.0.0.0',
           :dynamo_db_port => 8000,
           :access_key_id => "xxx#{rand}",
           :secret_access_key => "xxx#{rand}")

ddb = AWS::DynamoDB::Client.new(:api_version => '2012-08-10')
ddb.create_table({
  :attribute_definitions => [
    {
      :attribute_name => "id",
      :attribute_type => "S"
    },
    {
      :attribute_name => "range",
      :attribute_type => "S"
    }
  ],
  :table_name => "actions",
  :key_schema => [
    {
      :attribute_name => "id",
      :key_type =>       "HASH"
    },
    {
      :attribute_name => "range",
      :key_type =>       "RANGE"
    }
  ],
  :provisioned_throughput => {
    :read_capacity_units  =>  1,
    :write_capacity_units => 1
  }
})
