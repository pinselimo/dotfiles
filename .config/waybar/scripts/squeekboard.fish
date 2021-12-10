#! /usr/bin/env fish
begin
    set query (busctl get-property --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 Visible | awk -F' ' '{ print $2 }')

    switch $query;
        case "false"
            set show "true"
        case "true"
            set show "false"
    end

    exec busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b $show
end

