json.extract! post, :id, :user_id, :picture_path, :post_text, :view_count, :created_at, :updated_at
json.url post_url(post, format: :json)
