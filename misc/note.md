- `kubectl api-resources` - get the api documentation, could be handy.
- nc -z -v -w <TIMEOUT SECONDS> <SERVICE-NAME> <PORT>
- `kubectl get pods --selector=job-name=pi` -  get pods under a job
- Labeling commands are very handy 
    - kubectl label pod pod-calc id=calc
    - kubectl get pod --show-labels
- Works only with bash not zsh
    - export do="--dry-run=client -o yaml"
    - kubectl run pod1 --image=nginx $do
- kubectl run pod1 \
    -oyaml \
    --dry-run=client \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run deploy1 \
    -oyaml \
    --dry-run \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"

-   # .vimrc
    set tabstop=2
    set expandtab
    set shiftwidth=2
- # basic vim stuff
    Mark lines: Esc+V (then arrow keys)
    Copy marked lines: y
    Cut marked lines: d
    Past lines: p or P
- kubectl run job1 \
    -oyaml \
    --dry-run \
    --restart=OnFailure \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run cj1 \
    -oyaml \
    --dry-run \
    --schedule="* * * * *" \
    --image=busybox \
    --requests "cpu=100m,memory=256Mi" \
    --limits "cpu=200m,memory=512Mi" \
    --command \
    -- sh -c "sleep 1d"
- kubectl run tmp --rm --image=busybox -it -- wget -O- google.com