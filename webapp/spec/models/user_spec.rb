describe User do
  require 'timecop'

  before do
    Timecop.freeze 2010, 1, 1
    @created_at = Time.zone.now
    @guest = User.create_guest!
    @user = User.create! email: 'test@virtkick.io'
  end

  after do
    Timecop.return
  end

  it 'lists all guests' do
    expect(User.guest.to_a).to eq [@guest]
  end

  it 'lists all inactive guests' do
    expect(User.guest.to_delete.to_a).to eq []
    Timecop.travel @created_at + 45.minutes
    expect(User.guest.to_delete.to_a).to eq [@guest]
  end
end
