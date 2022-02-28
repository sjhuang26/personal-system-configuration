function maintain_my_computer
read my_operation
switch $my_operation
case 'u':
sudo apt update
and sudo apt upgrade
and sudo snap refresh
case 'e':
cd ~/.emacs.d
and git pull
case 'r':
cd ~/r/personal_notes
and git add -A
and read_confirm
and git commit -m "w"
and git push
case 's':
cd ~/r/personal-system-configuration/
and git add -A
and read_confirm
and git commit -m "w"
and git push
end
end
