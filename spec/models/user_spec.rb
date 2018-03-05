require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_name) { Faker::Internet.user_name }
  let(:password) { nil }
  let(:password_confirmation) { nil }
  let(:email) { Faker::Internet.email }
  subject { described_class.new(username: user_name, email: email, password: password, password_confirmation: password_confirmation) }

  describe 'validations' do
    context 'on a new user' do

      context 'with valid params' do
        let(:password) { 'abc456' }
        let(:password_confirmation) { 'abc456' }

        it 'should pass' do
          expect{ subject.save! }.not_to raise_error
        end
      end

      it 'should not be valid without a password' do
        expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid
      end

      context 'with a short passord' do
        let(:password) { 'foo' }
        let(:password_confirmation) { 'foo' }

        it 'should not be valid' do
          expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'with password mismatching password confirmation' do
        let(:password) { 'foo' }
        let(:password_confirmation) { 'bar' }

        it 'should not be valid' do
          expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'without email' do
        let(:email) { nil }
        it 'should not be valid' do
          expect{ subject.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
