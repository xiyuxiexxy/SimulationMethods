# 1. Suppose we wanted to estimate θ , where
# Show that generating a random number U and then using the estimator
# eU (1 + e1−2U )/2 is better than generating two random numbers U1 and
# U2 and using [ exp(U1 ) + exp(U2 )]/2.


function X = ha(U)
	U2 = 1-U;
	X= hmc(U,U2);
	#X = exp(U.^2).*(1+ exp((1-2*U).^2))/2;
end

function X = hmc(U1,U2)
	X = (exp(U1.^2)+ exp(U2.^2))/2;
end



function compare(K)
	U = rand(K,1);
	Xa = ha(U);
	
	
	U1 = rand(K,1);
	U2 = rand(K,1);
	Xmc = hmc(U1,U2);

	disp ([mean(Xa), std(Xa), std(Xa)/(K^0.5)]);
	disp ([mean(Xmc), std(Xmc), std(Xmc)/(K^0.5)]);
end

 compare(100);

######################################
# Xa      1.424845   0.151137   0.015114
# Xmc   1.442171   0.342632   0.034263
# Xa is better
###########################################
# 2. Explain how antithetic variables can be used in obtaining a simulation
# estimate of the quantity
# Is it clear in this case that using antithetic variables is more efficient than
# generating a new pair of random numbers?


function X = ha2(U)
	U2 = 2-U;
	X = hmc2(U,U2);
	
	# X = exp(U.^2).*(1+ exp((4-4*U).^2))/2;
end


function X = hmc2(U1,U2)
	X = (exp(U1.^2)+ exp(U2.^2))/2;
end



function compare2(K)
	x = rand(K,1);
	y = rand(K,1);
	U = x+y;

	Xa = ha2(U);
	
	
	x1 = rand(K,1);
	y1 = rand(K,1);
	U1= x1+y1;

	x2 = rand(K,1);
	y2 = rand(K,1);	
	U2 = x2+y2;

	Xmc = hmc2(U1,U2);

	disp ([mean(Xa), std(Xa), std(Xa)/(K^0.5)]);
	disp ([mean(Xmc), std(Xmc), std(Xmc)/(K^0.5)]);
end

# compare2(100);
###########################
#   5.10348   3.74901   0.37490
#   5.61687   4.83684   0.48368
# Xa is better
####################################

function X = ep(lamda, U)
	X = -lamda.*log(U);
end		

function ps = h(X)
		
	l = length(X)/5;

	ps = zeros(l,1);
	

	for i = 0:l-1

		sum= 0;
		for j = 1: 5
			sum= sum+ j*X(i*5+j);
		end	

		if sum >=21.6
			ps(i+1) =1;
		end
	end
	length(find(ps==1))
end

function AV(K)

	U= rand(5*K,1);

	X1a = ep(1, U);
	X2a = ep(1, 1-U);

	Xa = [X1a;X2a];
	ps = h(Xa);


	U1= rand(5*K,1);
	U2= rand(5*K,1);

	X1mc = ep(1, U1);
	X2mc = ep(1, U2);

	Xmc = [X1mc;X2mc];

	psmc = h(Xmc);
	
	disp ([mean(ps), std(ps), std(ps)/((2*K)^0.5)]);
	disp ([mean(psmc), std(psmc), std(psmc)/((2*K)^0.5)]);
end
	
AV(1000)
#####################################
#   0.1720000   0.3774748   0.0084406
#   0.1675000   0.3735151   0.0083521
# not much diffence
#######################################

# 5. (a) If Z is a standard normal random variable, design a study using antithetic
# variables to estimate θ = E[Z 3 e Z ].
# (b) Using the above, do the simulation to obtain an interval of length no
# greater than 0.1 that you can assert, with 95 percent confidence, contains
# the value of θ .



