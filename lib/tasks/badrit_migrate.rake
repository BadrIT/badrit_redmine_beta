desc 'BadrIT migration script'

namespace :redmine do
  task :badrit_migrate => :environment do
    ii=Issue.find_by_sql('select issue_id as id, user_id as assigned_to_id from issues_users')
    grouped_issues = ii.group_by(&:id)
    
    grouped_issues.each do |issue_id, issue_users|
      issue = Issue.find(issue_id)
      first_issue = issue_users.first

      issue.update_column(:assigned_to_id, first_issue.assigned_to_id)

      issue_users[1..-1].each do |issue_user|
        i = issue.copy
        i.assigned_to_id = issue_user.assigned_to_id
        begin
          i.save!
        rescue Exception => e
          puts "problem with issue #{issue.id} user #{issue_user.assigned_to_id}"
          raise e
        end
      end
    end


    puts "Updating time entries"

    TimeEntry.find_each(:batch_size=>1000) do |entry|
      entry_issue = entry.issue
      if entry_issue && entry_issue.assigned_to_id != entry.user_id
        issue = Issue.find_by_project_id_and_assigned_to_id_and_subject(entry.project_id, entry.user_id, entry_issue.subject)
        
        entry.update_column(:issue_id, issue.id) if issue
      end
    end

    puts "Updating issue actual hours"
    Issue.update_all(:actual_hours => 0)
    Issue.all.each{|i| i.update_actual_hours}


    puts "Updating billable issue"
    billable_issue_cf_id = IssueCustomField.find_by_name('Billable').id
    Issue.all.each do |issue|
      issue.custom_field_values = {billable_issue_cf_id => issue.billable}
      issue.save
    end

  end
end