require 'spec_helper'

RSpec.describe Idnow::Response::Identifications do
  let(:successful_raw_response) do
    '{
    	"identifications": [{
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
    	}, {
    		"identificationprocess": {
    			"result": "FAILED",
    			"reason": "USER_CANCELLATION",
    			"companyid": "ihrebank",
    			"filename": "1234567890.zip",
    			"identificationtime": "2016-01-28T20:33:28+01:00",
    			"id": "TST-FQTNE",
    			"href": "/api/v1/ihrebank/identifications/1234567890.zip",
    			"type": "APP",
    			"transactionnumber": "1234567890"
    		},
    		"customdata": {
    			"custom3": null,
    			"custom4": null,
    			"custom1": "287492_23552",
    			"custom2": null,
    			"custom5": null
    		},
    		"contactdata": {
    			"mobilephone": "+4915123411232",
    			"email": "sampleuser@example.com"
    		},
    		"userdata": {
    			"birthday": {
    				"value": "1975-12-20",
    				"status": "MATCH"
    			},
    			"firstname": {
    				"value": "MICHAEL",
    				"status": "MATCH"
    			},
    			"address": {
    				"zipcode": {
    					"value": "80127",
    					"status": "MATCH"
    				},
    				"country": {
    					"value": "DE",
    					"status": "MATCH"
    				},
    				"city": {
    					"value": "MxC3x9CNCHEN",
    					"status": "MATCH"
    				},
    				"street": {
    					"value": "BAHNSTRASSE",
    					"status": "MATCH"
    				},
    				"streetnumber": {
    					"value": "27",
    					"status": "MATCH"
    				}
    			},
    			"birthplace": {
    				"value": "MxC3x9CNCHEN",
    				"status": "MATCH"
    			},
    			"nationality": {
    				"value": "DE",
    				"status": "MATCH"
    			},
    			"lastname": {
    				"value": "BERGER",
    				"status": "MATCH"
    			}
    		},
    		"identificationdocument": {},
    		"attachments": {
    			"pdf": "1234567890.pdf",
    			"audiolog": "1234567890.mp3",
    			"xml": "1234567890.xml",
    			"idbackside": "1234567890_idbackside.jpg",
    			"idfrontside": "1234567890_idfrontside.jpg",
    			"userface": "1234567890_userface.jpg"
    		}
    	}]
 }'
  end

  let(:failure_raw_response) do
    '{
      "errors": [{
              "cause": "EXPIRED_TOKEN"
      }]
     }'
  end
  let(:identification_response) { Idnow::Response::Identifications.new(response) }

  describe '#identifications' do
    subject { identification_response.identifications }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it 'returns a collection of identifications' do
        # TODO: how do we whant to handle this response
        expect(subject).to_not be_empty
      end
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it 'returns nil' do
        expect(subject).to eq nil
      end
    end
  end
end
