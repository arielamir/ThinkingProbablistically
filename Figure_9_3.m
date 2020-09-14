clear all; close all;
rng(0);
N=30;
p=0.52;
p1=rand(N+2);
%horizontal lines:
for i=0:(N)
    for j=0:(N-1)
        if p1(i+1,j+1)<p
            x=j:0.01:j+1;
            y=i*ones(length(x),1);
            plot(x,y,'k','linewidth',2);
            hold on;
        end;
    end;
end;
%%
p2=rand(N+1);
%vertical lines:
for i=0:(N)
    for j=0:(N-1)
        if p2(i+1,j+1)<p
            y=j:0.01:j+1;
            x=i*ones(length(x),1);
            plot(x,y,'k','linewidth',2);
            hold on;
        end;
    end;
end;
%%
axis off; shg;