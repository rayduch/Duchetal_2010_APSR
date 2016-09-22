model in mnl2.mod
data in mnldat.txt
parameters in mnlinits.txt
compile, nchains(2)
initialize
adapt 5000
update 50000
monitor prob.beta 
monitor lambda
monitor phi
monitor p
monitor vote
update 1250
coda *
exit
