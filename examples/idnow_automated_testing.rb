require 'idnow'

fail 'please call with a transaction number' unless ARGV[0]

company_id = ENV.fetch('IDNOW_COMPANY_ID')
api_key = ENV.fetch('IDNOW_API_KEY')

transaction_number = ARGV[0]

Idnow.env = :test
Idnow.company_id = company_id
Idnow.api_key = api_key

data = Idnow::IdentificationData.new({
                                       firstname: 'X-AUTOTEST-HAPPYPATH'
                                     })
puts "\n\n"

puts "--- Request identification for #{transaction_number} ---"
identification = Idnow.client.request_identification(transaction_number: transaction_number, identification_data: data)
puts identification.inspect

puts "\n\n"

puts '--- Start testing robot ---'
testing_start = Idnow.client.testing_start(transaction_number: transaction_number)
puts testing_start.inspect

puts "\n\n"

puts '--- Testing video chat---'
Idnow.client.testing_request_video_chat(transaction_number: transaction_number)

puts 'It might take a while until the identification is marked as successfull,' \
     ' wait a little bit and then run idnow_get_identification.rb script'
