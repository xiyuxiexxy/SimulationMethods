# 4_17

# P = 0.5 *p1 + 0.5* p2 ;
# p1 = Geo(0.5);
# p2 = Geo(1/3);


function g = Geo(p)
	q= 1-p;
	u =rand(1);
	g= floor(log(u)/log(q))+1;	
end

function x= compose()
	u = rand(1)
	if u <=0.5 
		x= Geo(0.5);
		return;
	end
	x= Geo(1/3);
end
	


