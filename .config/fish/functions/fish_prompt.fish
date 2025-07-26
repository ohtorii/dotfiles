function fish_prompt --description 'Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                         and set_color $fish_color_cwd_root
                                                         or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus " [" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
        set -l display_date [(date "+%H:%M:%S")]
        set -l diplay_dir $PWD (fish_vcs_prompt)
        set -l display_duration '⏱️'(__bobthefish_cmd_duration)
        
        printf '🐟%s %s%s%s %s%s%s%s\n> ' $display_date \
            (set_color $fish_color_cwd)$PWD (fish_vcs_prompt) $pipestatus_string \
            (set_color -d)$display_duration \
            (set_color normal)
    end
end


# right_prompt
function __bobthefish_cmd_duration -S -d 'Show command duration'
    #[ "$theme_display_date" = "no" ]
    #or echo -ns ' ' $__bobthefish_left_arrow_glyph

    #[ "$theme_display_cmd_duration" = "no" ]
    #and return

    [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]
    and return

    if [ "$CMD_DURATION" -lt 5000 ]
        echo -ns $CMD_DURATION 'ms'
    else if [ "$CMD_DURATION" -lt 60000 ]
        __bobthefish_pretty_ms $CMD_DURATION s
    else if [ "$CMD_DURATION" -lt 3600000 ]
        set_color $fish_color_error
        __bobthefish_pretty_ms $CMD_DURATION m
    else
        set_color $fish_color_error
        __bobthefish_pretty_ms $CMD_DURATION h
    end

    set_color $fish_color_normal
    set_color $fish_color_autosuggestion
end

function __bobthefish_pretty_ms -S -a ms -a interval -d 'Millisecond formatting for humans'
    set -l interval_ms
    set -l scale 1

    switch $interval
        case s
            set interval_ms 1000
        case m
            set interval_ms 60000
        case h
            set interval_ms 3600000
            set scale 2
    end

    switch $FISH_VERSION
        case 2.0.\* 2.1.\* 2.2.\* 2.3.\*
            # Fish 2.3 and lower doesn't know about the -s argument to math.
            math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case 2.\*
            # Fish 2.x always returned a float when given the -s argument.
            math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case \*
            math -s$scale "$ms/$interval_ms"
            echo -ns $interval
    end
end
