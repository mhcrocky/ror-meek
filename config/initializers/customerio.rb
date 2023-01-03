$customerio = Customerio::Client.new(
                ENV.fetch('CIO_SITE_ID'),
                ENV.fetch('CIO_SITE_KEY'),
                json: true
              )
