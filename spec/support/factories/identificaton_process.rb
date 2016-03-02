FactoryGirl.define do
  factory :idnow_identification_process, class: 'Idnow::IdentificationProcess' do
    skip_create
    initialize_with do
      new(IdnowResponsesHelper.identification_process_hash)
    end
  end
end
