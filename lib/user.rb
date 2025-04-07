# user.rb
class User
  attr_reader :email, :name

  def initialize(name, email)
    @name = name
    @email = email
  end

  def send_email_notification(job_queue, message)
    job = EmailJob.new(email, message)
    job_queue.add_job(job)
  end

  def valid_email?
    !!(email =~ /\A[^@\s]+@[^@\s]+\z/)
  end 
end
