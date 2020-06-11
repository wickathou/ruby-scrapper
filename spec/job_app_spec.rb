require_relative '../lib/job_app'

describe JobApp do
  let(:app) { JobApp.new('testing') }

  describe '#JobApp.new' do
    it 'Test a complete search of jobs for one language' do
      expect(app.debug_message).to eq('Thank you for using Job App')
    end
  end
end
