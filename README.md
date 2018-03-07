# bash-scripting
Fun #!/bin/bash scripts!

## bananas.sh
Reverse shell script. Installs openssh-server and opens a tunnel to our IP addr. Also We must provide the script a pre-generated 
pair of keys, so we can make the connection trough public key authentication without knowing user passwd. Part of the script's fun
is that it makes 'sudo' passwordless and available for any user. This way, even login as a guest we could use sudo powers!
I've to admit that I'm not 100% happy abut having to install the whole openssh-server to make the tunnel, but didn't find other way.

NOTE: once tunnel stablished, atacker may run on his computer following command:
```sh
$ ssh localhost -p [remote_port_setted_on_script] -i [path_to_private_rsa_key]
```

#### Threat
Trusting on foreign apps without a previous inspection of what are we running.

#### How to avoid it
Just by checking what we install and what does the .sh we run do. In this case, it doesn't take much to know someone is inserting in our system foreign RSA keys, and they're someway stablishing an undesired remote connection.

**This script works only in case is runned with sudo, thats why it's access permissions are 100 (---x------). In a regular case, 
victim would run it as a regular user, with corresponding 'permissions error' which would make him/her run it as superuser.**
