class Infra::Networks < Infra::Elements
  attr_accessor :public, :private

  def find disk_id
    detect { |disk| disk.device == disk_id }
  end
end
