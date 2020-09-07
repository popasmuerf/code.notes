mrblack@pop-os:~/utils$ curl -fsS https://dlang.org/install.sh | bash -s ldc
Downloading https://dlang.org/d-keyring.gpg
######################################################################## 100.0%
Downloading https://dlang.org/install.sh
######################################################################## 100.0%
gpg: keybox '/home/mrblack/.gnupg/pubring.kbx' created
gpg: /home/mrblack/.gnupg/trustdb.gpg: trustdb created
The latest version of this script was installed as ~/dlang/install.sh.
It can be used it to install further D compilers.
Run `~/dlang/install.sh --help` for usage information.

Downloading and unpacking https://github.com/ldc-developers/ldc/releases/download/v1.23.0/ldc2-1.23.0-linux-x86_64.tar.xz
######################################################################## 100.0%######################################################################### 100.0%
Using dub 1.22.0 shipped with ldc-1.23.0

Run `source ~/dlang/ldc-1.23.0/activate` in your shell to use ldc-1.23.0.
This will setup PATH, LIBRARY_PATH, LD_LIBRARY_PATH, DMD, DC, and PS1.
Run `deactivate` later on to restore your environment.
mrblack@pop-os:~/utils$ curl -fsS https://dlang.org/install.sh | bash -s dmd
Downloading and unpacking http://downloads.dlang.org/releases/2.x/2.093.1/dmd.2.093.1.linux.tar.xz
curl: (28) Resolving timed out after 5000 milliseconds #                      

Falling back to mirror: http://ftp.digitalmars.com/dmd.2.093.1.linux.tar.xz
######################################################################## 100.0%
Using dub 1.22.0 shipped with dmd-2.093.1

Run `source ~/dlang/dmd-2.093.1/activate` in your shell to use dmd-2.093.1.
This will setup PATH, LIBRARY_PATH, LD_LIBRARY_PATH, DMD, DC, and PS1.
Run `deactivate` later on to restore your environment.
mrblack@pop-os:~/utils$ curl -fsS https://dlang.org/install.sh | bash -s gdc
Downloading and unpacking https://gdcproject.org/downloads/binaries/x86_64-linux-gnu/gdc-4.8.5.tar.xz
######################################################################## 100.0%-######################################################################## 100.0%
Downloading gdmd https://raw.githubusercontent.com/D-Programming-GDC/GDMD/a67179d54611ae8cfb1d791cf7ab8e36c3224b76/dmd-script
######################################################################## 100.0%
Downloading and unpacking https://github.com/dlang/dub/releases/download/v1.22.0/dub-v1.22.0-linux-x86_64.tar.gz
######################################################################## 100.0%

Run `source ~/dlang/gdc-4.8.5/activate` in your shell to use gdc-4.8.5.
This will setup PATH, LIBRARY_PATH, LD_LIBRARY_PATH, DMD, DC, and PS1.
Run `deactivate` later on to restore your environment.

