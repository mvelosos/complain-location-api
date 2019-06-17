class Complain
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  # include Geocoder::Model::MongoMapper

  field :name, type: String
  field :title, type: String
  field :description, type: String
  field :locale, type: String
  field :company, type: String
  field :coordinates, type: Array

  geocoded_by :locale
  after_validation :geocode
end
