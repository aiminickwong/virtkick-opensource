class Errors < StandardError
  attr_reader :errors

  def initialize errors
    @errors = errors
  end

  def message
    if @errors.size == 0
      @errors.first.to_s
    else
      @errors.map(&:to_s).to_s
    end
  end
end
