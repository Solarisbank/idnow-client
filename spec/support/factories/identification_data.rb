FactoryGirl.define do
  factory :idnow_identification_data, class: 'Idnow::IdentificationData' do
    skip_create

    birthday '1984-07-20'
    birthplace 'Buxtehude'
    birthname 'Meier'
    city 'Berlin'
    country 'DE'
    custom1 'first custom parameter'
    custom2 'second custom parameter'
    custom3 'third custom parameter'
    custom4 'fourth custom parameter'
    custom5 'fifth custom parameter'
    trackingid 'track123'
    email 'petra.meier@example.com'
    firstname 'Petra'
    gender 'FEMALE'
    lastname 'Meier'
    nationality 'DE'
    street 'Sesamstraße'
    streetnumber '34c'
    title 'Prof. Dr. Dr. hc'
    zipcode '10439'
  end
end
