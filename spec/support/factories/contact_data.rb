FactoryGirl.define do
  factory :idnow_contact_data, class: 'Idnow::ContactData' do
    skip_create
    initialize_with do
      new(IdnowResponsesHelper.contact_data_hash)
    end
  end
end
