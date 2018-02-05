describe Wvm::Base do
  [Errno::EPIPE, Errno::ECONNRESET].each do |error|
    it "retries call on #{error}" do
      # given
      raise_error_on_first_call error
      # when
      response = Wvm::Base.call :post, '/'
      # then
      expect(response.to_hash).to eq({key: :val})
      expect(Wvm::Base).to have_received(:post).twice
    end
  end

  def raise_error_on_first_call error
    thrown = false
    allow(Wvm::Base).to receive(:post) do
      if thrown
        {'errors' => [], 'response' => {key: :val}}
      else
        thrown = true
        raise error
      end
    end
  end
end
