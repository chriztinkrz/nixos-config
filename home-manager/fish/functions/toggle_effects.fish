function toggle_effects --description 'Toggle between EasyEffects presets'
    set state_file "$HOME/.cache/easyeffects_toggle_state"

    if test -f $state_file; and test (cat $state_file) = "testing_-4"
        easyeffects --load-preset 'midbass_reduced_8'
        echo "midbass_reduced_8" > $state_file
        notify-send "EasyEffects" "midbass_reduced_8" -i audio-speakers
    else
        easyeffects --load-preset "testing_-4"
        echo "testing_-4" > $state_file
        notify-send "EasyEffects" "testing_-4" -i audio-speakers
    end
end
