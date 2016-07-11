%% compute the result, use the function method1,method2,method3 define before
clear
%load x, y first
load DATA1.txt;
size(DATA1);
y=DATA1(:,1); %y is the dependent variables, 10000*1
x=DATA1(:,2:21); % x are independent variables 10000*20
beta0=[zeros(20,1),zeros(20,1)+100,(x'*x)\(x'*y)]; % set the initial value for the computation
for i=1:3
betahat1(:,i)=method1(beta0(:,i),x,y );
betahat2(:,i)=method2(beta0(:,i),x,y );
betahat3(:,i)=method3(beta0(:,i),x,y );
end

%% output the table
%write the output to the exp.txt
fid = fopen('exp.txt','w');
for i=1:20
    fprintf(fid, 'v%d      &    %.3f      &    %.3f      &    %.3f      &    %.3f      &    %.3f      &    %.3f      &    %.3f      &    %.3f      &    %.3f \\\\ \n',i+1,betahat1(i,1),betahat1(i,2),betahat1(i,3),betahat2(i,1),betahat2(i,2),betahat2(i,3),betahat3(i,1),betahat3(i,2),betahat3(i,3));
end
fclose(fid);
    
        