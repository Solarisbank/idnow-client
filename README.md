# Idnow Client

Library to consume the [IDnow API](http://www.idnow.eu/developers) in Ruby. [![Build Status](https://travis-ci.com/Solarisbank/idnow-client.svg?branch=master)](https://travis-ci.com/Solarisbank/idnow-client)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idnow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idnow

## Configuration

The Idnow client takes three settings:

*  **env**

  - can be set to `:live` or `:test`. Following the IDnow API documentation, each of these environments will correspondingly set the host to:

      -  Live server `gateway.idnow.de`
      -  Test server `gateway.test.idnow.de`

*  **company_id**
*  **api_key**
*  **custom_environments** (optional)

You have the option of using a global singleton client:

```ruby
Idnow.env = :test
Idnow.company_id = "mycompany"
Idnow.api_key = "1234api_key"

# optional
Idnow.custom_environments = {
  test: {
    host:        'https://gateway.test.idnow.example.com',
    target_host: 'https://go.test.idnow.example.com'
  },
  live: {
    host:        'https://gateway.idnow.example.com',
    target_host: 'https://go.idnow.example.com'
  }
}
```

Or many clients can be initialized with:

```ruby
client = Idnow::Client.new(env: @env, company_id: @company_id, api_key: @api_key)
```

## API Summary

Please read the official IDnow documentation for details. Some examples can also be found in the examples folder.

#### Identifications

```ruby
# Identification data, all fields are optional.
# If you want to use a testing robot instead of a real agent for the identification,
# write the robot name at the first_name, last_name or any custom field.
data = Idnow::IdentificationData.new({
   birthday: '1984-07-20',
   birthplace: 'Buxtehude',
   birthname: 'Meier',
   city: 'Berlin',
   country: 'DE',
   custom1: 'first custom parameter',
   custom2: 'second custom parameter',
   custom3: 'third custom parameter',
   custom4: 'fourth custom parameter',
   custom5: 'fifth custom parameter',
   trackingid: 'track123',
   email: 'petra.meier@example.com',
   firstname: 'X-AUTOTEST-HAPPYPATH',
   gender: 'FEMALE',
   lastname: 'Meier',
   nationality: 'DE',
   street: 'Sesamstraße',
   streetnumber: '34c',
   title: 'Prof. Dr. Dr. hc',
   zipcode: '10439'
})

# Request Identification
transaction_number = "A_TRANSACTION_NUMBER"
Idnow.client.request_identification(transaction_number: transaction_number, identification_data: data)

# Start testing robot - Only needed for automated robot testing
Idnow.client.testing_start(transaction_number: transaction_number)

# Testing video chat - Only needed for automated robot testing
Idnow.client.testing_request_video_chat(transaction_number: transaction_number)

# List successful identifications. When using automated robots,
# keep in mind that it might take a while until the identification is completed.
Idnow.client.login
Idnow.client.list_identifications

# List identifications by status pending or failed
Idnow.client.list_identifications(status: 'pending')

# Get identification. When using automated robots,
# keep in mind that it might take a while until the identification is completed.
Idnow.client.get_identification(transaction_number: transaction_number)

# Download identification files
Idnow.client.download_identification(transaction_number: transaction_number)
```

#### Esigning

```ruby
# Create document definition
document_identifier = "doc_id"
document_data = {
  "optional": true,
  "name": 'SomeDoc',
  "identifier": document_identifier,
  "mimeType": 'txt',
  "sortOrder": 1
}

Idnow.client.create_document_definition(document_data)

# List document definitions
Idnow.client.login
Idnow.client.list_document_definitions
# Or for cached results
Idnow.client.list_cached_document_definitions

# Upload document for a given identification
file_data = File.open('path/to/some/file.pdf', 'r')
Idnow.client.upload_identification_document(transaction_number, document_identifier, file_data)

# Upload default document
Idnow.client.upload_default_document(document_identifier, file_data)

# Download default document
Idnow.client.download_default_document(document_identifier)
```

## Development & testing

RSpec is used for testing. For easier development, the project is dockerized allowing development inisde the container.  Make use of following make targets:

Create development container:

```
make build
```

Open development console

```
make dev
```

Inside the console, `rspec` or `bundle` can be executed.


### Coverage report

To enable code coverage check, set COV environment variable:

```sh
COV=true make test
```

### Testing with docker

To run the tests through docker, you can use the included `Dockerfile`:

```sh
make build
docker run -it idnow-client:latest make test
```
