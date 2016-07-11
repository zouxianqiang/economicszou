function f = mufun(x2,theta2)
% This function computes the non-linear part of the utility (mu_ijt in the %%Guide)
% in this case, there is no demographic variables, and there are only two
% variables have random coefficients
global ns vfull
[n , k] = size(x2);
mu = zeros(n,ns);
for i = 1:ns
    	v_i = vfull(:,i:ns:k*ns);     
 		mu(:,i) = x2.*v_i*theta2;
end
f = mu;
end

