json.array!(@messages) do |message|
  json.extract! message, :id, :senderid, :recvid, :mesg
  json.url message_url(message, format: :json)
end
