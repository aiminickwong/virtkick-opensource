describe NewMachine do
  let(:new_machine) {
    NewMachine.new plan_id: 1, iso_distro_id: 1
  }


  context 'hostname validator' do
    it 'forbids empty' do
      new_machine.hostname = ''
      expect(new_machine.valid?).to eq false
    end

    it 'allows domain names' do
      new_machine.hostname = 'example.com'
      expect(new_machine.valid?).to eq true
    end

    it 'allows simple words' do
      new_machine.hostname = 'example'
      expect(new_machine.valid?).to eq true
    end

    it 'forbids spaces' do
      new_machine.hostname = 'example machine'
      expect(new_machine.valid?).to eq false
    end
  end
end
