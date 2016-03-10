# Idnow Client
Library to consume the [IDnow API](http://www.idnow.eu/developers)  in Ruby.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idnow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idnow

## Usage

### Configuration

The Idnow client takes three setting: `env`, `company_id` and `api_key`.

1.  `env` can be set to `:live` or `:test`. Following the IDnow API documentation,
each of these environments will correspondingly set the host to:

  -  Live server `gateway.idnow.de`
  -  Test server `gateway.test.idnow.de`

2.  `company_id` and `api_key` uniquely identifies your company as provided by
IDnow during your account setup.

Example:

```ruby
Idnow.env = :test
Idnow.company_id = "mycompany"
Idnow.api_key = "1234api_key"
```

### API

Then, identification requests can be performed:

```ruby
Idnow.identifier.start(transaction_number, identification_data)
```

`transaction number` is used to identify the requested identification. This ID
should be used by as a key to assign the identification to an internal customer data set.

`identification_data` stores the user's details. An example with all the
possible attributes is:

```ruby
 Idnow::IdentificationData.new({
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
    firstname: 'Petra',
    gender: 'FEMALE',
    lastname: 'Meier',
    nationality: 'DE',
    street: 'Sesamstraße',
    streetnumber: '34c',
    title: 'Prof. Dr. Dr. hc',
    zipcode: '10439'
 })
```

## Development

Rspec is used for testing.
To enable code coverage check, set COV environment variable:

`COV=true bundle exec rspec`
