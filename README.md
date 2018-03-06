# bash-scripting
Fun #!/bin/bash scripts!

## bananas.sh
Reverse shell script. Installs openssh-server and opens a tunnel to our IP addr. Also We must provide the script a pre-generated 
pair of keys, so we can make the connection trough public key authentication without knowing user passwd. Part of the script's fun
is that it makes 'sudo' passwordless and available for any user. This way, even login as a guest we could use sudo powers!
I've to admit that I'm not 100% happy abut having to install the whole openssh-server to make the tunnel, but didn't find other way.

NOTE: once tunnel stablished, atacker may run on his computer following command:
```sh
$ ssh localhost -p [remote port setted on script]
```
