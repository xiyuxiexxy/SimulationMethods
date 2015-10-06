#3. Write a program that uses the recursions given by Equations (8.6) and (8.7) to
#calculate the sample mean and sample variance of a data set.


function [X, S] = Stat(Data)
	n = length(Data);

	X = Data(1); 		# X1
	S2= 0; 			# S1
	
	for j = 1:n-1
		Xn =  X + (Data(j+1)-X)/(j+1);
		S2 =  (1- (1/j))*S2 +(j+1)*(Xn-X)^2 ;
		X = Xn;
	end

	S = S2^(0.5);
end

# [X,S]= Stat(1:10)

#mean(1:10)
#std(1:10)

##########################################################################################
#4. Continue to generate standard normal random variables until you have
# generated n of them, where n
# 100 is such that S/ n^0.5 < 0.1, where S
# is the sample standard deviation of the n data values.


function [X,S2, n] = update(X,S2,n)
	
	data = randn(1);
	
	Xn =  X + (data-X)/(n+1);
	S2 =  (1- (1/n))*S2 +(n+1)*(Xn-X)^2 ;
	X = Xn;
	
	n = n+1;
		

end
function [X, S,n] = Snorm()

	data = randn(100,1);
	X= mean(data);
	S= std(data);

	S2 = S^2 ;
	n = 100;

	while S2/n > 0.01
		[X, S2,n] =update(X, S,n);
	end
	
	# disp([X, S2^0.5,n]);
	S = S^0.5;
end

[X, S,n] =Snorm()
		

# How many normals do you think will be generated?
#	S/ n^0.5 < 0.1,
#	S=1	
#	n>100
	
# How many normals did you generate?
# What is the sample mean of all the normals generated?
# What is the sample variance?

#	X =  0.0014096
# 	S =  1.0227
# 	n =  105

# Comment on the results of (c) and (d). Were they surprising?
#  S is a little higher than 1, n is a little higher than expected accordingly. 

##########################################################
# 6.Generate at least 100
# values and stop when the standard deviation of your estimator is less than 0.01

# 

function [X, SD, n] =update(X, SD, n) 
	
	SD2 = SD^2;

	data = exp(rand(1)^2);  
	
	Xn =  X + (data-X)/(n+1);  # a new estimate n+1
		
	SD2 =  (1- (1/n))*SD2 +(n+1)*(Xn-X)^2 ;	   # the new sd2 of estimates		
				
		
	X = Xn;
	n = n+1;
	SD = SD2^0.5;

end
function [EX_,SDX_,n]  = Integral()
	
	estimate= zeros(100,1);
	
	U = rand(100,1);
	data = exp(U.^2);
	

	EX_ = mean(data);
	SD =  std(data)	 ;
	SDX_ = SD/10;

	disp([EX_,SDX_]);

	n = 100;
	while SDX_ >0.01

		[EX_, SD, n] = update(EX_,SD,n);
		SDX_ =  SD/(n)^0.5;
		
	end

end

 [EX_,SDX_,n] =Integral()

###############################
# EX_ =  1.4502
# SDX_ =  0.0099965
# n =  2222
##############################
# 7. To estimate E[X ], X 1 , . . . , X 16 have been simulated with the following values
# resulting: 10, 11, 10.5, 11.5, 14, 8, 13, 6, 15, 10, 11.5, 10.5, 12, 8, 16, 5. Based
# on these data, if we want the standard deviation of the estimator of E[X ] to be
# less than 0.1, roughly how many additional simulation runs will be needed?

Xs =  [10, 11, 10.5, 11.5, 14, 8, 13, 6, 15, 10, 11.5, 10.5, 12, 8, 16, 5 ];
X_ = mean(Xs) ;
SD = std(Xs) ;

# suppose 
#X_ =  10.750 
#SD =  3.0111  
# are unbiased estimate for mu and sigma

#SDX_ = SD/(n^0.5) <0.1
# n >  906.67 = 907
# so additioal simulation runs is roughly 907-16 =891

####################################################################################

# 8. It can be shown that if we add random numbers until their sum exceeds 1, then
#the expected number added is equal to e. That is, if

