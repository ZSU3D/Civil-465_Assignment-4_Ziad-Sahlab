function [plot_1,plot_2] = plotting(disp, ne, nn, ncor, elements)

con = elements(:,1:2);
q = 100;

%isolating the x and y displacements

for i = 1: nn
    defx(i) = disp(2*i-1);
    defy(i) = disp(2*i);
end
%creating a deformation matrix
def(:,1) = defx;
def(:,2) = defy;
defcor = ncor+q*def;

%creating a node connectivity matrix
%creating a node connectivity matrix
nodecon = zeros(nn,nn);
for i = 1: ne
    nodecon(con(i,1),con(i,2)) = 1;
    nodecon(con(i,2),con(i,1)) = 1;
end


%plotting the deformed shape
k = 1:nn;
plot_1 = gplot(nodecon(k,k),ncor, ':.k');
hold on
plot_2 = gplot(nodecon(k,k),defcor, 'r');
legend('Initial shape','Deformed shape')
hold off
end

