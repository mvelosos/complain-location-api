class Geolocalization
  
  def self.coordinates(params)
    Geocoder.search("#{params[:lat]},#{params[:lon]}")
  end
  
  def self.localization(coordinates)
    Geocoder.search("#{coordinates[0]},#{coordinates[1]}")
  end

end