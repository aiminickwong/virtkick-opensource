class Plans::IsoDistro < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path 'app/models'

  field :id
  field :code
  field :name
  field :short_name

  has_many :iso_images, class_name: 'Plans::IsoImage'
end
