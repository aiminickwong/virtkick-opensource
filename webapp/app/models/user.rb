class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable

  has_many :meta_machines, dependent: :destroy
  has_many :new_machines, dependent: :destroy
  has_many :progresses, dependent: :destroy

  scope :guest, -> {
    where(guest: true)
  }

  scope :to_delete, -> {
    guest.where('created_at < ?', 45.minutes.ago)
  }


  def self.create_guest!
    email = "guest_#{SecureRandom.uuid}@alpha.virtkick.io"
    guest = User.new email: email, guest: true
    guest.save validate: false
    guest
  end

  def machines
    Infra::Elements.new self.meta_machines.map &:machine
  end

  def to_s
    "User #{id}: #{email}"
  end
end
