require 'rspec'
require 'sidekiq/testing'
require 'pry'
require_relative '../lib/user_worker'

Sidekiq::Testing.fake!

RSpec.describe UserWorker do
  before {Sidekiq::Worker.clear_all}

  it 'enquues the job' do
    expect {UserWorker.perform_async(10)}.to change(UserWorker.jobs, :size).by(1)
  end


  it 'calls the email service with correct user id' do
    # Stub class method
    expect(EmailService).to receive(:send_welcome_email).with(99)
    UserWorker.new.perform(99)

  end

  it 'mocks the email service and verifies interaction' do
    mock_email_service = class_double("EmailService").as_stubbed_const

    expect(mock_email_service).to receive(:send_welcome_email).with(123)

    UserWorker.new.perform(123)
  end

  it 'raises an error when user_id is nil' do
    # Optional job failure example
    allow(EmailService).to receive(:send_welcome_email).and_raise("Missing user")

    expect {
      UserWorker.new.perform(nil)
    }.to raise_error("Missing user")
  end
end