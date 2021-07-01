clc;
clear all;
mn = [100 100 75 75];
mx = [625 625 600 500];
a = [.0080 .0096 .0100 .0110];
b = [8 6.4 7.9 7.5];
c = [500 400 600 400];
[mn' mx' a' b' c'];

com=[1 1 1 1
     1 1 1 0
     1 1 0 1
     1 1 0 0];
 PGT=[1100 1400 1600 1800];
 disp(' L                     Pg1             Pg2             Pg3              Pg4            f1            f2             f3               f4              ft');
  
 for z =1:4
     disp(strcat('Power Demand ----- ',int2str(PGT(z)),' '));
     fprintf('\n');
     for j = 1:4
         capacity = 0;
         for check=1:4
             capacity=capacity+mx(1,check)*com(j,check);
         end
         if capacity>=PGT(1,z)
             add=0;
             ain=0;
             bt=0;
             for i=1:4
                 if com(j,i)
                     ain=ain+(1/a(i));
                     bt=bt+(b(i)/a(i));
                 end
             end
             at=1/ain;
             L=at*(PGT(1,z)+bt);
             for g= 1:4
                 pg(1,g)= ((L-b(g))/a(g)*com(j,g));
             end
             pg=round(pg);
             
             for v= 1:4
                 if pg(1,v)>mx(v)
                     temp=pg(1,v);
                     pg(1,v)=mx(v);
                     temp=temp-mx(v);
                     add=add+temp;
                 end
             end
             if add~=0
                 for w = 1:4
                     if pg(1,w)~=0
                         if pg(1,w)<mx(w)
                             temp1=mx(w)-pg(1,w);
                             if temp1<=add
                                 pg(1,w)=mx(w);
                                 add+add-temp1;
                             else
                                 pg(1,w)=pg(1,w)+add;
                                 L=(pg(1,w)*a(w))+b(w);
                             end
                         end
                     end
                 end
             end
 
             for f =1:4
                 cost(1,f) = (.5*a(f)*pg(1,f).^2+b(f)*pg(1,f)+c(f))*com(j,f);
             end
             cost=round(cost);
             total_cost=sum(cost(1,:))*4;
             value(1,:)=[L,pg(1,:),cost(1,:),total_cost];
             disp(num2str(value(1,:)));
         else
             disp('----------------------------------------------------------------infeasible-------------------------------------------------------------------------');
         end
     end
          
         
 end
 

