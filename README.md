# bash-scripting
Fun #!/bin/bash scripts!

## bananas.sh
Reverse shell script. 
* Makes possible 'sudo' access without password and for all users.
* Installs and configures an 'openssh-server' that listens on 22 port.
* Inserts a pre-generated RSA public key on authorized_keys which makes it us easy to log in via ssh without a password request.
* Establishes a bash tunnel (this won't have effect unless we're already listening)    

NOTE: atacker should have run on his computer the following command before send the file:
```bash
$ nc -l -v -p [PORT]
```

#### Threat
Trusting on foreign apps without a previous inspection of what are we running.

#### How to avoid it
Just by checking what we install and what does the .sh we run do. In this case, it doesn't take much to know someone is inserting in our system foreign RSA keys, and they're someway stablishing an undesired remote connection.

**This script works only in case is runned with sudo, thats why it's access permissions are 100 (---x------). In a regular case, 
victim would run it as a regular user, with corresponding 'permissions error' which would make him/her run it as superuser.**
