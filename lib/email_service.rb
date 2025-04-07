class EmailService
  def self.send_welcome_email(user_id)
    raise "Missing user" if user_id.nil? || user_id.to_s.strip.empty?
  end
end