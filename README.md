# first10min.sh
by darkmage
- x: https://x.com/evildojo666
- https://www.evildojo.com
- based on: https://blog.codelitt.com/my-first-10-minutes-on-a-server-primer-for-securing-ubuntu/

Usage:

```
./first10min.sh <username> <ssh_keyfile>
```

1. Spin up a brand new VPS.
2. Copy `first10min.sh` and your new user's ssh keyfile over: [How to set up an SSH key](https://www.google.com/search?q=set+up+an+ssh+key)
3. `ssh root@newvps`
4. `chmod +x first10min.sh`
5. `./first10min.sh darkmage darkmage_keyfile.pub`

There is no error checking at the moment.

After running the script, you'll have to deal with 3 prompts:

1. The prompt for a new root password.
2. The prompt for your new user's password.
3. The prompt to restart `ufw`.

There is some commented-out code that would install the `go` runtime if you decide you need certain tools, like [ProjectDiscovery's tool suite](https://github.com/projectdiscovery/).



