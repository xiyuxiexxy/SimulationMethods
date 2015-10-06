# 1. Give a method for generating a random variable having density function
# f (x) = e^x /(e − 1) x =[0, 1]

#  x= F' = ln((e-1)*u+1)
#  
function  x= f()
	u= rand(1) 
	x= log((e-1)*u+1);
end


# x = f()

#################################################################################

# 3. Use the inverse transform method to generate a random variable having
# distribution function

# F(x) = (x^2+x)/2 
# x =F' = (2*u+1/4)^0.5-0.5

function  x= f3()
	u= rand(1)
	x= (2*u+1/4)^0.5-0.5;
end

# x3 = f3()


#################################################################################

#5. Give a method for generating a random variable having density function
# e2x , −∞ < x < 0
# e−2x , 0 < x < ∞

# x= log(2U)/2 u<0.5 or x= log(2(1-u))/-2 u>0.5

function  x= f5()	
	while 1
		u= rand(1)
		if u!=0 && u!=0.5 && u!=1
			break;
		end
	end
	if u<0.5
		x=  log(2*u)/2 ;
	else
		 x= log(2*(1-u))/(-2) ;
	end
end

 x5 = f5();

#################################################################################

# 8. Using the result of Exercise 7, give algorithms for generating random variables
# from the following distributions.


# input  ps (pmf)
# output the responding random value x (index)

function x = inverseTransform(ps)
	F= cumsum(ps);
	u= rand(1)
	x= find(F>u)(1);
end


#(a)

function x = p1()
	x = rand(1);
end

function x = p2()
	x = (rand(1))^(1/3);
end

function x = p3()
	x = (rand(1))^(1/5);
end

function x = Compose()

	ps = [1/3 1/3 1/3];
	j = inverseTransform(ps);

	switch (j)
  		case 1 x=p1(); break;
		case 2 x=p2(); break;
		case 3 x=p3(); break;
	endswitch
end

	
# x = Compose();

######################################################

#(c)

function x = Compose(ps)

	 # ps = [1/3 1/3 1/3];
	j = inverseTransform(ps);

	x=  rand(1)^(1/j)
	
end


######################################################

# 9 .Give a method to generate a random variable having distribution function

#  f(y) = p(Y=y) = e^-y 
# y is exponential random variable y = -log(u)

# Fy(x)= x^y   
# x = u^(1/y)

function x= f9()
	y = -log(rand(1))
	x = rand(1)^(1/y)
end

x=  f9();

###############################################################################

# 10. A casualty insurance company has 1000 policyholders, each of whom will
# independently present a claim in the next month with probability .05.
# Assuming that the amounts of the claims made are independent exponential
# random variables with mean $800, use simulation to estimate the probability
# that the sum of these claims exceeds $50,000.


# Generate 1000 independent bernulli for claim happen
# that is a random number b from binomial distribution 

# and generate b exponential random numbers and sum them up

# check whether exceeds 

# run serval times for average number of exceeds




function b = Binomial(n,p)
	u= rand(1);
	
	c =p/(1-p);
	
	i=0;
	pr=(1-p)^n;
	F= pr;

	while u>=F 
		alpha = c*(n-i)/(i+1); ;  
		pr = alpha *pr;
		F = F+ pr;
		i = i+1;
	end
				
	b= i;
end


function e = Exponential(lamda)
	u= rand(1);
	e= -(1/lamda)*log(u);
end


function x = sumClaim(n, p,mean, limit)

	b= Binomial(n,p);
	
	sum = 0;
	for claim = 1:b
		sum =sum+ Exponential(1/mean);
	end

	if sum >limit
		x= 1;
	else
		x=0 ;
	end
end


function results = estimate(k,n, p,mean, limit)

	results= zeros(1,k);

	for iter = 1:k
		iter;
		results(iter)= sumClaim(n, p,mean, limit);
	end

	
end


# x = estimate(1000,1000, 0.05,800, 50000);

# result = mean(x)


######################################################################

# 5_59 Buses arrive at a sporting event according to a Poisson process with rate 5
# per hour. Each bus is equally likely to contain either 20, 21,..., 40 fans, with
# the numbers in the different buses being independent. Write an algorithm to
# simulate the arrival of fans to the event by time t = 1.

# N(1) = Poisson(lamda)
# number of fans on one bus is uniform on 20-40


# Poisson is number of independent exponetional by time 1
# sum(e)<=1
# PI(U)>=exp(-lamda)


function x = Poisson(lamda)
	i =1 ;
	

	pu= rand(1);
	
	while pu>=exp(-lamda)
		pu= pu * rand(1);
		i = i+1;
	end
	
	x= i-1;
end

# x= 0;
# for i = 1:1000
#	x =x + Poisson(5);	 
# end
# x = x/1000


function u = Uniform (a, b)
	u = rand(1);
	u = floor ((b-a)* u) + a
end


function  people = funs(lamda, a, b)

	n = Poisson(lamda)
	people = 0;
	for iter = 1:n
		people = people + Uniform(a, b);
	end	
end


x = funs(5, 20, 40);




function results = simulation (k, lamda, a, b)
	results = zeros(1, k);
	for iter = 1: k  
		results(iter) = funs(lamda, a, b);
	end
end

results = simulation (1000, 5, 20, 40 );

x = mean(results)


	

