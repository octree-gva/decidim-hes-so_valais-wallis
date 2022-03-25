# frozen_string_literal: true

# Geocoder configuration
Decidim.configure do |config|
  if ENV.fetch('GEO_HERE_API', '').present?
    config.geocoder = {
      static_map_url: 'https://image.maps.ls.hereapi.com/mia/1.6/mapview',
      here_api_key: ENV.fetch('GEO_HERE_API'),
      # geocoding service request timeout, in seconds (default 3):
      timeout: 5,
      # set default units to kilometers:
      units: :km,
      # caching (see https://github.com/alexreisner/geocoder#caching for details):
      cache_prefix: 'geo'
    }
  end
end
