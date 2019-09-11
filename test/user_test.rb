require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "User" do
  before do
    slack_id = "1232452"
    name = "Dominique"
    real_name = "Dominique Taylor"
    @user = User.new(name, real_name, slack_id)
  end

  describe "User instantiation" do
    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end
  end

  describe "self.get" do
    it "gets response from server (JSON)" do
      VCR.use_cassette("user") do
        #Arrange
        url = "https://slack.com/api/users.list"
        query = {token: ENV['SLACK_TOKEN']}
        #Act
        response = User.get(url, query)

        #Assert
        expect(response).must_be_instance_of HTTParty::Response
      end
    end
  end
end