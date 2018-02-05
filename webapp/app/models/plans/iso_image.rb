class Plans::IsoImage < ActiveYaml::Base
  include ActiveHash::Associations
  set_root_path 'app/models'

  field :id
  field :file
  field :pool_name
  field :bit
  field :short_name
  field :long_name
  field :enabled, default: true

  belongs_to :iso_distro, class_name: 'Plans::IsoDistro'


  def path
    Infra::DiskType.find(pool_name).path + '/' + file
  end

  def self.by_file file
    self.all.select { |image| image.file == file }
  end
end
