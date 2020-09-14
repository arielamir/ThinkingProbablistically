clear all; close all;
N=10000; % number of sites.
A=zeros(N);
W=sqrt(N); % Width of box
H=sqrt(N); % Height of box

x_in=W*rand(N,1);
y_in=H*rand(N,1);

[x,ind]=sort(x_in);
y=y_in(ind);

PERC_VEC=0:0.05:2;
%PERC_VEC=1;
for p_indx=1:length(PERC_VEC)
    
    PERC=PERC_VEC(p_indx);
    
    %Finding all potential neighbors within an area much larger than
    %percolation:
    for ind1=1:N
        flag=1;
        ind2=ind1;
        while flag
            ind2=ind2+1;
            if ind2==N+1
                flag=0;
            else
                if abs(x(ind2)-x(ind1))>PERC
                    flag=0;
                end;
                d=((x(ind1)-x(ind2))^2+(y(ind1)-y(ind2))^2);
                if d<= PERC^2
                    A(ind1,ind2)=1;
                    A(ind2,ind1)=1;
                end;
            end;
        end;
    end;
    
    
    
    %B=A^round(10*W/PERC);
    [s,c]=graphconncomp(sparse(A));
    
    count=0;
    vec=zeros(N,1);
    percolated=zeros(N,1);
    for indx=1:N
        if x(indx)<PERC %connected to left side of system
            vec(indx)=1;
            inds=find(c==c(indx));
            percolated(inds)=1;
        end;
    end;
    
    res(p_indx)=length(find(percolated));
end;
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',16);
%%
plot(PERC_VEC,res,'k-o','linewidth',2);
set(gca,'FontName','Times New Roman');
set(gca,'FontSize',16);
xlabel('Diameter'); ylabel('Size of cluster');
