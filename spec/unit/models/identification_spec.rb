require 'spec_helper'

RSpec.describe Idnow::Identification do
  let(:json_data) do
    Idnow::Response.new(
      '{
      "identificationprocess": {
        "result": "FAILED",
        "reason": "STALLED_TIMEOUT",
        "companyid": "ihrebank",
        "filename": "12345.zip",
        "identificationtime": "2016-02-10T15:02:42+01:00",
        "id": "TST-UMCJU",
        "href": "/api/v1/ihrebank/identifications/12345.zip",
        "type": "WEB",
        "transactionnumber": "12345"
      },
      "customdata": {
        "custom3": "thirdcustomparameter",
        "custom4": "fourthcustomparameter",
        "custom1": "firstcustomparameter",
        "custom2": "secondcustomparameter",
        "custom5": "fifthcustomparameter",
        "trackingid": "track123"
      },
      "contactdata": {
        "mobilephone": null,
        "email": "petra.meier@example.com"
      },
      "userdata": {
        "birthday": {
          "value": "1984-07-20",
          "status": "MATCH"
        },
        "firstname": {
          "value": "PETRA",
          "status": "MATCH"
        },
        "address": {
          "zipcode": {
            "value": "10439",
            "status": "MATCH"
          },
          "country": {
            "value": "DE",
            "status": "MATCH"
          },
          "city": {
            "value": "BERLIN",
            "status": "MATCH"
          },
          "street": {
            "value": "SESAMSTRAxC3x9FE",
            "status": "MATCH"
          },
          "streetnumber": {
            "value": "34C",
            "status": "MATCH"
          }
        },
        "birthplace": {
          "value": "BUXTEHUDE",
          "status": "MATCH"
        },
        "nationality": {
          "value": "DE",
          "status": "MATCH"
        },
        "gender": {
          "value": "FEMALE",
          "status": "MATCH"
        },
        "birthname": {
          "value": "MEIER",
          "status": "MATCH"
        },
        "title": {
          "value": "PROF.DR.DR.HC",
          "status": "MATCH"
        },
        "lastname": {
          "value": "MEIER",
          "status": "MATCH"
        }
      },
      "identificationdocument": {},
      "attachments": {
        "pdf": "12345.pdf",
        "audiolog": "12345.mp3",
        "xml": "12345.xml",
        "idbackside": "12345_idbackside.jpg",
        "idfrontside": "12345_idfrontside.jpg",
        "userface": "12345_userface.jpg"
      }
      }'
    ).data
  end

  let(:identification) { Idnow::Identification.new(json_data) }

  describe '#identification_process' do
    subject { identification.identification_process }
      it 'returns an indentification process' do
        expect(subject).to eq({
                                'result' => 'FAILED',
                                'reason' => 'STALLED_TIMEOUT',
                                'companyid' => 'ihrebank',
                                'filename' => '12345.zip',
                                'identificationtime' => '2016-02-10T15:02:42+01:00',
                                'id' => 'TST-UMCJU',
                                'href' => '/api/v1/ihrebank/identifications/12345.zip',
                                'type' => 'WEB',
                                'transactionnumber' => '12345'
                              })
    end
  end

  describe '#contact_data' do
    subject { identification.contact_data }
      it 'returns an indentification process' do
        expect(subject).to eq({
                                'mobilephone' => nil,
                                'email' => 'petra.meier@example.com'
                              })
      end
    end

  describe '#user_data' do
    subject { identification.user_data }
      it 'returns an indentification process' do
        expect(subject).to eq({
                                'birthday' => { 'value' => '1984-07-20', 'status' => 'MATCH' },
                                'firstname' => { 'value' => 'PETRA', 'status' => 'MATCH' },
                                'address' =>
                                  { 'zipcode' => { 'value' => '10439', 'status' => 'MATCH' },
                                    'country' => { 'value' => 'DE', 'status' => 'MATCH' },
                                    'city' => { 'value' => 'BERLIN', 'status' => 'MATCH' },
                                    'street' => { 'value' => 'SESAMSTRAxC3x9FE', 'status' => 'MATCH' },
                                    'streetnumber' => { 'value' => '34C', 'status' => 'MATCH' } },
                                'birthplace' => { 'value' => 'BUXTEHUDE', 'status' => 'MATCH' },
                                'nationality' => { 'value' => 'DE', 'status' => 'MATCH' },
                                'gender' => { 'value' => 'FEMALE', 'status' => 'MATCH' },
                                'birthname' => { 'value' => 'MEIER', 'status' => 'MATCH' },
                                'title' => { 'value' => 'PROF.DR.DR.HC', 'status' => 'MATCH' },
                                'lastname' => { 'value' => 'MEIER', 'status' => 'MATCH' }
                              })
      end
  end

  describe '#identification_document' do
    subject { identification.identification_document }
      it 'returns an indentification process' do
        expect(subject).to eq(nil)
      end
    end

  describe '#attachments' do
    subject { identification.attachments }
      it 'returns an indentification process' do
        expect(subject).to eq({
                                'pdf' => '12345.pdf',
                                'audiolog' => '12345.mp3',
                                'xml' => '12345.xml',
                                'idbackside' => '12345_idbackside.jpg',
                                'idfrontside' => '12345_idfrontside.jpg',
                                'userface' => '12345_userface.jpg'
                              })
      end
  end
end
