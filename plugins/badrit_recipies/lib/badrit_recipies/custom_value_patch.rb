module BadritRecipies
  module CustomValuePatch
    
    def self.included(base)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        include InstanceMethods
        # after_update :update_time_entry_billable
        before_create :set_time_entry_billable_from_issue

      end 
      
    end
  end

  module InstanceMethods
    protected
    # when change issue to billable change all entries to billable and vice versa
    def update_time_entry_billable
      if self.customized_type == 'Issue' && self.custom_field.name == 'Billable' && self.value_changed?
        billable_time_cf_id = TimeEntryCustomField.find_or_initialize_by_name('Billable')

        # update all time entries to issue billable value
        self.customized.time_entries.each do |entry|
          CustomValue.update_all(["value = ?", self.value], ["customized_id = ? and customized_type = 'TimeEntry' and custom_field_id = ?", entry.id, billable_time_cf_id])

        end


      end
    end

    def set_time_entry_billable_from_issue
      if self.customized_type == 'TimeEntry' && self.custom_field.name == 'Billable'
        issue_billable_cf_id = IssueCustomField.find_or_initialize_by_name('Billable')

        issue = self.customized.issue
        issue_value = issue.custom_values.find_by_custom_field_id(issue_billable_cf_id)

        self.value = issue_value.value if issue_value
      end
    end

  end
end

  