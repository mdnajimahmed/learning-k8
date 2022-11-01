- kubectl run fe --labels=tier=frontend --image=ubuntu --restart=Never -it --rm  -- sh
    - apt-get update && apt-get install -y netcat
# Port Scanning
- nc -v -n -z -w 1 10.244.205.244 3306
    - v : verbose - shows message(success/error)
    - n : no dns lookup
    - z : makes nc not receive any data from the server
    - w : wait timeout