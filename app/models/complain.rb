class Complain
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  field :name, type: String
  field :title, type: String
  field :description, type: String
  field :locale, type: String
  field :company, type: String
  field :coordinates, type: Array

  geocoded_by :locale
  after_validation :geocode

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :locale
  validates_presence_of :company

end
