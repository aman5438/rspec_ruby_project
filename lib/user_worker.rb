require 'sidekiq'
require_relative './email_service'
class UserWorker
  include Sidekiq::Worker
  
  def perform(user_id)
    EmailService.send_welcome_email(user_id)
  end
end