require_relative '../spec_helper'


describe IpReserver do
  before do
    @reserver = IpReserver.new

    @range = range = IpRange.create
    @first = Ip.create ip: '192.168.0.1', ip_range_id: range.id
    @second = Ip.create ip: '192.168.0.2', ip_range_id: range.id
  end

  after do
    [Ip, IpRange].each &:delete_all
  end

  def random_uuid
    z = SecureRandom.uuid
  end

  it 'reserves first IP' do
    # when
    reserved_ip = @reserver.reserve_ip random_uuid
    # then
    assert_equal reserved_ip.ip, @first.ip
  end

  it 'reserves only one IP for one account' do
    # given
    account = random_uuid
    # when
    first = @reserver.reserve_ip account
    second = @reserver.reserve_ip account
    # then
    assert_equal first.ip, @first.ip
    assert_equal second.ip, @first.ip
  end

  it 'reserves different IPs for different accounts' do
    # when
    first_ip = @reserver.reserve_ip random_uuid
    second_ip = @reserver.reserve_ip random_uuid
    # then
    assert_equal first_ip.ip, @first.ip
    assert_equal second_ip.ip, @second.ip
  end

  it 'throws an exception when ran out of IPs' do
    # given
    @reserver.reserve_ip random_uuid
    @reserver.reserve_ip random_uuid
    # when, then
    expect { @reserver.reserve_ip random_uuid }.to raise_error
  end
end
