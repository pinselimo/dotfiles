#! /usr/bin/env fish
begin
    set time (date '+%H : %M : %S')
    set day  (date '+%A %d. %B %Y')

    echo -e "{\"text\":\""$time"\", \"alt\":\""$day"\", \"tooltip\":\""$day"\"}"
end
