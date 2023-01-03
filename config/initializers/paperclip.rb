Paperclip.interpolates(:default_user) do |attachment, style|
  ActionController::Base.helpers.asset_path("#{ENV.fetch('USER_ICON_COLOR')}.svg")
end

Paperclip.interpolates(:default_media) do |attachment, style|
  ActionController::Base.helpers.asset_path('default_user.png')
end

Paperclip.interpolates(:default_wallpaper) do |attachment, style|
  ActionController::Base.helpers.asset_path('default_wallpaper.png')
end
