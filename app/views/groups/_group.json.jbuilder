json.extract! group, :id, :name, :created_at, :updated_at
json.url organization_group_url(@organization, group, format: :json)
