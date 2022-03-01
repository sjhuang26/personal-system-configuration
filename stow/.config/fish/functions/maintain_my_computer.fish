function maintain_my_computer
    read my_operation
    switch $my_operation
        case u
            sudo apt update
            and sudo apt upgrade
            and sudo snap refresh
        case e
            cd ~/.emacs.d
            and git pull
        case r
            cd ~/r/personal_notes
            and git add -A; and git status
            and read_confirm
            and git commit -m w
            and git push
        case s
            cd ~/r/personal-system-configuration/
            and git add -A; and git status
            and read_confirm
            and git commit -m w
            and git push
        case bc
            bluetoothctl connect 00:02:5B:04:7B:30
        case bd
            bluetoothctl disconnect 00:02:5B:04:7B:30
        case of
            # opera font fix
            set opera_fontconfig (find ~/snap/opera -name 'fontconfig')
            and echo 'These directories will be removed'
            and echo $opera_fontconfig
            and read_confirm
            and rm -vIr $opera_fontconfig
    end
end
