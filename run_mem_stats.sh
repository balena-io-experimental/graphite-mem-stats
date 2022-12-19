#!/bin/sh
# Clear memory and push memory statistics to Graphite every 60 seconds

while [ true ]; do
   # Drop clean caches, as well as reclaimable slab objects like dentries and inodes.
   # Use of 'sync' minimizes the number of dirty objects on the system and creates
   # more candidates to be dropped.
   # https://www.kernel.org/doc/Documentation/sysctl/vm.txt
   sync && echo 3 > /proc/sys/vm/drop_caches > /dev/null
   # Clear the swap memory cache and re-enable it.
   # https://www.redhat.com/sysadmin/clear-swap-linux
   swapoff -a && swapon -a

   ./push_mem_stats
   sleep 60
done
