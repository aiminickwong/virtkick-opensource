describe TrackableJob do
  class ExampleJob < TrackableJob
    def perform
    end
  end

  class ExampleFailingJob < TrackableJob
    def perform
      raise 'expected error'
    end
  end

  it 'successful job' do
    # when
    progress_id = ExampleJob.perform_later 1
    # then
    progress = Progress.find progress_id
    expect(progress.id).to eq 1
    expect(progress.finished).to eq true
    expect(progress.error).to be_nil
  end

  it 'failed job' do
    # when
    progress_id = expect { ExampleFailingJob.perform_later 1 }.to raise_error StandardError, 'expected error'
    # then
    progress = Progress.find progress_id
    expect(progress.id).to eq 1
    expect(progress.finished).to eq true
    expect(progress.error).to eq 'expected error'
  end
end
