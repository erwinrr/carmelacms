json.extract! department, :id, :name, :icon, :created_at, :updated_at
json.url organization_group_departments_path(department, format: :json)
