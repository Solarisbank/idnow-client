require 'idnow'

fail 'please call with a document identifier (must be unique)' unless ARGV[0]

company_id = ENV.fetch('IDNOW_COMPANY_ID')
api_key = ENV.fetch('IDNOW_API_KEY')

document_identifier = ARGV[0]

Idnow.env = :test
Idnow.company_id = company_id
Idnow.api_key = api_key

Idnow.client.login

# Please uncomment the lines below to also create a document definition
# document_data = {
#   "optional": true,
#   "name": 'SomeDoc',
#   "identifier": document_identifier.to_s,
#   "mimeType": 'txt',
#   "sortOrder": 1
# }

# puts 'Creating document definition...'
# Idnow.client.create_document_definition(document_data)

puts 'Uploading default document...'
file = File.open('spec/support/test_files/example.txt', 'r')
Idnow.client.upload_default_document(document_identifier, file)

puts 'Downloading default document...'
Idnow.client.download_default_document(document_identifier)
