function f = mygmm(theta2)
	% This function computes the GMM objective function. f is the objective

global invA theta1 x1 IV 

delta = meanval(theta2);

% the following deals with cases were the min algorithm drifts into region where %the objective is not defined
if max(isnan(delta)) == 1
	f = 1e+10;
else
	temp1 = x1'*IV;
	temp2 = delta'*IV;
   theta1 = (temp1*invA*temp1')\(temp1*invA*temp2');
   clear temp1 temp2 
	gmmresid = delta - x1*theta1;
	temp1 = gmmresid'*IV;
	f = temp1*invA*temp1';
   clear temp1
	save gmmresid gmmresid
end

%disp(['GMM objective:  ' num2str(f1)])

 save gmmresid; 
	%gmmresid.mat is needed later by the subroutine var_cov.m

