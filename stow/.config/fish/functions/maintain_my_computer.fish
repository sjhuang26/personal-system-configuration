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
            and git add -A
            and git status
            and read_confirm
            and git commit -m "Work"
            and git push
            and git push origin-mirror
        case s
            cd ~/r/personal-system-configuration/
            and git add -A
            and git status
            and read_confirm
            and git commit -m "Work"
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
            and echo '/var/snap/opera/common/fontconfig/'
            and read_confirm
            and rm -vIr $opera_fontconfig
            and sudo trash /var/snap/opera/common/fontconfig/
        case opera-snap-fonts
            ln -s ~/.local/share/fonts ~/snap/opera/current/.local/share/fonts
        case g
            rclone mount g:/ ~/g &
        case b
            rclone mount b:/ ~/b --vfs-cache-mode minimal &
        case d
            rclone mount d:/ ~/d &
        case gs
            rclone sync -P g:/ ~/cloud/g-sjhuang26/
        case ds
            rclone sync -P d:/ ~/cloud/d-sjhuang26/
        case gu
            umount ~/g
        case bu
            umount ~/b
        case du
            umount ~/d
        case bupi
            bup -d ~/b/sjhuang26-main/bup/ index ~/cloud/
        case gdedup
            rclone dedupe g:/
        case pk
            pkill steam
            pkill itch
            pkill zoom
        case setup_everything_do_not_run
            echo 'This is only intended for use for new computers.'
            echo 'Do not run it directly. Copy and paste each line.'
            return

            read_confirm
            and git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
            and git config --global user.name "Suhao Jeffrey Huang"
            and git config --global user.email "sjhuang26@gmail.com"
            and mv ~/.config/lxqt/ ~/.config/lxqt~original/
            and mv ~/.config/qterminal.org ~/.config/qterminal.org~original/
            and mv ~/.emacs.d/ ~/.emacs.d~original/
            and mkdir ~/r/
            and cd ~/r/
            and git clone git@github.com:sjhuang26/personal_notes
            and git clone git@github.com:sjhuang26/personal-system-configuration
            and curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
            and curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
            and echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
            and sudo apt install stow spotify-client trash-cli nethogs
            and sudo snap install emacs opera
            and sudo chmod a+wr /usr/bin/spotify
            and sudo chmod a+wr /usr/share/spotify
            and sudo chmod a+wr /usr/share/spotify/Apps -R
        case bupindex
            bup -d ~/b/sjhuang26-main/bup/ index ~/cloud/ -vv
        case bupsave
            bup -d ~/b/sjhuang26-main/bup/ save ~/cloud/ -n sjhuang26-main -vv
        case src
            functions maintain_my_computer
        case edit
            nano ~/.config/fish/functions/maintain_my_computer.fish
        case chsh
            chsh -s "/usr/bin/fish"
        case bluetoothfix
            sudo rfkill block bluetooth
            sudo rfkill unblock bluetooth
            sudo systemctl restart bluetooth
        case randomgsettingsfix
            sudo apt install --reinstall gsettings-desktop-schemas
        case bs
            rclone sync ~/cloud b:sjhuang26-main-v2 -P
        case cool
            buckle -g 36 &
            cool-retro-term -p Futuristic &
        case coolstop
            pkill buckle
        case kdesave
            cd ~
            and konsave -e main
            and 7z x main.knsv -or/private-personal-system-configuration/kde
        case phonesync
            rclone bisync d:/samsung-a11/Obsidian/Main/ ~/r/personal_notes/Obsidian/ --resync --exclude="/.obsidian/**" -P
    end
end
