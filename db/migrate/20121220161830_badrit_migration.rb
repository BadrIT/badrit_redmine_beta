class BadritMigration < ActiveRecord::Migration
  def up
    add_column :issues, :fixed_version_id, :integer
    add_column :issues, :assigned_to_id, :integer
    add_index "issues", ["assigned_to_id"], :name => "index_issues_on_assigned_to_id"
    add_index "versions", ["project_id"], :name => "versions_project_id"
    add_index "versions", ["sharing"], :name => "index_versions_on_sharing"
  end

  def down
  end
end
