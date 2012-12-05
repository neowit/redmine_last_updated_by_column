module LastUpdatedByQueryPatch
	def self.included(base) # :nodoc:
		base.extend(ClassMethods)

		base.class_eval do
			unloadable # Send unloadable so it will not be unloaded in development
			#_sql = "select CASE WHEN u.id = null THEN CONCAT_WS(' ', a.firstname, a.lastname) ELSE CONCAT_WS(' ', u.firstname, u.lastname) END from #{Issue.table_name} as i"
			#_sql << " left join #{Journal.table_name} as j on j.journalized_id = i.id and journalized_type = 'Issue' "
			#_sql << " left join #{User.table_name} as u on u.id = j.user_id"
			#_sql <<	" left join #{User.table_name} as a on a.id = i.author_id"
			#_sql << " where  i.id = #{Issue.table_name}.id order by j.id DESC limit 1"

			_sql = "( select lastmodifiedby_name from ( "
			_sql << " (select CONCAT_WS(' ', u.firstname, u.lastname) lastmodifiedby from #{Journal.table_name} as j1 inner join #{User.table_name} as u on u.id = j1.user_id where journalized_type = 'Issue' and journalized_id = #{Issue.table_name}.id order by j1.id DESC limit 1)"
			_sql << " union "
			_sql << " (select CONCAT_WS(' ', u.firstname, u.lastname) as lastmodifiedby_name from #{User.table_name} u where id = #{Issue.table_name}.author_id) "
			_sql << " ) as lastmodifiedby limit 1 )"

			base.add_available_column(QueryColumn.new(:last_updated_by_name,
				:caption => :label_last_updated_by,
				:sortable => _sql
				#:sortable => "(select CONCAT_WS(' ', u.firstname, u.lastname) from #{Journal.table_name} as j1 inner join #{User.table_name} as u on u.id = j1.user_id where journalized_type = 'Issue' and journalized_id = #{Issue.table_name}.id order by j1.id DESC limit 1)"
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
