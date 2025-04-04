class BankAccount
  attr_reader :balance, :account_number

  def initialize(account_number, initial_balance = 0)
    @account_number = account_number
    @balance = initial_balance
  end

  def deposit(amount)
    raise 'Amount must be positive' if amount <= 0
    @balance += amount
  end

  def withdraw(amount)
    raise 'Insufficient funds' if amount > @balance
    @balance -= amount
  end

  def transfer(amount, recipient_account)
    raise 'Insufficient funds' if amount > @balance
    withdraw(amount)
    recipient_account.deposit(amount)
  end
end