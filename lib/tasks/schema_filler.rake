namespace :schema_filler do
  def create_schema_podcast(podcast)
    %{
    <script type="application/ld+json">
      {
        "@context": "http://schema.org",
        "@type": "OnDemandEvent",
        "name" : "#{podcast.name}",
        "image" : "meek.ly#{podcast.image.url}",
        "url": "#{podcast.website}"
      }
    </script>
    }
  end

  task run: :environment do
    Podcast.all.each do |podcast|
      podcast.update(schema: create_schema_podcast(podcast))
    end
  end


end
