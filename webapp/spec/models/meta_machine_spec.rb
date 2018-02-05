describe MetaMachine do
  # https://github.com/virtkick/virtkick/issues/26
  it 'caches the ID when creating an instance of Infra::Machine' do
    # given
    allow(Infra::Machine).to receive(:find).and_return Infra::Machine.new
    meta_machine = MetaMachine.create!
    # when
    meta_machine.delete
    machine = meta_machine.machine
    # then
    expect(machine.id).to eq meta_machine.id
  end
end
