RSpec.shared_context 'idnow api responses' do
  let(:user_data_hash) { success_identification_hash['userdata'] }

  let(:contact_data_hash) { success_identification_hash['contactdata'] }

  let(:identification_process_hash) { success_identification_hash['identificationprocess'] }

  let(:success_identification_hash) { JSON.parse(success_identification_json) }

  let(:success_identification_json) do
    <<-JSON
    {
      "identificationprocess": {
        "result": "SUCCESS",
        "companyid": "ihrebank",
        "filename": "28.zip",
        "agentname": "TROBOT",
        "identificationtime": "2016-02-25T13:51:20+01:00",
        "id": "TST-XLFYB",
        "href": "/api/v1/ihrebank/identifications/28.zip",
        "type": "WEB",
        "transactionnumber": "28"
      },
      "customdata": {
        "custom3": null,
        "custom4": null,
        "custom1": null,
        "custom2": null,
        "custom5": null
      },
      "contactdata": {
        "mobilephone": "+4915193875727462264",
        "email": "petra.meier@example.com"
      },
      "userdata": {
        "birthday": {
          "value": "2002-02-02",
          "status": "NEW"
        },
        "firstname": {
          "value": "Mr Potatoe",
          "status": "MATCH"
        },
        "address": {
          "zipcode": {
            "value": "12345",
            "status": "NEW"
          },
          "country": {
            "value": "DE",
            "status": "NEW"
          },
          "city": {
            "value": "CITY",
            "status": "NEW"
          },
          "street": {
            "value": "STREET",
            "status": "NEW"
          },
          "streetnumber": {
            "value": "1",
            "status": "NEW"
          }
        },
        "birthplace": {
          "value": "BIRTHPLACE",
          "status": "NEW"
        },
        "nationality": {
          "value": "DE",
          "status": "NEW"
        },
        "lastname": {
          "value": "LASTNAME",
          "status": "NEW"
        }
      },
      "identificationdocument": {
        "country": {
          "value": "DE",
          "status": "NEW"
        },
        "number": {
          "value": "123456789",
          "status": "NEW"
        },
        "issuedby": {
          "value": "ISSUER",
          "status": "NEW"
        },
        "dateissued": {
          "value": "2010-10-12",
          "status": "NEW"
        },
        "type": {
          "value": "IDCARD",
          "status": "NEW"
        },
        "validuntil": {
          "value": "2020-10-11",
          "status": "NEW"
        }
      },
      "attachments": {
        "pdf": "28.pdf",
        "audiolog": "28.mp3",
        "xml": "28.xml",
        "idbackside": "28_idbackside.jpg",
        "idfrontside": "28_idfrontside.jpg",
        "userface": "28_userface.jpg"
      }
    }
    JSON
  end
end
