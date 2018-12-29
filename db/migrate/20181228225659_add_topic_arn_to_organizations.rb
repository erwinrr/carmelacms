class AddTopicArnToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :topic_arn, :string
  end
end
