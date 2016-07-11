function f = ind_shr( mvalold,expmu )
%ind_shr compute the ind probability to buy certain product
%   meanvalue is the mean utility value
% expmu is the nonlinear part 
global ns cdindex cdid
eg = expmu.*kron(ones(1,ns),mvalold);
temp = cumsum(eg);
sum1 = temp(cdindex,:);
sum1(2:size(sum1,1),:) = diff(sum1);

denom1 = 1./(1+sum1);
denom = denom1(cdid,:);
f = eg.*denom;

end

