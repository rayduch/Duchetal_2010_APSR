data{
for(m in 1:Nctrl){
	phi[Np,m] <- 0
}
}
model{
for(i in 1:N){
lr[i] ~ dnorm(0,1)
ctrlmat[i,1] ~ dnorm(50,.1)
for (k in 2:(Nctrl-1)) {
     ctrlmat[i,k] ~ dcat(prob.mat[k, ])
}
vote[i] ~ dcat(p[i,])
		for (k in 1:Np) {
			for(m in 1:nc){
			z.dist[i,m,k] <- pow(lr[i] - z[m,k], 2)*gamma[m,k] 
			}
			strdist[i,k] <- sum(z.dist[i,1:nc,k])
			sindist[i,k] <- pow(lr[i] - plmat[k,1], 2) 
        log(q[i,k]) <- lambda*(beta[i]*strdist[i,k] + (1-beta[i])*sindist[i,k]) + inprod(ctrlmat[i, ], phi[k,])
		p[i,k] <- q[i,k]/(sum(q[i,]))
		}
}
for (m in 1:Nctrl) {
	for(l in 1:(Np-1)){
	phi[l,m] ~ dnorm(0, .01)
	}
}	
for (i in 1:N) {
	beta[i] ~ dbern(prob.beta)
}
prob.beta ~ dunif(0,1)
lambda ~ dnorm(0,.1)
}
