
2020 Refresh & Update. Below info is subject to change as it is largely deprecated.

New Prod Server under development:
Digital Ocean
meek-ly-prod-1
143.198.176.100

# Meek Project:
 * [Meek.co](#chapter-1)
 * [Credentials](#chapter-2)
 * [secrets.yml](#chapter-3)
 * [Initial setup of the app](#chapter-4)
 * [To make tests run](#chapter-5)
 * [Restore DUMP](#chapter-6)
 * [FontCustom](#chapter-7)
 * [Cache & Prerenderer & Hint](#chapter-8)

# <a id="chapter-1"></a>Meek.co

Production: [www.meek.co](https://www.meek.co/)
Staging: [staging.meek.co](https://staging.meek.co/)

Facebook Production: [facebook](https://www.facebook.com/meekgrowth/)
Facebook Staging: [facebook](https://www.facebook.com/stagingmeekdev/)

# <a id="chapter-2"></a>Credentials

**customer.io:**
Production | Staging:
- login: dmitriy.vasin@anahoret.com
- password: meekprojcustomer

Dev:
- dv@anadeainc.com
- password

**prerender.io**

Api key: 9xpO7QFOsMAzETMVNUHU
- johnpaul@meek.co
- 8#SwimFaster

**Twitter Api Key**
- Consumer key: s6TZ3clltLHhMxP77ZvDFNiwO
- Consumer Secret Key: dubJ3oxrRVibBj7n2JlZ1lRNOGHNtunGTTGDemHjjHphHzDRbd

**Facebook**
For staging and development:

Facebook
- facebook_key: “1644675302451196”
- facebook_secret: “e2eaa771205d1614ad58544d5b167afe”
Facebook share token
- facebook_page: “stagingmeekdev”
- facebook_access_token: “CAAXX0s8sZAZCwBAMqVZBBpZC1y7iULclx0Ud9AF944qRFSi8jvUvcC2fOWiPxk1ZCzM1SIZBp8gPJ2AWVzEBa5v5mn80WZBRBNdsDJqSZC1rZAuknEygMLnVo5ReM2OewnCosr4wjq4IzTwhWQWHJDBqiKPg72Gv9sZByx1EQg9wsc2ulTPGkMOJdS”

**For Production:**

Facebook
- facebook_key: “784099628324019”
- facebook_secret: “ea383d0aa8941272699359a0d0966325”

Facebook share token
- facebook_page: “meekgrowth”
- facebook_access_token: “CAALJImvQlLMBALIOuUSOgiZAlCcxC5Kcqyi0zcz9mNungPA0nn9oFqGyICXundNzkeuZC1skhB0jlisK7damon46eAo0KvhuPIkZCsynkTARGr5WvJnLzkG5KXZA4EV31w5cdeHALZAtlgc9qsIpG1fW9t5L1oaTjk26f8FRcbryjbbQtYbPR”

**Swiftype**
- johnpaul@meek.co
- superdeeduperfastsearch

# <a id="chapter-3"></a>secrets.yml
```
default: &default
  # Devise
  devise_secret_key: "5a4bd5134b65ae72b8a49806d4232b01637b0bb2923fa2ead51a603e823888d684f70b62d9514364925f2672328c78fff2a395015ede13f4059d58c33fceccfa"

  # Mailchimp
  # mailchimp_api_key: "ebdba5914736c6eeb41c5192ecbb7221-us10"
  # mailchimp_list_id: "d095931549"

  # Mail Sending Credentials:
  mail_username: 'xxx'
  mail_password: 'xxx'


  # customer.io
  cio_site_id: 'ab8c6590543c810ba534'
  cio_site_key: 'e8f9337099173ee5cd4b'

  # Prerender
  # PRERENDER_TOKEN_OLD: "3v5q0M7aGxjP3t58xPYa"
  prerender_token: "9xpO7QFOsMAzETMVNUHU"

  # # Facebook
  # facebook_key: "784099628324019"
  # facebook_secret: "ea383d0aa8941272699359a0d0966325"

  # Twitter
  twitter_key: "s6TZ3clltLHhMxP77ZvDFNiwO"
  twitter_secret: "dubJ3oxrRVibBj7n2JlZ1lRNOGHNtunGTTGDemHjjHphHzDRbd"

development:
  <<: *default

  secret_key_base: "67c9bf3d2b2b6bfe01ed95348a43c82e42f0f31cf6711eecd5e09973af70b044b7322cb1c05407b9a612c267efa2d304227896e47f74dfa386d4e4cf002c23e6"

  # Database
  db_name: "meek_development_pg"
  db_username: "dv"
  db_password: ""
  db_host: "localhost"
  db_pool: "10"

  # Support email
  support_email: 'meek@anahoret.com'

  # Facebook
  facebook_key: "1644675302451196"
  facebook_secret: "e2eaa771205d1614ad58544d5b167afe"
  # Facebook share token
  facebook_page: "stagingmeekdev"
  facebook_access_token: "CAAXX0s8sZAZCwBACePMsYuwwI0qkYuarpC01Xld6qgDkxn6FfpLm1olUU2ZCZChRhuD33B1BxnbdXY8Hz6NaMQjiT9R99KlMapMYVdBCxtSNS5ltBqONZAMxQFKEbUc6CRn96wiGlunOiqW845TTKwrwH93wDMmRnUXvCArfLfTpV9nPZALlhT"
  # facebook_page: "meekgrowth"
  # facebook_access_token: "EAALJImvQlLMBANRZAGV5c4jShEi4ZCJ8KWxCb07t7LV8ZBgTeu1foSfjaXWkQUvia25ZCQ29swhj4Npfxsgw1jpw4OcMUhFMff3X2gUJ7mh1R8QFZA3BrzJWyhzW4xNZC0cxJveqwE2ZC9NvVp4GtNzed0cusxr6m8ZD"

  # Vimeo secrets.
  # Client Identifier: "dfdb6d90ad5f07e6e15155e159b6528f8a2c9930"
  # Client Secret: "mbQjKljiUgLbMj0w57XGMEnKcZU+WLK1EQVgm4jXvER9PVIjdX4O3Sc6LoyhyaCJiyP1zS1F3brn2KvQLmWLsTc1hfu0FbN37BMbkR74dP4pRVH19CMlGRXByXSkVKJx"
  # vimeo_access_code = Get base64 of "client_id + ':' + client_secret"
  vimeo_access_code: "ZGZkYjZkOTBhZDVmMDdlNmUxNTE1NWUxNTliNjUyOGY4YTJjOTkzMDptYlFqS2xqaVVnTGJNajB3NTdYR01FbktjWlUrV0xLMUVRVmdtNGpYdkVSOVBWSWpkWDRPM1NjNkxveWh5YUNKaXlQMXpTMUYzYnJuMkt2UUxtV0xzVGMxaGZ1MEZiTjM3Qk1ia1I3NGRQNHBSVkgxOUNNbEdSWEJ5WFNrVktKeA=="

test:
  <<: *default

  secret_key_base: "67c9bf3d2b2b6bfe01ed95348a43c82e42f0f31cf6711eecd5e09973af70b044b7322cb1c05407b9a612c267efa2d304227896e47f74dfa386d4e4cf002c23e6"

```

# <a id="chapter-4"></a>Initial setup of the app

FFmpeg:

```
brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-frei0r --with-libass --with-libvo-aacenc --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools
```

NPM modules
```
npm install
```

Redis
```
brew install redis
```
redis-3.0.0 should be installed.

To have launchd start redis at login:
```
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
```

Then to load redis now:
```
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```
Or, if you don’t want/need launchctl, you can just run:
```
redis-server /usr/local/etc/redis.conf
```

After that:
```
$ redis-server —version
=> Redis server v=3.0.0
```



# <a id="chapter-5"></a>To make tests run

Check gems versions.

```
gem list | grep capybara
```

Should be:

```
capybara (2.6.2)
capybara-screenshot (1.0.11)
capybara-webkit (1.8.0)
```

If versions are different – uninstall these gems completely
Then:
```
brew update; brew uninstall qt;  brew uninstall qt5
brew install qt5 || brew install qt55 (depends from OS version)
bundle install
rspec
```

# <a id="chapter-6"></a>Restore DUMP
```
production = 159.203.117.170

pg_dump -Fc -h localhost -U meek meek > dd-mm-yyyy.dump

ssh deploy@[PRODUCTION]
cd /var/www/apps/meek/shared/config

scp deploy@[PRODUCTION]:/var/www/apps/meek/shared/config/dd-mm-yyyy.dump ~/Desktop/

sudo pg_restore —verbose —no-acl —no-owner —clean —jobs 4 -h localhost -U [DB_USERNAME] -d [DB_NAME] ~/Desktop/dd-mm-yyyy.dump
```

To restore dump u can use rake task:
```
rake db:dump_recreate['~/Desktop/dd-mm-yyyy.dump']
```

# <a id="chapter-7"></a>FontCustom

to use fontcustom
```
brew install fontforge --with-python
brew install eot-utils
gem install fontcustom
```

add svg in `app/assets/svgs`

and run in console:
```
fontcustom compile app/assets/svgs
```
open:
```
app/assets/fonts/styleguide/meek-preview.html
```

# <a id="chapter-8"></a>Cache & Prerenderer & Hint
We use angular's cache and jbuilder cache
( Please Note that - this is not DB cache )

We use prerenderer.io for SEO purpose, note that prerenderer works only in production mode.
Also it has not specified time to recache page.

Prerenderer has API for recache pages
`PrerendererRecacheService` - Is use this API

Problem can exist with such approach when you create new episode and start publishing to FB this episode ( url to this episode ). In this case shared post will be blank - because prerenderer service did not have time to cache page.

# Facebook Publish Token for Buisness page:
Note: To get token you should have admin access to the page.

App ID and App Secret you can find at app dashboard:
https://developers.facebook.com/apps/784099628324019/dashboard/

Follow this guide:
https://gist.github.com/1v/b9039239c7cad9abf6a20260238e80f2

To check token please visit:
https://developers.facebook.com/tools/debug/accesstoken/
