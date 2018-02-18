# app/validators/base_search_filter_validator.rb
require 'rails_helper'

RSpec.describe BaseSearchFilterValidator do
  subject { described_class.new }

  describe "#initialize" do
    it "should initialize error_messages with an empty array" do
      expect(subject.error_messages).to eq([])
    end
  end

  describe "#add_error" do
    it "should add error message to error_messages array" do
      # bypassing encapsulations since add_error is a protected method
      subject.send(:add_error, "Error message")
      expect(subject.error_messages.size).to eq(1)
      expect(subject.error_messages[0]).to eq("Error message")
    end
  end
end
