# 12. Suppose in the model of Section 7.6 that, conditional on the event that the
# firm’s capital goes negative before time T , we are also interested in the time
# at which it becomes negative and the amount of the shortfall. Explain how we
# can use the given simulation methodology to obtain relevant data.

function event = selectevents(v, nu,nl)
	
	F1 = v/(v+nu+nl);
	F2 = F1+ nu/(v+nu+nl) ;


	u = rand(1);

	if u< F1;
		event =1 ;return;
	else
		if u<F2
			event =2 ;return;
		else
			event = 3; return ;

		end
	end

end

function [I t a]= Risk(n0, a0, T, v, mu, lamda )

	t = 0;
	n = n0;
	a = a0;

	ta = -log(rand(1))/(v+n*mu+n*lamda);	 #next time interval
	while (t< T)

		 
	
		t = t +ta; 
		a = a+ n*c*ta;


		if(t>T) 
			I =1 ; t=0; s=0;return;		# not count, or rerun

		j = selectevents();
	
		switch (j)
	
		case 1  n= n+1; break;
		case 2  n= n-1; break;					 
		case 3  Y = F; 
		 
			a = a-Y;
			if(a <0)
				I=0; return;   
			end;
			break
	end
end

nSim;
result = zeros(nSim,3);
function Simulation
	for iter = 1:nSim
		[result(iter,1) result(iter,2) result(iter,3)] = Risk(n0, a0, T, v, mu, lamda )
	end
end

cond = find(result(:,1)==0)

t= result(cond,2);
s= result(cond,3);





