require 'spec_helper'

describe IdnowRuby::Identification do

  include_context 'configuration'

  let(:identification) { IdnowRuby::Identification.create(transaction_number) }
  let(:transaction_number) { '1234567890' }

  describe '#start' do
    context 'when valid data is used' do
      let(:identification_data) { {
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
        gender: IdnowRuby::IdentificationData::Gender::FEMALE,
        lastname: 'Meier',
        nationality: 'DE',
        street: 'Sesamstraße',
        streetnumber: '34c',
        title: 'Prof. Dr. Dr. hc',
        zipcode: '10439'
      } }

      before do
        stub_request(:post, "https://gateway.idnow.de/api/v1/#{IdnowRuby.config.company_id}/identifications/#{transaction_number}/start").
          with( body: "{\"birthday\":\"1984-07-20\",\"birthplace\":\"Buxtehude\",\"birthname\":\"Meier\",\"city\":\"Berlin\",\"country\":\"DE\",\"custom1\":\"first custom parameter\",\"custom2\":\"second custom parameter\",\"custom3\":\"third custom parameter\",\"custom4\":\"fourth custom parameter\",\"custom5\":\"fifth custom parameter\",\"trackingid\":\"track123\",\"email\":\"petra.meier@example.com\",\"firstname\":\"Petra\",\"gender\":\"FEMALE\",\"lastname\":\"Meier\",\"nationality\":\"DE\",\"street\":\"Sesamstraße\",\"streetnumber\":\"34c\",\"title\":\"Prof. Dr. Dr. hc\",\"zipcode\":\"10439\"}",
                headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby', 'X-Api-Key'=>IdnowRuby.config.api_key}).
          to_return(:status => 200, :body => "", :headers => {})

          identification.start(identification_data)
      end

      it { expect(identification.id).to be nil }
      it { expect(identification.errors?).to be false }
    end
  end
end
