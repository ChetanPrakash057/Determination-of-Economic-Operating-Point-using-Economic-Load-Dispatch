clc;
clear  all;
ip=fopen('loss_data.m','r');
data=fscanf(ip,'%f',[6,3]);
data=data';
const=data(:,1);
beta=data(:,2);
gamma=data(:,3);
pmin=data(:,4);
pmax=data(:,5);
ploss=data(:,6);
lambda=input('Enter the assumed value of lambda : \n');
p=zeros(3,1);
loss=0;
demand=input('Enter the demand : \n');
deltap=1;
iteration=0;
while abs(deltap)>.0001
    iteration=iteration+1;
for i=1:3
    p(i)=(lambda-beta(i))/(2*[gamma(i)+lambda*ploss(i)]);
    loss=loss+ploss(i)*p(i)^2;
end
deltap=demand+loss-sum(p);
loss=0;
if abs(deltap)>0
    k=0;
    for i=1:3
      k=k+(gamma(i)+ploss(i)*beta(i))/(2*[gamma(i)+lambda*ploss(i)]^2);
    end
end
    deltalambda=deltap/k;
lambda=lambda+deltalambda;
end
for i =1:3
    Fc(i)=const(i)+gamma(i)*p(i)^2 + beta(i)*p(i);
end
fprintf('P1 = %.3f \nP2 = %.3f\nP3 = %0.3f\n',p);
fprintf('F1 = %.3f \nF2 = %.3f\nF3 = %0.3f\n',Fc);
Fuel_cost = Fc(1)+Fc(2)+Fc(3);
fprintf('Total Fuel cost = %.f\n',Fuel_cost);
fprintf('Number of iterations = %0.0f\n',iteration);
fprintf('Actual Value of lambda = %.f\n',lambda);









