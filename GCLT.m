mu=0.5; B=0.5; dt=0.001;

w_vec=-10000:dt:10000;
for indx=1:length(w_vec)
    w=w_vec(indx);
    f(indx)=exp(-abs(w)^mu/2*(1-i*B*tan(pi*mu/2)*sign(w)));
end;

x_vec=-5:0.1:5;
for indx=1:length(x_vec)
    x=x_vec(indx);
    y(indx)=0;
    for tmp=1:length(f)
    y(indx)=y(indx)+exp(-i*w_vec(tmp)*x)*f(tmp)*dt;
    end;
end;
y=y/(2*pi);
plot(x_vec,y);
