dt=0.01; mu=0.1; sigma=1; t=10;
S=1;
for indx=1:(t/dt)
S(indx+1)=S(indx)*exp(mu*dt+randn*sigma*sqrt(dt));
end;
%%
dt=0.01; t=0:dt:1; sigma=1; mu=0;
p=1; %stock strike price
s_vec=0:0.01:50; %possible values of stock price
v=zeros(length(t),length(s_vec));
v(1,:)=max(0,s_vec-p); %boundary conditions for solving the backwards recursive relation
for indx=2:length(t)
    for s_indx=1:length(s_vec)
        s=s_vec(s_indx);
        s_p=s*exp(mu*dt+sigma*sqrt(dt)); %if the market goes up
        s_m=s*exp(mu*dt-sigma*sqrt(dt)); %and down
        [tmp,indx_p]=min(abs(s_p-s_vec)); %used to round s_p to value in s_vec
        [tmp,indx_m]=min(abs(s_m-s_vec));
        x=(v(indx-1,indx_p)-v(indx-1,indx_m))/(s_p-s_m);
        v(indx,s_indx)=v(indx-1,indx_p)-x*(s_p-s); %option pricing for earlier time
    end;
end;
range=1:200;
imagesc(s_vec(range),t,v(:,range));
ylabel('Time'); xlabel('Stock price');
figure;
plot(s_vec(range),v(1,range),s_vec(range),v(end,range),'linewidth',2);
xlabel('Stock price'); ylabel('Option price'); legend('t=0', 't=1');
