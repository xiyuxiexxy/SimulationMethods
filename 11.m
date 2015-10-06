#11.1a According to the Mendelian theory of genetics, a certain garden pea plant
#should produce white, pink, or red flowers, with respective probabilities
#1/4 1/2 1/4 To test this theory a sample of 564 peas was studied with the result
#that 141 produced white, 291 produced pink, and 132 produced red flowers.
#Approximate the p-value of this data set


Pk = [1/4 1/2 1/4];
Nk = [141 291 132];
N = 564;

Tk = (Nk- N*Pk).^2 ./(N*Pk);

T = sum(Tk);

K = length(Pk);
df = K-1;
p = 1- chi2cdf(T,df);

printf("t, df, p-value\n");
disp([T,df, p]);

##################
#t, df, p-value
#   0.86170   2.00000   0.64996 accept
###############################

#11.2a To ascertain whether a certain die was fair, 1000 rolls of the die were
#recorded, with the result that the numbers of times the die landed
#i, i = 1, 2, 3, 4, 5, 6 were, respectively, 158, 172, 164, 181, 160, 165.
#Approximate the p-value of the test that the die was fair
#(a) by using the chi-square approximation, and

Pk = [1/6 1/6 1/6 1/6 1/6 1/6];
Nk = [158 172 164 181 160 165];
N = sum(Nk);


Tk = (Nk- N*Pk).^2 ./(N*Pk);

T = sum(Tk);

K = length(Pk);
df = K-1;
p = 1- chi2cdf(T,df);

printf("t, df, p-value\n");
disp([T,df, p]);
######################################
#t, df, p-value
#   2.18000   5.00000   0.82372 accept
######################################

#4. Approximate the p-value of the hypothesis that the following data set of 14
#points is a sample from a uniform distribution over (50, 200):
#164, 142, 110, 153, 103, 52, 174, 88, 178, 184, 58, 62, 132, 128

function cdf = F(x)
	cdf = (x-50)/(200-50);
end 

Xs= [164, 142, 110, 153, 103, 52, 174, 88, 178, 184, 58, 62, 132, 128];
Xs = sort(Xs);
N= length(Xs);

Fx= F(Xs);
Fe= [1:N]/N;

D = max(max([Fe-Fx;Fx-(Fe-1/N)]))


I= zeros(500,1);
for i=1:500
	Us= rand(1,N);
	Us= sort(Us);
	I(i)= max(max([Fe-Us;Us-(Fe-1/N)]))>D;
end

p=mean(I)


##########################
# D =  0.13429
# p =  0.95400 accept
############################

#5. Approximate the p-value of the hypothesis that the following 13 data values
#come from an exponential distribution with mean 50:
#86, 133, 75, 22, 11, 144, 78, 122, 8, 146, 33, 41, 99


function Fx = cdf(x)
	Fx = 1- exp(-x/50);
end

Xs=[86, 133, 75, 22, 11, 144, 78, 122, 8, 146, 33, 41, 99];
Xs = sort(Xs);
N= length(Xs);

Fx= cdf(Xs);
Fe= [1:N]/N;

D = max(max([Fe-Fx,Fx-(Fe-1/N)]))



I= zeros(500,1);
for i=1:500
	Us= rand(1,N);
	Us= sort(Us);
	I(i)= max(max([Fe-Us;Us-(Fe-1/N)]))>D;
end

p=mean(I)


#############################
#D =  0.39225
#p =  0.032000 reject
#######################

#6. Approximate the p-value of the test that the following data come from a
#binomial distribution with parameters (8, p), where p is unknown:
#6, 7, 3, 4, 7, 3, 7, 2, 6, 3, 7, 8, 2 1, 3, 5, 8, 7

Xs= [6, 7, 3, 4, 7, 3, 7, 2, 6, 3, 7, 8, 2, 1, 3, 5, 8, 7];

n= 8;
p = mean(Xs)/n




function p= biomial(n,k,p)
	p = nchoosek(n,k)*(p^k)*((1-p)^(n-k));
end


Ps= zeros(9,1);
Ns = zeros(9,1);



for i = 1:9
	Ns(i)= length(find(Xs==i-1));
	Ps(i) = biomial(8,i-1,p);
end

Ps
Ts = (Ns- n*Ps).^2 ./(n*Ps);

T = sum(Ts)

K = length(Ps);
df = K-1;
p = 1- chi2cdf(T,df);

printf("t, df, p-value\n");
disp([T,df, p]);

#######################
#t, df, p-value
#   8.3373e+01   8.0000e+00   1.0214e-14 reject
#########################


#9. Let N1 , . . . , Nk have a multinomial distribution with parameters n,
#p1 , . . . , pk , i=1 pi = 1. With
#suppose we want to use simulation to estimate P(T > t). To reduce the
#variance of the estimator what might be used as a control variable?


# Nk_par = n*pk;
# use control variable Y = mean(Nk/pk)
# 

# simualte Nks 
# compute T and Y
# muY = n

# W = T + a*(Y-muY)
# a= - cov(T,Y)/var(Y)


#12. Fourteen cities, of roughly equal size, are chosen for a traffic safety study.
#Seven of them are randomly chosen, and in these cities a series of newspaper
#articles dealing with traffic safety are run over a 1-month period. The numbers
#of traffic accidents reported in the month following this campaign are as
#follows:
#Determine the exact p-value when testing the hypothesis that the articles have
#not had any effect.


Xs = [19 31 39 45 47 66 75];
Ys = [28 36 44 49 52 72 72]; 


Data= sort([Xs Ys]);

n= length(Xs);
m= length(Ys);


function r = rank(data, x)
	r = 1;
	while data(r)<x
		r= r+1;
	end
end

rankX= zeros(n,1);

for i = 1:n
	rankX(i)= rank(Data,Xs(i));

end
R = sum(rankX)


function p = recursiveP(n,m,r)
	if m<=0 	
		if r<=0 
			p= 0;
		else
			p= 1;
		end
		return;
	end
	if n<=0 
		if r<0 
			p= 1;		#I guess there is a typo here in the text book
		else
			p= 0;
		end
		return;
	else
		P1= recursiveP(n-1,m,r-n-m);
		P2 = recursiveP(n,m-1,r);
		p = (n/(n+m))*P1+(m/(n+m))*P2; 
	end
end
# p = recursiveP(n,m,R)
	
###################
# p =  0.69668
###########################

# Approximate the p-value in Exercise 12
# (a) by using the normal approximation, and

function p = normalApp(m,n,r)
	mu= n*(n+m+1)/2
	var= n*m*(n+m+1)/12;
	z = (r-mu)/(var^0.5);

	
	if r<= mu 
		p = 2*(1-normcdf(-z));  
	else
 		p = 2*(1-normcdf(z));  
	end
end

p= normalApp(m,n,R)

#####################
#p =  0.65472
#######################

# (b) by using a simulation.

function set = subset(x, r)
	n= length(x);
	
	for iter = 0: r-1
		
		ind = n-iter;
		j= floor(ind*rand(1))+1;
	
		tmp= x(j);
		x(j)=x(ind);
		x(ind)=tmp;
	
	end

	set = x(n-r+1:n);

end

X= 1:(n+m);
M = zeros(1000,1);
N= zeros(1000,1);

for i= 1:1000
	set= subset(X, n);
	rs= sum(set);
	if rs<= R
		M(i) =1;
	end
	if rs>=R
		N(i)=1;	
	end	 
end


p = 2*min(mean(M),mean(n))	
##############################
#p =  0.69000	
################################




