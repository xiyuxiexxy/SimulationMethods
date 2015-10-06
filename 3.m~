function y = f (x)
  y = exp(e^x)
endfunction

ans = quad("f",0,1)


for k = 10 .^ [2,4,6]
	x = rand(1, k);
	y = exp(e.^x);
	res = mean (y);
	sd = 2*std(y)/sqrt(k);
	fprintf("k= %d, res= %f, sd = %f \n ", k, res,sd);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ans =  6.3166

k= 100, res= 6.512585, sd = 0.654211 
 k= 10000, res= 6.382560, sd = 0.066751 
 k= 1000000, res= 6.313268, sd = 0.006585 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%3.7


function y = f (x)
  y = exp(-x^2)
endfunction

ans= quad("f", -inf, inf)

% y=  1/(1+ exp(-x));   % logistic function


% x = -log((1/y)-1)
% dx = 1/(y-y^2)dy
% F = exp(-(log((1/y)-1))^2 ) /  y*(1-y)   
 
function z = f(y)
  z = exp(-(log((1/y)-1))^2 ) /  (y*(1-y)) 
endfunction

k =10000;
y= rand(1,k);
z= zeros(1,length(y));
for iter= 1:length(y)
	z(iter)= f(y(iter))
end	

	res = mean (z);
	sd = 2*std(z)/sqrt(k);
	
	fprintf("k= %d, res= %f, sd= %f\n ", k, res, sd);
		
%%%%%%%%%%%%%%%%

ans =  1.7725
res =  1.7419
sd =  0.029569

% a little out of range
% a lot of rounding error for complicated expression
% increase k 
%%%%%%%%%%%%%%%%%%%%%%%

% 3.8



for k = 10.^[2,4,6]
x = rand(1,k);
y = rand(1,k);

z = exp((x+y).^2);	

res = mean (z);
sd = 2*std(z)/sqrt(k);
	
fprintf("k= %d, res= %f, sd= %f\n ", k, res, sd);
end		
k= 100, res= 5.621596, sd= 1.321125
 k= 10000, res= 4.872142, sd= 0.114684
 k= 1000000, res= 4.902062, sd= 0.011934



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%3.9

%u1 = exp(-x);
%u2 = exp(-y);

%x= -log(u1);
%y= -log(u2);


%dx= -(1/u1)du1;
%dy= -(1/u2)du2;

%  Y<X => U1<U2

u1 = rand(1,k);
u2 = rand(1,k);

z = zeros(1,length(y));

z(index) = (u1(index)+u2(index))./u1(index)./u2(index);

res = mean(z);
sd = 2*std(z)/sqrt(k);
	
fprintf("k= %d, res= %f, sd= %f\n ", k, res, sd);

k= 1000000, res= 25.259165, sd= 17.680621

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

3.12


for repeat= 10.^[2,3,4]
Ns=zeros(1,repeat);

for iter = 1:repeat
for k= 1:100
x= rand(1,k);
s= sum(x);
if s>1
Ns(iter)= k;

break;
end; 					
end;
end;
fprintf("%d, %f \n", repeat, mean(Ns));

end ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
100, 2.490000 
1000, 2.581000 
10000, 2.606100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

3.13

for repeat= 10.^[2,3,4]
Ns=zeros(1,repeat);

for iter = 1:repeat
p=1;
for k= 1:100

x= rand(1);
p = p*x;
if p< exp(-3)
Ns(iter)= k-1;
%fprintf("N = %d", k-1);

break;
end
end
end

fprintf("%d, %f \n", repeat, mean(Ns));
end

100, 3.160000 
1000, 2.972000 
10000, 2.983600 


for n = 0:6
pn=length(find(Ns==n))/length(Ns);
fprintf("p(N== %d) is %f\n", n, pn);
end


p(N== 0) is 0.047900
p(N== 1) is 0.155200
p(N== 2) is 0.220400
p(N== 3) is 0.228100
p(N== 4) is 0.169600
p(N== 5) is 0.096100
p(N== 6) is 0.050500

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
3.14

X=zeros(1, 14)

X(1)= 23;
X(2)= 66;

for iter = 3:14
X(iter)= mod( 3*X(iter-1)+5*X(iter-2), 100);
end

U= X/100;

 Columns 1 through 7:

   0.230000   0.660000   0.130000   0.690000   0.720000   0.610000   0.430000

 Columns 8 through 14:

   0.340000   0.170000   0.210000   0.480000   0.490000   0.870000   0.060000








