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
        case g
            rclone mount g:/ ~/g &
        case b
            rclone mount b:/ ~/b --vfs-cache-mode minimal &
        case gs
            rclone sync -i g:/ ~/cloud/g-sjhuang26/
        case gu
            umount ~/g
        case bu
            umount ~/b
        case bupi
            bup -d ~/b/sjhuang26-main/bup/ index ~/cloud/
        case gdedup
            rclone dedupe g:/
        case pk
            pkill steam
            pkill itch
            pkill zoom
        case bupindex
            bup -d ~/b/sjhuang26-main/bup/ index ~/cloud/ -vv
        case bupsave
            bup -d ~/b/sjhuang26-main/bup/ save ~/cloud/ -n sjhuang26-main -vv
        case src
            functions maintain_my_computer
    end
end
