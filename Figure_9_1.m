                    clear all; close all;
                    Res=[];
                    for N=[10 30 100];
                    ITERATIONS=1000000/N; p_vec=0:0.01:1;

                    for p_indx=1:length(p_vec)
                        p=p_vec(p_indx);
                        counter=0;
                    for iteration_number=1:ITERATIONS    
                        A=(rand(N)<p);
                        Burnt=0; %Haven't percolated yet

                        flag=zeros(N);

                        %Putting the first column into the stack:
                        stack_size=0;

                        for j=1:N
                            if A(j,1)
                                stack_size=stack_size+1;
                                stack(1,stack_size)=j;
                                stack(2,stack_size)=1;
                                flag(j,1)=1;
                            end;
                        end;

                        while stack_size>0 & ~Burnt %while there are still trees with neighbors to check:
                            coors=stack(:,stack_size);
                            if coors(2)==N
                               Burnt=1;
                           end;
                            stack_size=stack_size-1;

                            if coors(1)<N
                                if A(coors(1)+1, coors(2))& flag(coors(1)+1, coors(2))==0 
                                    stack_size=stack_size+1;
                                    stack(1,stack_size)=coors(1)+1;
                                    stack(2,stack_size)=coors(2);
                                    flag(coors(1)+1,coors(2))=1;
                                end;
                            end;

                            if coors(1)>1
                                if A(coors(1)-1, coors(2))& flag(coors(1)-1, coors(2))==0 
                                    stack_size=stack_size+1;
                                    stack(1,stack_size)=coors(1)-1;
                                    stack(2,stack_size)=coors(2);
                                    flag(coors(1)-1,coors(2))=1;
                                end;
                            end;

                            if coors(2)<N
                                if A(coors(1), coors(2)+1)& flag(coors(1), coors(2)+1)==0
                                    stack_size=stack_size+1;
                                    stack(1,stack_size)=coors(1);
                                    stack(2,stack_size)=coors(2)+1;
                                    flag(coors(1),coors(2)+1)=1;
                                end;
                            end;

                            if coors(2)>1
                                if A(coors(1), coors(2)-1)& flag(coors(1), coors(2)-1)==0
                                    stack_size=stack_size+1;
                                    stack(1,stack_size)=coors(1);
                                    stack(2,stack_size)=coors(2)-1;
                                    flag(coors(1),coors(2)-1)=1;
                                end;
                            end;
                        end;

                        if Burnt
                            counter=counter+1;
                        end;
                    end;
                        percolation_prob(p_indx)=counter/ITERATIONS;
                    end;

                    plot(p_vec,percolation_prob,'k.-'); %,'linewidth',2);
                    Res=[Res percolation_prob];
                    hold on;
                    end;
                    %%
                    close all;                  
                    for indx=1:3
                        plot(p_vec,Res((length(p_vec)*(indx-1)+1):(length(p_vec)*indx)),'k.-','linewidth',1);
                        hold on;
                    end;
                    shg;
                    set(gca,'FontName','Times New Roman');
                    set(gca,'FontSize',18);
                    xlabel('$p$','interpreter','latex'); ylabel('$P_{percolation}$','interpreter','latex');
                    %legend('N=10','N=20','N=30','N=40','N=50','N=60','N=70','N=80','N=90','N=100');
                    %B=A;
                    %B(find(flag))=4;
                    %imagesc(B);