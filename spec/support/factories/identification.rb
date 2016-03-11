FactoryGirl.define do
  factory :idnow_identification, class: 'Idnow::Identification' do
    skip_create

    initialize_with do
      new(idnow_identification_hash)
    end

    transient do
      result "SUCCESS"
      reference "28"

      idnow_identification_hash {
        build(:idnow_identification_hash, result: result, reference: reference)
      }
    end
  end
end

FactoryGirl.define do
  factory :idnow_identification_hash, class: 'Hash' do
    skip_create

    result "SUCCESS"
    reference "28"

    initialize_with do
      JSON.parse(<<-JSON)
        {
          "identificationprocess": {
            "result": "#{result}",
            "companyid": "ihrebank",
            "filename": "#{reference}.zip",
            "agentname": "TROBOT",
            "identificationtime": "2016-02-25T13:51:20+01:00",
            "id": "TST-XLFYB",
            "href": "/api/v1/ihrebank/identifications/#{reference}.zip",
            "type": "WEB",
            "transactionnumber": "#{reference}"
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
            "pdf": "#{reference}.pdf",
            "audiolog": "#{reference}.mp3",
            "xml": "#{reference}.xml",
            "idbackside": "#{reference}_idbackside.jpg",
            "idfrontside": "#{reference}_idfrontside.jpg",
            "userface": "#{reference}_userface.jpg"
          }
        }
      JSON
    end
  end
end
