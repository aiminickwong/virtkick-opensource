class NewMachine < ActiveRecord::Base
  belongs_to :user

  validates :hostname, presence: true, format: {with: /\A[a-zA-Z0-9\.]+\z/}
  validates :hostname, uniqueness: { case_sensitive: false }
  validate :hostname_unique
  validates :plan_id, presence: true, numericality: {only_integer: true}
  validates :iso_distro_id, presence: true, numericality: {only_integer: true}

  # Form only
  attr_accessor :image_type


  def plan
    Defaults::MachinePlan.find plan_id if plan_id
  end

  def iso_distro
    Plans::IsoDistro.find iso_distro_id if iso_distro_id
  end

  def iso_image
    Plans::IsoImage.find iso_image_id if iso_image_id
  end

  def self.check_params params
    params = params.require(:machine).permit(:hostname, :image_type, :plan_id, :iso_distro_id, :iso_image_id)
    params
  end

  private
  def hostname_unique
    return if persisted?
    if MetaMachine.where(hostname: hostname).count > 0
      errors.add :hostname, 'already exists'
    end
  end
end
