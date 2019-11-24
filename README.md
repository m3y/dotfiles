dotfiles
========

Overview
--------
My dotfiles

How to install
--------------

1. clone
```
$ git clone git@github.com:m3y/dotfiles.git
```

2. install
```
$ cat target_list # Show installation target
.bin
.tmux.conf

etc, etc

$ ./install
```

Check for differences
---------------------

```
$ cat target_list # Show difference check target
.bin
.tmux.conf

etc, etc

$ ./rcdiff
```
