json.extract! video, :id, :title, :link, :published_at, :likes, :dislikes, :uid, :created_at, :updated_at
json.url video_url(video, format: :json)
