#! /usr/bin/env fish
begin
    set query (busctl get-property --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 Visible)

    if [ "" != $query ]
	    echo -e "{\"text\":\"""\"}"
    else
	    echo -e "{\"text\":\"""\"}"
    end
end

