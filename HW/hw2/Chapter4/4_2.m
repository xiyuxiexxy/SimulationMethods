# 4.2 
# Write a computer program that, when given a probability mass function
# { p j , j = 1, . . . , n} as an input, gives as an output the value of a random
# variable having this mass function.

#################################################################

# input  ps (pmf)
# output the responding random value x (index)

function x = inverseTransform(ps)
	F= cumsum(ps);
	u= rand(1)
	x= find(F>u)(1);
end

###########################################################

ps = ones(1,10)/10
 x = inverseTransform(ps)

