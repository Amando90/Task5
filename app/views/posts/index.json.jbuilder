json.array!(@posts) do |post|
  json.extract! post, :id, :title, :caption
  json.url post_url(post, format: :json)
end
