clear;
clc;
k = 0;
hold on
i = 1;
c = [0 0 0 0 0 1];
A = [-0.05 -0.27 -0.19 -0.185 -0.185 0;
    0 0.025 0 0 0 -1;
    0 0 0.015 0 0 -1
    0 0 0 0.055 0 -1;
    0 0 0 0 0.026 -1];
 Aeq = [1 1.01 1.02 1.045 1.065 0];
 beq = 1;
 vlb = [0 0 0 0 0 0];
 vub = [];
while k < 0.26
    b = [-k 0 0 0 0];
    [x val] = linprog(c,A,b,Aeq,beq,vlb,vub);
    plot(k,val,'*');
    w(:,i) = x';
    k = k + 0.01;
    i = i+1;
end
xlabel('k固定盈利水平');
ylabel('Q极小化风险');
%%
clear;
clc;
hold on
s = 0;i = 1;
A = [0 0.025 0 0 0 -1;
    0 0 0.015 0 0 -1
    0 0 0 0.055 0 -1;
    0 0 0 0 0.026 -1];
b = [0 0 0 0];
Aeq = [1 1.01 1.02 1.045 1.065 0];
beq = 1;
vlb = zeros(6,1);
vub = [];
while s < 1
    c = [(1-s)*[-0.05 -0.27 -0.19 -0.185 -0.185] s];
    [x val] = linprog(c,A,b,Aeq,beq,vlb,vub);
    plot(s,-val,'*');
    w(:,i) = x';
    s = s + 0.01;
    i =  i + 1;
end
xlabel('s');
ylabel('Q');