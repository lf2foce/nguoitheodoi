class Video < ApplicationRecord
  validates :link, presence: true
	before_save :resource
  
  	private
  	#def resource
    #	video = Yt::Video.new url: self.link
    #	self.uid = video.id
    #	self.title = video.title
    #	self.likes = video.like_count
    #	self.dislikes = video.dislike_count
    #	self.published_at = video.published_at
  	#rescue Yt::Errors::NoItems
  	#	self.title = ''
  	#end

  	def resource
    	channel = Yt::Channel.new id: self.link.gsub("https://www.youtube.com/channel/","")
    	self.uid = channel.thumbnail_url
    	self.title = channel.title
    	self.likes = channel.videos.count
    	self.dislikes = channel.subscriber_count
    	self.published_at = channel.published_at
  	rescue Yt::Errors::NoItems
  		self.link = 'please try again'
  	end
  	
  	def refresh(channel_link)
    	resource = Yt::Channel.new id: channel_link.link.gsub("https://www.youtube.com/channel/","")
    	channel_link.uid = resource.thumbnail_url
    	channel_link.title = resource.title
    	channel_link.likes = resource.videos.count
    	channel_link.dislikes = resource.subscriber_count
    	channel_link.published_at = resource.published_at
  	rescue Yt::Errors::NoItems
  		channel_link.link = 'check'
  	end
end