function X4 = polarAth()
	
	U1 = rand(1);
	U2 = rand(1);
	
	V1a = 2*U1-1;
	V2a = 2*U2 -1;
	
	Sa = V1a^2+ V2a^2;

	V1b = 2*(1-U1)-1;
	V2b = 2*(1-U2) -1;

	Sb = V1b^2+ V2b^2;

	while Sa>1 |Sb>1
		U1 = rand(1);
		U2 = rand(1);
	
		V1a = 2*U1-1;
		V2a = 2*U2 -1;
		
		Sa = V1a^2+ V2a^2;
	
		V1b = 2*(1-U1)-1;
		V2b = 2*(1-U2) -1;

		Sb = V1b^2+ V2b^2;
	end


	X4 = [  V1a * (-2*log(Sa)/Sa)^0.5;
	        V2a * (-2*log(Sa)/Sa)^0.5;
		V1b * (-2*log(Sb)/Sb)^0.5;		
		V2b * (-2*log(Sb)/Sb)^0.5;
	      ];

end





function X2 = polarNorm()
	
	U1 = rand(1);
	U2 = rand(1);
	
	V1a = 2*U1-1;
	V2a = 2*U2 -1;
	
	Sa = V1a^2+ V2a^2;

	while Sa>1 
		U1 = rand(1);
		U2 = rand(1);
	
		V1a = 2*U1-1;
		V2a = 2*U2 -1;
		
		Sa = V1a^2+ V2a^2;
	end


	X2 = [  V1a * (-2*log(Sa)/Sa)^0.5;
	        V2a * (-2*log(Sa)/Sa)^0.5;
	      ];

end



function theta = h(Z)
	theta = (Z.^3).*exp(Z); 
end

X2 = polarNorm()


function Ath(K)

	Za = [];
	for i= 1:K
		X4 = polarAth();
		Za = [Za;X4];
	end

	# 4K norm;

	theta = h(Za);
	
	
	# disp ([mean(theta), std(theta), std(theta)/((4*K)^0.5)]);

	S = std(theta)/((4*K)^0.5);
	n = 4*K;

	
	while 1.96*S >0.1
		X4 = polarAth();
		Za = [Za;X4];
		theta = h(Za);
		 disp ([mean(theta), std(theta), std(theta)/((n)^0.5)]);

		S = std(theta)/((n)^0.5);
		n = n+4;
	end



	disp ([mean(theta), std(theta), std(theta)/((n)^0.5)]);
	
end

# Ath(100)

##################################
#
#################################



# 12. (a) Explain how control variables may be used to estimate θ in Exercise 1.
# (b) Do 100 simulation runs, using the control given in (a), to estimate first
#  c∗ and then the variance of the estimator.

function X= g(U) 
	
	X= exp(U.^2);
	
end

function Control(K)

	U = rand(K,1);	

	X = g(U);
	Y = U;
	muY = 1/2;
	
	Xb = mean(X);
	Yb = mean(Y);


	covXY = mean((X-Xb).*(Y-Yb));

	varY = std(Y)^2;
	cs=  -covXY/varY



	Z =X+ cs*(Y-muY) ;

	disp([mean(Z) std(Z) std(Z)/(K^0.5)]);



	
	# Ua = rand(K,1);
	Xa = ha(U);	# define in #1

	disp ([mean(Xa), std(Xa), std(Xa)/(K^0.5)]);
	
end
 Control(100)

##############################
# cs = -1.6301
#   1.434976   0.166975   0.016698
#   1.443289   0.160431   0.016043
# ath is better
#########################


function X= g(U) 
	
	X= exp(U.^2);
	
end

function Control13(K)

	U = rand(K,1)+ rand(K,1);	
	X = g(U);



	Y = U;
	muY = 1;
	
	Xb = mean(X);
	Yb = mean(Y);


	covXY = mean((X-Xb).*(Y-Yb));

	varY = std(Y)^2;
	cs=  -covXY/varY



	Z =X+ cs*(Y-muY) ;

	disp([mean(Z) std(Z) std(Z)/(K^0.5)]);

	

	Xa = ha2(U);	# define in #1

	disp ([mean(Xa), std(Xa), std(Xa)/(K^0.5)]);
	
end
Control13(100)
###########################
# cs = -15.171
#   5.85464   6.38991   0.63899
#   5.77195   4.95430   0.49543
# ath is better
#################################

