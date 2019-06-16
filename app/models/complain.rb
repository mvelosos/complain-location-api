class Complain
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :locale, type: String
  field :company, type: String
end
