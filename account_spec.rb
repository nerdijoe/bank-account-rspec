require "rspec"

require_relative "account"

describe Account do

  let(:acct_number) { '1234567890' }
  let(:starting_balance) { 1000 }
  let(:account) { Account.new(acct_number, starting_balance)}

  describe "#initialize" do
    context "with valid input" do
      it "create a new Account" do
        acct_number = '1234567890'
        starting_balance = 1000
        expect(Account.new(acct_number, starting_balance)).to be_a_kind_of(Account)
      end
    end

    context "with invalid acct_number argument" do
      it "throws an argument error" do
        acct_number = '123'
        starting_balance = 1000
        expect {Account.new(acct_number, starting_balance)}.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    it "returns the transactions history" do
      expect(account.transactions).to be_a_kind_of(Array)
    end
  end

  describe "#balance" do
    it "returns the account balance" do
      expect(account.balance).to eql(1000)
    end
  end

  describe "#account_number" do
    it "returns the censored user account number" do
      expect(account.acct_number).to eql("******7890")
    end
  end

  describe "deposit!" do
    context "amount > 0" do
      it "returns the updated balance" do
        amount = 1000
        expect(account.deposit!(amount)).to eql(2000)
      end
    end

    context "amount < 0" do
      it "throws the error" do
        amount = -1000
        expect { account.deposit!(amount) }.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context "amount > 0" do
      it "deducts the amount from account balance" do
        amount = 100
        expect(account.withdraw!(amount)).to eql(900)
      end
    end

    context "amount > balance" do
      it "throws OverdraftError" do
        amount = 1200
        expect {account.withdraw!(amount)}.to raise_error(OverdraftError)
      end
    end
  end
end
