module LastUpdatedByIssuePatch
	def self.included(base) # :nodoc:
		base.extend(ClassMethods)

		base.send(:include, InstanceMethods)



	end

	module ClassMethods
	end

	module InstanceMethods

		# add a column to the +available_columns+ that isn't provided by the core.
		def last_updated_by
			_sql = "select CONCAT_WS(' ', u.firstname, u.lastname) from `journals` as j1 inner join users as u on u.id = j1.`user_id` where `journalized_type` = 'Issue' and `journalized_id` = #{id} order by j1.`id` DESC limit 1"
			result = ActiveRecord::Base.connection.select_value _sql
			unless result.nil?
				@last_modified_by ||= result
			end
		end
	end
end

