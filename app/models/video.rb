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
    	self.description = channel.description
    	self.view_count = channel.view_count
  	rescue Yt::Errors::NoItems
  		self.link = 'please try again'
  	end
  	

end
