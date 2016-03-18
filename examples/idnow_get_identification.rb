require 'idnow'

fail 'please call with a transaction number' unless ARGV[0]

company_id = ENV.fetch('IDNOW_COMPANY_ID')
api_key = ENV.fetch('IDNOW_API_KEY')

transaction_number = ARGV[0]

Idnow.env = :test
Idnow.company_id = company_id
Idnow.api_key = api_key

Idnow.client.login
identification = Idnow.client.get_identification(transaction_number: transaction_number)
puts identification.inspect
