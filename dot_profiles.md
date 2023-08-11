.profile  
*    exec /QOpenSys/pkgs/bin/bash

.bashrc

*    export PATH=/QOpenSys/pkgs/bin:$PATH  


In the shell you need to:
>mkdir /home/USERID  
cd /home/USERID  
touch .profile  
echo "exec /QOpenSys/pkgs/bin/bash" > .profile  
touch .bashrc  
echo "export PATH=/QOpenSys/pkgs/bin:$PATH" > .bashrc  
