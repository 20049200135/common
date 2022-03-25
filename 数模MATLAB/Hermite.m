population = [5.4;5.5;5.6;5.7;5.9;6.0;6.1;6.3;6.5;6.6;6.7;6.6;6.6;6.7;6.9;7.0;7.3;7.5;7.6;7.9;8.1;8.3;8.5;8.7;8.9
    9.1;9.2;9.4;9.5;9.6;9.8;9.9;10;10.2;10.3;10.4;10.6;10.8;10.9;11.1;11.3;11.4;11.6;11.7;11.9;12;12.1;12.2;12.4;
    12.5;12.6;12.7;12.8;12.9;13.0;13.1;13.2;13.3;13.4;13.5;13.5;13.6;13.7;13.7;13.8;13.9;14;14;14.1];
p1 = pchip(1:69,population,1:0.5:69);
p2 = spline(1:69,population,1:0.5:69);
plot(1:69,population,1:0.5:69,p2,'r-')
x = p1;
y = p2;

f = @(s)s^2/(100+30*s+s^2);
c = @(s) abs(f)

y = @(w) sqrt(1+(1/(3*w).^2))
i=1;
for w = 0.1:0.1:1
    a(i) = y(w);
    i=i+1;
end
plot(1:10,a(1:10),'b-')
