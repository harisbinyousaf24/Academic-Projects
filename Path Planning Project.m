clc
clear
%DEFINING PARAMETERS
a = 0.99;
b = 0.1;
N = 5;
X0 = 0;
Xn = 10;
file_180841 = fopen('Haris_180841_Week10_PPMRL.txt','w');
fprintf(file_180841,'<----------GUESSED VALUES FOR U (CONTROL)------------->\n\n');
U = [3 7 13 20 26]
fprintf(file_180841, '\n %4.2f  \n',U);

fprintf(file_180841,'<----------GUESSED VALUES FOR X (POSITION)------------->\n\n');

%FINDING VALUES OF X FOR ASSUMED VALUES OF U
for k=0:4
    X(k+1) = (a*X0)+ b*U(k+1)
    X0 = X(k+1);
    fprintf(file_180841,'\n %1.0f -',k)   
    fprintf(file_180841,'\t %4.2f \n ',X(k+1))
end
%SQUARING ELEMENTS OF ARRAY U
U1 = U.^2;
%SUM OF THE ELEMENTS OF ARRAY U
Sum = 0;
for v = 1:5
    Sum = Sum + U1(v);
end
fprintf(file_180841,'<----------FINDING PERFORMANCE INDEX J------------->\n\n');
%FINDING J
J = (Sum/2)
fprintf(file_180841,'\t%4.2f \n',J)
fprintf(file_180841,'<----------OPTIMIZED VALUES FOR U* (OPTIMAL CONTROL)------------->\n\n');
%FINDING U*
for k=0:4
    Un(k+1) = 20.811*(0.99^(4-k))
    fprintf(file_180841,'\n %1.0f - ',k) 
    fprintf(file_180841,'\t%4.2f \n',Un(k+1))
    %SUM OF THE ELEMENTS OF ABOVE ARRAY
    U2 = Un.^2
end
%SUM OF THE VALUES OF U2
Sum1 = 0;
for i = 1:5
    Sum1 = Sum1 + U2(i);
    
end
fprintf(file_180841,'<----------FINDING PERFORMANCE INDEX J*------------->\n\n');
%FINDING J*
Jn = (Sum1/2)
fprintf(file_180841,'\n %4.2f \n',Jn)

fprintf(file_180841,'<----------OPTIMIZED VALUES FOR X* (OPTIMAL POSITION)------------->\n\n');
%FINDING X*
for k=0:4
    X1(k+1) = (a*X0)+ b*U2(k+1)
    X0 = X(k+1);
    fprintf(file_180841,'\n %1.0f -',k)    
    fprintf(file_180841,'\t %4.2f \n ',X1(k+1))
end
for i=0:3
figure(1)
      title('OPTIMAL & GUESSED POSITION ')
     
plot([i+1,(i+2)],[X(i+1),X(i+2)])   % grpah b/w time and guessed position
text([i+1,(i+2)],[X(i+1),X(i+2),],'guessed')
hold on
plot([i+1,(i+2)],[X1(i+1),X1(i+2)])   % grpah b/w time and optimized position
text([i+1,(i+2)],[X1(i+1),X1(i+2),],'optimal')
xlabel("Time Step");
ylabel("Position");
 
end
 %plot for Control
for i=0:3
figure(2)  

plot([i+1,(i+2)],[U(i+1),U(i+2),])   % grpah b/w time and guessed position
text([i+1,(i+2)],[U(i+1),U(i+2),],'guessed')
hold on
plot([i+1,(i+2)],[Un(i+1),Un(i+2)])   % grpah b/w time and optimized position
text([i+1,(i+2)],[Un(i+1),Un(i+2),],'optimal')
title('OPTIMAL & GUESSED CONTROL ')
xlabel("Time Step");
ylabel("Control");
end





