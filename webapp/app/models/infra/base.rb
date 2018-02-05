class Infra::Base
  include ActiveModel::Model
  include ActiveModel::AttributeMethods


  def persisted?
    self.id.present?
  end

  def to_s
    inspect
  end
end
