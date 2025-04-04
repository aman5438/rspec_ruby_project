require_relative '../lib/job'
require_relative '../lib/email_job'
require_relative '../lib/user'
require 'rspec'

RSpec.describe 'Background Job System' do
  let(:queue) {Job.new}
  let(:valid_user) {User.new("aman", "aman@gmail.com")}
  let(:invalid_user) {User.new("aman", "")}
  let(:email_job) {EmailJob.new(valid_user.email, "Welcome to our platform!")}

  describe EmailJob do
    it 'initialize correct email' do
      expect(email_job.recipient_email).to eq("aman@gmail.com")
      expect(email_job.message).to eq("Welcome to our platform!")
      expect(email_job.status).to eq("pending")
    end

    it 'process successfully' do
      email_job.perform
      expect(email_job.status).to eq("sent")
    end

    it 'raises an error if email is invalid' do
      invalid = EmailJob.new("", "test@gmail.com")
      expect { invalid.perform }.to raise_error("Invalid email") 
    end
  end

  describe Job do
    before do
      queue.add_job(email_job)
    end

    it 'adds jobs to the queue' do
      expect(queue.instance_variable_get(:@queue)).to include(email_job)
    end

    it 'process all job' do
      queue.process_jobs
      expect(email_job.status).to eq("sent")
      expect(queue.instance_variable_get(:@queue)).to be_empty
    end
  end

  describe User do
    it 'can send an email notification' do
      valid_user.send_email_notification(queue, "Hello!")
      expect(queue.instance_variable_get(:@queue).size).to eq(1)
    end

    it 'does not send email for invalid users' do
      expect {
        invalid_user.send_email_notification(queue, "Hello!")
      }.not_to raise_error # Just ensures no failure, but job might not work
    end
  end
end