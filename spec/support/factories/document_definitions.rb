# frozen_string_literal: true

FactoryGirl.define do
  factory :idnow_document_definition, class: 'Idnow::DocumentDefinition' do
    skip_create

    initialize_with do
      new(idnow_document_definition_hash)
    end

    transient do
      identifier 'doc1'

      idnow_document_definition_hash do
        build(:idnow_document_definition_hash, identifier: identifier)
      end
    end
  end
end

FactoryGirl.define do
  factory :idnow_document_definition_hash, class: 'Hash' do
    skip_create

    identifier 'doc1'
    initialize_with do
      JSON.parse(<<-JSON)
        {
          "optional":false,
          "name":"Arbeitsvertrag",
          "identifier":"#{identifier}",
          "mimeType":"application/pdf",
          "sortOrder":1
        }
      JSON
    end
  end
end
