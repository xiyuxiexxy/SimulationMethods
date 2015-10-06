# 12.4 Explain how to use a Markov chain monte carlo method to generate the
#value of a random vector X 1 , . . . , X 10 whose distribution is approximately
#the conditional distribution of 10 independent exponential random variables
# with common mean 1 given that i=1 X i > 20.

# generate X0 with PI(X0)>20

# X0(i)=1 ; c= 20/PI(X0);
# X0(i) = c- log(rand(1));
#


# 12.5 Let U1 , . . . , Un be independent uniform (0, 1) random variables. For constants
# a1 > a2 > . . . > an > 0 give a method for generating a random vector whose
# distribution is approximately that of the conditional distribution of U1 , . . . , Un
# given that a1 U1 < a2 U2 < . . . < an Un .


# U0 = 1./(a.^2); Um = max(U0); U0= U0/Um
# X0 = a.*U0 
# loop:
# i <- floor(rand(1))+1;
# U(i)<-Uniform(Xi-1,Xi+1)/ai
#


# 8. 
# Generate X0 satisfy condition
# compute q matrix
# i <- floor(rand(1))+1;
# generate random j from q(i,k) k=1...m+1;
# V = rand(1)
# if V<pjq(j,i)/piq(i,j)
# move 1 from i to j


# 10
# reserve 1 ball from each color
# run subset (n-r,m-r);

# 11  

# h = X*Y*Z   
# simulate data from f(x,y,z)
# raw X,Y,Z from exponential
# pi = C*exp(-(axy+bxz+cyz)
# C = 1/mean(exp(-(axy+bxz+cyz));


K= 1000;
U =rand(K,3);
number = -log(U); # raw x,y,z from exponential
Data= zeros(K,3); # x,y,z from f(x,y,z)


Data(1,1)= -log(rand(1));
Data(1,1)= -log(rand(1));
Data(1,1)= -log(rand(1));



function res = q(x,y,z)
	
	res = exp(-(x*y+x*z+y*z));
end


H = zeros(K,1);

H(1)= Data(1,1)*Data(1,2)*Data(1,3);
for k= 1:K

	X = number(k,1);
	Y = number(k,2);	
	Z = number(k,3);

	X0 = Data(k,1);
	Y0 = Data(k,2);	
	Z0 = Data(k,3);

	if rand(1)< q(X,Y,Z)/q(X0,Y0,Z0)
		Data(k+1,1)=X;
		Data(k+1,2)= Y;	
		Data(k+1,3)=Z;

	else
		Data(k+1,1)=X0;
		Data(k+1,2)=Y0;	
		Data(k+1,3)=Z0;
	
	end

	H(k+1) = Data(k+1,1)*Data(k+1,2)*Data(k+1,3);
	
end


disp([mean(H) var(H)])
###########################
# 0.075076   0.015580
###############################
