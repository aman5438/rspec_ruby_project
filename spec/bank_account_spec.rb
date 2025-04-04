require_relative '../lib/bank_account'
require 'rspec'

RSpec.describe BankAccount do
  let(:account) { BankAccount.new(12345, 100) }
  let(:recipient_account) { BankAccount.new(789456, 50) }

  describe '#initialize' do
    it 'sets the initial balance correctly ' do
      expect(account.balance).to eq(100)
    end

    it 'sets the account number correctly' do
      expect(account.account_number).to eq(12345)
    end
  end

  describe '#deposit' do
    it 'increase the balance in the deposit amount' do
      account.deposit(50)
      expect(account.balance).to eq(150)
    end

    it 'raise an error for negative deposit' do
      expect { account.deposit(-10).to raise_error('Amount must be positive')}
    end
  end

  describe '#withdraw' do
    it 'decrease balance by the withdrawn amount' do
      account.withdraw(50)
      expect(account.balance).to eq(50)
    end

    it 'raise an error  if funds are insfficient' do
      expect { account.withdraw(200).to raise_error('Insufficient funds')}
    end
  end

  describe '#transfer' do
    it 'transfer money from one account to another account' do
      account.transfer(100, recipient_account)
      expect(account.balance).to eq(0)
      expect(recipient_account.balance).to eq(150)
    end

    it 'raises an error if funds are insufficient' do
      expect { account.transfer(200, recipient_account) }.to raise_error('Insufficient funds')
    end
  end
end