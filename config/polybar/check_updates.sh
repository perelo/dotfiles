updates=$(apt list --upgradable |wc -l)
printf "$updates"
