class AddTopicArnToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :topic_arn, :string
  end
end
