FactoryGirl.define do
  factory :idnow_identification, class: 'Idnow::Identification' do
    skip_create

    initialize_with do
      new(idnow_identification_hash)
    end

    transient do
      result 'SUCCESS'
      reason nil
      transaction_number '28'
      esigning false

      idnow_identification_hash do
        build(:idnow_identification_hash, reason: reason, result: result,
                                          transaction_number: transaction_number, esigning: esigning)
      end
    end
  end
end

FactoryGirl.define do
  factory :idnow_identification_hash, class: 'Hash' do
    skip_create

    result 'SUCCESS'
    reason nil
    transaction_number '28'
    esigning false

    initialize_with do
      esigning_json = if esigning == false
                        ''
                      else
                        '
                          "esigning": {
                            "result": "SUCCESS",
                            "sessionid": "3XIDNOW-SERVID01-_-20160330140640-7B4C7736M47BE285"
                          },
                        '
                      end
      reason_json = reason.nil? ? '' : "\"reason\": \"#{reason}\", "

      JSON.parse(<<-JSON)
        {
          "identificationprocess": {
            "result": "#{result}",
            #{reason_json}
            "companyid": "ihrebank",
            "filename": "#{transaction_number}.zip",
            "agentname": "TROBOT",
            "identificationtime": "2016-02-25T13:51:20+01:00",
            "id": "TST-XLFYB",
            "href": "/api/v1/ihrebank/identifications/#{transaction_number}.zip",
            "type": "WEB",
            "transactionnumber": "#{transaction_number}"
          },
          #{esigning_json}
          "customdata": {
            "custom3": null,
            "custom4": null,
            "custom1": null,
            "custom2": null,
            "custom5": null
          },
          "contactdata": {
            "mobilephone": "+4915193875727",
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
            },
            "title": {
              "value": "TITLE",
              "status": "MATCH"
            },
            "gender": {
              "value": "GENDER",
              "status": "MATCH"
            },
            "birthname": {
              "value": "BIRTHNAME",
              "status": "MATCH"
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
            "pdf": "#{transaction_number}.pdf",
            "audiolog": "#{transaction_number}.mp3",
            "xml": "#{transaction_number}.xml",
            "idbackside": "#{transaction_number}_idbackside.jpg",
            "idfrontside": "#{transaction_number}_idfrontside.jpg",
            "userface": "#{transaction_number}_userface.jpg"
          }
        }
      JSON
    end
  end
end
