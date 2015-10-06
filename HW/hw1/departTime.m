
% 1. 2
(1)
An= [12,31,63,95,99,154,198,221,304,346,411,455,537];
Sn= [40,32,55,48,18,50,47,18,28,54,40,72,12];


N= length(An);


Dn=zeros(N,1);

function Dn= departTime (An, Sn, Dn,N)

	Dn(1)=An(1)+Sn(1);

	for iter = 2:N
		Dn(iter)=max(An(iter), Dn(iter-1))+ Sn(iter);
		fprintf("%d ", Dn(iter));
	end
		
end




% argue
%
%	observe that if we have D0= 0	
%	Dn(1) also follow the formular of 
%		Dn(iter)=max(An(iter), Dn(iter-1))+ Sn(iter);
%
%	





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
(2) (3) (4)
nSer= 2; 
Ds= zeros(nSer, 1);

for iter= 1:N
	iSer = find(Ds== min(Ds))(1);
	
	Dn(iter)=max(An(iter), Ds(iSer))+ Sn(iter);
	Ds(iSer)=Dn(iter);
end	


%  nSer =k for general case
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

1(3)
An= [12,31,63,95,99,154,198,221,304,346,411,455,537];
Sn= [40,32,55,48,18,50,47,18,28,54,40,72,12];


N= length(An);


Dn=zeros(N,1);


Dn(1)=An(1)+Sn(1);
An(1) =inf;
iter =1; 
count =0;
for count =2: N
	
	%fprintf(" count %d,  iter %d\n", count, iter);
	waiting= find(An<=Dn(iter));
	
	if length(waiting)==0
		next = count;
	else
		next = waiting(length(waiting));
	end

	Dn(next)=max(An(next), Dn(iter))+ Sn(next);
	An(next)=inf;
	iter =next;
	
end





