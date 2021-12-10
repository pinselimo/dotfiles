#! /usr/bin/env fish
begin
    set query (swaymsg -t get_inputs | grep 'xkb_active_layout_name' | awk -F: '{ print $2 }' | head -2 | tail -1)

    switch $query;
        case " \"German\","
            set layout " de "
        case " \"German (Bone)\","
            set layout "bone"
        case " \"German (Neo 2)\","
            set layout " neo"
    end

    echo -e "{\"text\":\""$layout"\"}"
end

