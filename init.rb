require 'redmine'

Rails.application.config.to_prepare do
	require_dependency 'issue'
	Issue.send(:include, LastUpdatedByIssuePatch) unless Issue.included_modules.include? LastUpdatedByIssuePatch

	require_dependency 'query'
	Query.send(:include, LastUpdatedByQueryPatch) unless Query.included_modules.include? LastUpdatedByQueryPatch
end

Redmine::Plugin.register :last_updated_by_column do
	name 'Redmine Issue "Last Updated By" column'
	author 'Andrey Gavrikov'
	description 'Display Name of the user who last updated Issue in the Issue lists.'
	version '0.1'
	url 'https://github.com/neowit/redmine-last_updated_by_column'
	requires_redmine '2.1.0'


end

