require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # Initialize a valid user
    subject {
      described_class.new(first_name: 'Sans', last_name: 'Person', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    }

    it 'should be a valid user' do
      expect(subject).to be_valid
    end

    it 'should not be valid without a password' do
      subject.password = nil
      subject.save
      expect(subject.errors.full_messages.include? "Password can't be blank").to be true
    end

    it 'should not be valid without a password_confirmation' do
      subject.password_confirmation = nil
      subject.save
      expect(subject.errors.full_messages.include? "Password confirmation can't be blank").to be true
    end

    it 'should not be valid when the password and password_confirmation are different' do
      subject.password_confirmation = 'notpassword'
      subject.save
      expect(subject.errors.full_messages.include? "Password confirmation doesn't match Password").to be true
    end

    it 'should not be valid if email is not unique, case independent' do
      User.destroy_all
      User.create!(first_name: 'timmy', last_name: 'test', email: 'timmy@test.com', password: 'password', password_confirmation: 'password')
      subject.email = 'TIMMY@TEST.com'
      subject.save
      expect(subject.errors.full_messages.include? "Email has already been taken").to be true
    end

    it 'should not be valid without an email' do
      subject.email = nil
      subject.save
      expect(subject.errors.full_messages.include? "Email can't be blank").to be true
    end

    it 'should not be valid without a first_name' do
      subject.first_name = nil
      subject.save
      expect(subject.errors.full_messages.include? "First name can't be blank").to be true
    end

    it 'should not be valid without a last_name' do
      subject.last_name = nil
      subject.save
      expect(subject.errors.full_messages.include? "Last name can't be blank").to be true
    end

    it 'should not be valid when the password is too short' do
      subject.password = '1234'
      subject.password_confirmation = '1234'
      subject.save
      expect(subject.errors.full_messages.include? "Password is too short (minimum is 8 characters)").to be true
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      User.destroy_all
      @user = User.create!(first_name: "Not", last_name: "Aperson", email: "test@test.com", password: "password", password_confirmation: "password")
    end

    it 'Should allow a user to login with valid credentials' do
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eql(@user)
    end

    it 'Should not allow a user to login with an invalid password' do
      expect(User.authenticate_with_credentials(@user.email, 'notpassword')).to eql(nil)
    end

    it 'Should not allow a user to login with an invalid password' do
      expect(User.authenticate_with_credentials('not@email.com', @user.password)).to eql(nil)
    end

    it 'Should allow a user to login if they have extra spaces on their email input' do
      expect(User.authenticate_with_credentials("  #{@user.email}  ", @user.password)).to eql(@user)
    end

    it 'Should allow a user to login if they type their email in wrong case' do
      expect(User.authenticate_with_credentials("TEst@teST.com", @user.password)).to eql(@user)
    end
  end
end
