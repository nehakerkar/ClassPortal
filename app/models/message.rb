class Message < ActiveRecord::Base
    validates :senderid, :presence => true
    validates :recvid, :presence => true
    validates :mesg, :presence => true
end
