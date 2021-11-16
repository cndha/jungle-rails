require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should create a new user if all validations are true' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.valid?
      expect(@user.errors.full_messages).not_to include("Field can't be blank")
    end

    it 'should not create a new user if password and password_confirmation does not match' do
      @user = User.new(password: "goongoon", password_confirmation: "buzzbuzz")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not create a new user if email is taken and should not be case-sensitive' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      @notherUser = User.new(name: "Violet", email: "VIOlet@GReen.com", password: "goongoon", password_confirmation: "goongoon")
      @notherUser.valid?
      expect(@notherUser.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not create a new user if password length is < 6 characters' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goon", password_confirmation: "goon")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
  
    it 'should login user if credentials are correct' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      expect(User.authenticate_with_credentials("violet@green.com", "goongoon")).to be_present
    end

    it 'should not authenticate user if email is incorrect' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      expect(User.authenticate_with_credentials("gossip@girl.com", "blairwaldrof")).not_to be_present
    end  
    
    it 'should not authenticate user if password is incorrect' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      expect(User.authenticate_with_credentials("violet@green.com", "blairwaldrof")).not_to be_present
    end

    it 'should login the authenticated user if the email contains whitespaces' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      expect(User.authenticate_with_credentials("   violet@green.com  ", "goongoon")).to be_present
    end

    it 'should login the authenticated user if the email has different casing' do
      @user = User.new(name: "Violet", email: "violet@green.com", password: "goongoon", password_confirmation: "goongoon")
      @user.save
      expect(User.authenticate_with_credentials("VIOlet@GReen.com", "goongoon")).to be_present
    end
  end

end
