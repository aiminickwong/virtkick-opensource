class NextDeviceName
  def next *current
    current = current.compact
    return 'vda' if current.empty?

    candidates = current.map &:succ
    available_names = candidates - current
    available_names.sort.first
  end
end