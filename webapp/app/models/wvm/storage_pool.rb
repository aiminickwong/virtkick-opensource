class Wvm::StoragePool < Wvm::Base
  def self.all
    response = call :get, 'storages'

    response.storages.map do |storage_pool|
      Infra::DiskType.new \
          name: storage_pool.name,
          enabled: storage_pool.enabled
    end
  end

  def self.find name
    raise unless name =~ /\A[a-zA-Z]+\Z/
    storage_pool = call :get, "storage/#{name}"

    Infra::DiskType.new \
        name: storage_pool.pool,
        path: storage_pool.path,
        enabled: storage_pool.state == 1
  end
end
