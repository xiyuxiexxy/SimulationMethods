# 4.16 Suppose that the random variable X can take on any of the values 1, . . . , 10
# with respective probabilities 0.06, 0.06, 0.06, 0.06, 0.06, 0.15, 0.13, 0.14, 0.15,
# 0.13. Use the composition approach to give an algorithm that generates the
# value of X . Use the text’s random number sequence to generate X.



as = [0.6 0.35 0.03 0.02];



function x = inverseTransform(ps)
	F= cumsum(ps);
	u= rand(1)
	x= find(F>u)(1);
end

 x = inverseTransform(as)


function n = p1()
	n = floor(10*rand(1))+1;	
end


function n = p2()
	n = floor(5*rand(1))+6;	
end

function n = p3()
	x= [6 8 9];
	index = floor(3*rand(1))+1;
	n = x(index);	
end

function n = p3()
	x= [6 9];
	index = floor(2*rand(1))+1;
	n = x(index);	
end





function n = simulation(x)
	switch (x)
  		case 1 n=p1(); break;
		case 2 n=p2(); break;
		case 3 n=p3(); break;
		case 4 n=p4(); break;
	endswitch
end


n= simulation(x)

