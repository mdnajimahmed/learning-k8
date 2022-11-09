alias k=kubectl
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
export do="--dry-run=client -o yaml"
export tmp="run tmp --rm --image=busybox --restart=Never --stdin -it"
export rc="$tmp -- wget -O- "
