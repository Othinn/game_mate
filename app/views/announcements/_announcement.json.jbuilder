json.extract! announcement, :id, :title, :description, :city, :exp_date, :user_id, :group_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
