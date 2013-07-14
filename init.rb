require 'redmine'

Rails.application.config.to_prepare do
	require_dependency 'issue'
	Issue.send(:include, LastUpdatedByIssuePatch) unless Issue.included_modules.include? LastUpdatedByIssuePatch

	require_dependency 'issue_query'
	IssueQuery.send(:include, LastUpdatedByIssueQueryPatch) unless IssueQuery.included_modules.include? LastUpdatedByIssueQueryPatch
end

Redmine::Plugin.register :redmine_last_updated_by_column do
	name 'Redmine Issue "Last Updated By" column'
	author 'Andrey Gavrikov'
	description 'Display Name of the user who last updated Issue in the Issue lists.'
	version '0.3.0'
	url 'https://github.com/neowit/redmine_last_updated_by_column'
	requires_redmine '2.3.0'


end

