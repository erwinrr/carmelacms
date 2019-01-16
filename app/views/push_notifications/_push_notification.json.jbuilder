json.extract! push_notification, :id, :title, :message, :created_at, :updated_at
json.url push_notification_url(push_notification, format: :json)
