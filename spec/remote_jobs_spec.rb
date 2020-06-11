require_relative '../lib/remote_jobs'

describe RemoteJobs do
  let(:jobs_success) { RemoteJobs.new('ruby') }
  let(:jobs_exception) { RemoteJobs.new('exception') }

  describe '#RemoteJobs.new' do
    it 'Tests a single sucessful language search' do
      expect(jobs_success.debug_message).to eq('Search complete')
    end

    it 'Tests a single language search that throws an exception' do
      expect(jobs_exception.debug_message).to eq('Exception catched')
    end
  end
end
