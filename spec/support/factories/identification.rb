FactoryGirl.define do
  factory :idnow_identification, class: 'Idnow::Identification' do
    skip_create
    initialize_with do
      new(IdnowResponsesHelper.identification_hash)
    end
  end
end
