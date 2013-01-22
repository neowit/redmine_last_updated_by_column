# Redmine "Last Updated By" (Last Modified By) plugin

Current version of Redmine has `Issue."Updated"` column which displays time of last Issue
update but does not display the name of who made that update.  
LastUpdatedBy plugin fixes that and adds "Updated By" column which shows user name in 
`<First Name> <Last Name>` form and can be displayed on:

- Issues list (as extra column)
- My page (as a separate component)

New "Updated By" column is not a real Database column, its value is generated on
the fly when Redmine renders Issues list. The column is sortable but not
groupable of filterable.

Note: on /issues page (for Issues without updates) "Updated By" is blank by
design.

## "My Page" Screenshots

"Updated By" Colour Legend:  
- Red - updated by author  
- Brown - updated by a 3rd person (neither author nor assignee)
- Black - updated by assignee


!["Tickets assigned to me"](https://github.com/neowit/redmine-last_updated_by_column/raw/master/Screenshots/My-Page-original.png)

![My Tickets with "Updated By"](https://github.com/neowit/redmine-last_updated_by_column/raw/master/Screenshots/My-Page-custom.png)

## Redmine version

Requires Redmine version 2.X. and Rails >= 3

## Installation

Copy last_updated_by_column folder into #{RAILS_ROOT}/plugins and restart the
web server.  Plugin does not change any data and no DB migration is required.

More details about Redmine plugin installation here: http://www.redmine.org/projects/redmine/wiki/Plugins

## Configuration

To display extra column on '/issues' list add "Updated By" column into
"Selected Columns" list.

To display extra column on "My Page" add block `'Issues assigned to me with "Updated By"'` 
via `"My Page" ->  "Personalise this page"`.

When using "My Page" component you can personalise highlight style.
See `last_updated_by_column/assets/stylesheets/last_updated_by_column.css`

## Legal stuff

Copyright (C) 2012 Andrey Gavrikov

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

