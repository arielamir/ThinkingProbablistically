S=0.2;
N=1000;
B=randn(N);
A=(B+S*transpose(B))/2;
plot(eig(A),'.'); axis equal;
