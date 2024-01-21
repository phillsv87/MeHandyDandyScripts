#!/bin/bash
set -e

# Mac 12 ( Monterey )
# osascript -e '
# tell application "System Preferences"
#     activate
#     reveal pane id "com.apple.preference.displays"
#     delay 1
#     tell application "System Events" to click first pop up button of first window of application process "System Preferences" of application "System Events"
#     delay 1
#     tell application "System Events" to click menu item "ScottPad" of first menu of first pop up button of first window of application process "System Preferences" of application "System Events"
#     quit
# end tell';


# Mac 13 ( Ventura )
osascript -e '
on get_settings_list()
	tell application "System Settings"
		activate
		delay 1
	end tell
	tell application "System Events"
		tell application process "System Settings"
			set row_list to {}
			set row_num to 0
			tell outline 1 of scroll area 1 of group 1 of splitter group 1 of group 1 of window 1
				repeat with r in rows
					set row_num to row_num + 1
					if UI element 1 of r exists then
						tell UI element 1 of r
							repeat with x in UI elements
								if class of x is static text then
									set row_name to name of x as string
									set val to {row_name, row_num}
									copy val to end of row_list
								end if
							end repeat
						end tell
					end if
				end repeat
			end tell
		end tell
	end tell
	return row_list
end get_settings_list

on open_settings_to(settings_pane)
	if settings_pane = "Wi-Fi" then
		set settings_pane to "Wi-Fi"
	end if
	tell application "System Settings"
		activate
	end tell
	tell application "System Events"
		tell application process "System Settings"
			tell splitter group 1 of group 1 of window 1
				repeat until outline 1 of scroll area 1 of group 1 exists
					delay 0
				end repeat
				tell outline 1 of scroll area 1 of group 1
					set row_names to value of static text of UI element 1 of every row
					repeat with i from 1 to (count row_names)
						if settings_pane is not "Apple ID" then
							if item i of row_names = {settings_pane} then
								log item i of row_names & i
								select row i
								exit repeat
							end if
						else
							try
								if item 1 of item i of row_names contains settings_pane then
									select row i
									exit repeat
								end if
							end try
						end if
					end repeat
				end tell
			end tell
		end tell
	end tell
end open_settings_to

on sidecar_connection(ipad_name)
	tell application "System Events"
		tell application process "System Settings"
			tell splitter group 1 of group 1 of window 1
				tell pop up button 1 of group 1 of group 2
					click
					delay 0.5
					set add_display_items to name of menu items of menu 1 as list
					#set add_display_items to item 1 of add_display_items
					log add_display_items
					set sel_item to 0
					set section_break to 0
					repeat with i from 1 to number of items in add_display_items
						if item i of add_display_items = missing value then
							set section_break to i
							exit repeat
						end if
					end repeat
					if section_break = 0 then
						set section_break to 1
					end if
					repeat with i from section_break to number of items in add_display_items
						if item i of add_display_items = ipad_name then
							set sel_item to i
							log sel_item
							exit repeat
						end if
					end repeat
					click menu item sel_item of menu 1
					return sel_item
				end tell
			end tell
		end tell
	end tell
end sidecar_connection

on run {}
    open_settings_to("Displays")

    delay 1

    sidecar_connection("ScottPad")

	delay 5

    quit application "System Settings"
    
end run';