#(a) Use this preceding to estimate e, using 1000 simulation runs.
#(b) Estimate the variance of the estimator in (a) and give a 95 percent
#confidence interval estimate of e.


function n = nsum()

	u = rand(1);
	n = 1;

	while u<=1
		u= u+ rand(1);
		n= n+1;
	end
end


function [EN,sdx_,sd] = estimate(K)

	Ns = zeros(K,1);
	for iter = 1:K
		Ns(iter) = nsum();
	end

	EN = mean(Ns);

	sd = std(Ns);
	sdx_ = sd/(K^0.5);
end

 [EN,sdx_,sd] = estimate(1000)

##################################
# EN =  2.7370
# sdx_ =  0.028786
# sd =  0.91031

# EN+/-1.96*sd/n^0.5
# 2.7082~ 2.7658
################################
# 9. Consider a sequence of random numbers and let M denote the first one that is
# less than its predecessor. That is,
# Use part (b) to estimate e, using 1000 simulation runs.
# Estimate the variance of the estimator in (c) and give a 95 percent
# confidence interval estimate of e.

function n = minless()
	u1 = rand(1);
	u2 = rand(1);
	n = 2;
	while  u1<u2
		u1 = u2;
		u2 =rand(1);
		n = n+1;
	end
end

function ee = simulation(K)	

	Ms=  zeros(K,1);
	for iter= 1:K
		Ms(iter)= minless();
	end

	
	N = max(Ms)
	ee = 0;

	for n= 0:N
		ee =ee+ length(find(Ms>n))/K; 
	end
	

end

ee = simulation(1000)
##########################
# ee =  2.7200
#####################

# 13. Let X 1 , . . . , X n be independent and identically distributed random variables
#having unknown mean μ. For given constants a < b, we are interested in n
# estimating p = P{a < i=1 X i /n − μ < b}.
#(a) Explain how we can use the bootstrap approach to estimate p.
#(b) Estimate p if n = 10 and the values of the X i are 56, 101, 78, 67, 93, 87,
#64, 72, 80, and 69. Take a = −5, b = 5.
#In the following three exercises X 1 , . . . , X n is a sample from a distribution
#whose variance is (the unknown) σ 2 . We are planning to estimate σ 2 by the
#n
#sample variance S 2 = i=1 (X i −X )2 /(n−1), and we want to use the bootstrap
#technique to estimate Var(S 2 ).




function p = bootStrap(Xs,R,a,b)

	n = length(Xs);
	mu = mean(Xs);

	Ps = zeros(R,1);
	for b = 1:R 
		Xb = Xs(floor(n*rand(n,1))+1);
		error = mean(Xb)-mu;
		if error > a && error < b
			Ps(b) = 1;
		end
	end
	p = mean(Ps);
end	


Xs= [56, 101, 78, 67, 93, 87,64, 72, 80, 69];
a = -5;
b= 5 ;
p = bootStrap(Xs,1000,a,b)

###############################
# p =  0.89600
############################


# 14. If n = 2 and X 1 = 1 and X 2 = 3, what is the bootstrap estimate of Var(S^2 )?
#15. If n = 15 and the data are
# 5, 4, 9, 6, 21, 17, 11, 20, 7, 10, 21, 15, 13, 16, 8
# approximate (by a simulation) the bootstrap estimate of Var(S 2 ).


function VS2 = bootStrapVS2(Xs,R)
	n = length(Xs);
	S2_ = std(Xs)^2;
	
	VS2 = 0;
	for b = 1:R 
		Xb = Xs(floor(n*rand(n,1))+1);
		S2 = std(Xb)^2;
		VS2 = VS2 + ((S2 -S2_)^2-VS2)/b;
	end

end

Xs14 = [1,3];
VS2_14 = bootStrapVS2(Xs14,1000)
#			
# VS2_14 =  1.9400

Xs15 = 	[5, 4, 9, 6, 21, 17, 11, 20, 7, 10, 21, 15, 13, 16, 8];
VS2_15 = bootStrapVS2(Xs15,1000)

# VS2_15 =  61.676	








