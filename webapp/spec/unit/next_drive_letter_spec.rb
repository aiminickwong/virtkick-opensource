describe NextDeviceName do
  let(:device_name) { NextDeviceName.new }

  it 'provides vda when no VM has a disk yet' do
    expect(device_name.next nil).to eq 'vda'
  end

  it 'provides next device name' do
    expect(device_name.next 'vda').to eq 'vdb'
  end

  it 'fills in a hole between vda and vdc' do
    expect(device_name.next 'vda', 'vdc'). to eq 'vdb'
  end
end
