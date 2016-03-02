module IdnowResponsesHelper
  extend self

  def identification_hash
    {
      'identificationprocess' => identification_process_hash,
      'contactdata' => contact_data_hash,
      'userdata' => user_data_hash,
      'attachments' => attachments_hash
    }
  end

  def identification_process_hash
    {
      'result' => 'SUCCESS',
      'companyid' => 'ihrebank',
      'filename' => '28.zip',
      'agentname' => 'TROBOT',
      'identificationtime' => '2016-02-25T13:51:20+01:00',
      'id' => 'TST-XLFYB',
      'href' => '/api/v1/ihrebank/identifications/28.zip',
      'type' => 'WEB',
      'transactionnumber' => '28'
    }
  end

  def contact_data_hash
    {
      'mobilephone' => '+4915193875727462264',
      'email' => 'petra.meier@example.com'
    }
  end

  def user_data_hash
    {
      'birthday' => {
        'value' => '2002-02-02',
        'status' => 'NEW'
      },
      'firstname' => {
        'value' => 'Mr Potatoe',
        'status' => 'MATCH'
      },
      'address' => {
        'zipcode' => {
          'value' => '12345',
          'status' => 'NEW'
        },
        'country' => {
          'value' => 'DE',
          'status' => 'NEW'
        },
        'city' => {
          'value' => 'CITY',
          'status' => 'NEW'
        },
        'street' => {
          'value' => 'STREET',
          'status' => 'NEW'
        },
        'streetnumber' => {
          'value' => '1',
          'status' => 'NEW'
        }
      },
      'birthplace' => {
        'value' => 'BIRTHPLACE',
        'status' => 'NEW'
      },
      'birthname' => {
        'value' => 'BIRTHNAME',
        'status' => 'NEW'
      },
      'nationality' => {
        'value' => 'DE',
        'status' => 'NEW'
      },
      'lastname' => {
        'value' => 'LASTNAME',
        'status' => 'NEW'
      },
      'title' => {
        'value' => 'TITLE',
        'status' => 'NEW'
      }
    }
  end

  def attachments_hash
    {
      'pdf' => '28.pdf',
      'audiolog' => '28.mp3',
      'xml' => '28.xml',
      'idbackside' => '28_idbackside.jpg',
      'idfrontside' => '28_idfrontside.jpg',
      'userface' => '28_userface.jpg'
    }
  end
end
