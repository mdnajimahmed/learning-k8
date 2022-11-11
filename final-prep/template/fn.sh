alias k=kubectl
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace     $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f    '
export do="--dry-run=client -o yaml"
export tmpb="run tmpb --image=busybox --rm --restart=Never --stdin -it"
export rc="$tmp -- wget -O- "
export tmpa="run tmp --image=alpine --rm --restart=Never --stdin -it"
export now="--force --grace-period 0" 

# make sure it runs ib bash not zsh or any other nonsense.