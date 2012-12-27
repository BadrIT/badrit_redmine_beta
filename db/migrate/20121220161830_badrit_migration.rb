class BadritMigration < ActiveRecord::Migration
  def up
    add_column :issues, :fixed_version_id, :integer
    add_column :issues, :assigned_to_id, :integer
    add_index "issues", ["assigned_to_id"], :name => "index_issues_on_assigned_to_id"
    add_index "versions", ["project_id"], :name => "versions_project_id"
    add_index "versions", ["sharing"], :name => "index_versions_on_sharing"

    billable_issue_cf = IssueCustomField.find_or_initialize_by_name('Billable')
    billable_issue_cf.update_attributes(
                              :field_format     => 'bool',
                              :is_required    => false,
                              :is_for_all     => true,
                              :is_filter  => true,
                              :default_value => '1')
    
    billable_issue_cf.trackers = Tracker.all
    billable_issue_cf.save


    billable_time_cf = TimeEntryCustomField.find_or_initialize_by_name('Billable')
    billable_time_cf.update_attributes(
      :field_format     => 'bool',
      :is_required    => false,
      :default_value => '1'
      )
  end

  def down
  end
end
