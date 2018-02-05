class MachineMountIsoJob < TrackableJob
  self.set_max_attempts 5, 1.second

  def perform meta_machine_id, iso_image_id
    iso_image = Plans::IsoImage.find iso_image_id
    machine = MetaMachine.find(meta_machine_id).machine
    machine.mount_iso iso_image
  end
end
