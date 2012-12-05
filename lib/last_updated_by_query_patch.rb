module LastUpdatedByQueryPatch
	def self.included(base) # :nodoc:
		base.extend(ClassMethods)

		base.class_eval do
			unloadable # Send unloadable so it will not be unloaded in development
			base.add_available_column(QueryColumn.new(:last_updated_by_name,
				:caption => :label_last_updated_by,
				:sortable => "(select CONCAT_WS(' ', u.firstname, u.lastname) from #{Journal.table_name} as j1 inner join #{User.table_name} as u on u.id = j1.`user_id` where `journalized_type` = 'Issue' and `journalized_id` = #{Issue.table_name}.id order by j1.`id` DESC limit 1)"
			))
		end

	end

	module ClassMethods
		unless Query.respond_to?(:available_columns=)
			# Setter for +available_columns+ that isn't provided by the core.
			def available_columns=(v)
				self.available_columns = (v)
			end
		end

		unless Query.respond_to?(:add_available_column)
			# Method to add a column to the +available_columns+ that isn't provided by the core.
			def add_available_column(column)
				self.available_columns << (column)
			end
		end
	end
end
