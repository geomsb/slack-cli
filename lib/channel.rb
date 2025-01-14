# channel's name, topic, member count, and Slack ID

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)

    @topic = topic
    @member_count = member_count
  end

  def self.list
    url = "https://slack.com/api/channels.list"
    query = {token: ENV['SLACK_TOKEN']}

    channels_list = []
    response = Recipient.get(url, query)
    response["channels"].each do |channel|
      new_channel = Channel.new(channel["id"], channel["name"], channel["topic"], channel["members"].length)
      # binding.pry 
      channels_list << new_channel
    end
    return channels_list
  end

  def details
    return {slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count}
  end

end
