# email_job.rb
class EmailJob
  attr_reader :recipient_email, :message, :status

  def initialize(recipient_email, message)
    @recipient_email = recipient_email
    @message = message
    @status = "pending"
  end

  def perform
    raise "Invalid email" if recipient_email.nil? || recipient_email.empty?
    
    # Simulate sending email
    @status = "sent"
  end
end
