require 'rspec'
require_relative '../lib/user'

RSpec.describe User do
  let(:user) {User.new("aman", "aman@gmail.com")}
  let(:invalid_user) {User.new("a", "not-an-email")}

  describe '#valid_email?' do

    it 'return true for valid email' do
      expect(user.valid_email?).to be true 
    end

    it 'return false for invalid email' do
      expect(invalid_user.valid_email?).to be false
    end
  end
end