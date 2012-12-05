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
			_sql = "select CONCAT_WS(' ', u.firstname, u.lastname) as name, u.id as id from #{Journal.table_name} as j1 inner join #{User.table_name} as u on u.id = j1.`user_id` where `journalized_type` = 'Issue' and `journalized_id` = #{id} order by j1.`id` DESC limit 1"
			result = ActiveRecord::Base.connection.select_one _sql
			updated_by_name = ""
			updated_by_id = nil
			if result.nil?
				updated_by_name = self.author.name
				updated_by_id = self.author.id
				updated_by_name = self.author.name
			else
				updated_by_id = result["id"].to_i
				updated_by_name = result["name"]
			end
			@last_updated_by ||= {:name => updated_by_name, :id => updated_by_id}
		end
		def last_updated_by_name
			@last_updated_by_name ||= self.last_updated_by[:name]
		end

	end
end

