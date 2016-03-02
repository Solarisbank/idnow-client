FactoryGirl.define do
  factory :idnow_user_data, class: 'Idnow::UserData' do
    skip_create
    initialize_with do
      new IdnowResponsesHelper.user_data_hash
    end
  end
end
