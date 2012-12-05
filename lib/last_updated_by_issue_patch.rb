module LastUpdatedByIssuePatch
	def self.included(base) # :nodoc:
		base.extend(ClassMethods)

		base.send(:include, InstanceMethods)

	end

	module ClassMethods
	end

	module InstanceMethods

		# add a column to the +available_columns+ that isn't provided by the core.
		# @param: no_default - if true then when Issue was created and has not have any updates then
		# instead of Creator name and Id we return nil
		# this is used in "Updated By" column on /issues page because we want
		# to show blank value, otherwise sort order looks weird
		def last_updated_by (no_default = false)
			_sql = "select CONCAT_WS(' ', u.firstname, u.lastname) as name, u.id as id from #{Journal.table_name} as j1 inner join #{User.table_name} as u on u.id = j1.`user_id` where `journalized_type` = 'Issue' and `journalized_id` = #{id} order by j1.`id` DESC limit 1"
			result = ActiveRecord::Base.connection.select_one _sql
			updated_by_name = ""
			updated_by_id = nil
			if !result.nil? 
				updated_by_id = result["id"].to_i
				updated_by_name = result["name"]
			elsif !no_default 
				updated_by_id = self.author.id
				updated_by_name = self.author.name
			end
			@last_updated_by ||= {:name => updated_by_name, :id => updated_by_id}
		end
		def last_updated_by_name
			@last_updated_by_name ||= self.last_updated_by(true)[:name]
		end

	end
end

