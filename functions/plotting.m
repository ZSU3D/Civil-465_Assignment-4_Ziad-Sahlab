%This function is used to plot the deformed and undefromed truss
function plotting(u, ne, nn, ncor, elements)

con = elements(:,1:2);
q = 100; %scaling factor to better observe the deformations. can be set by user


%isolating the x and y displacements
for i = 1: nn
    defx(i) = u(2*i-1);
    defy(i) = u(2*i);
end
%creating a deformation matrix
def(:,1) = defx;
def(:,2) = defy;
defcor = ncor+q*def;


%creating a node connectivity matrix
nodecon = zeros(nn,nn);
for i = 1: ne
    nodecon(con(i,1),con(i,2)) = 1;
    nodecon(con(i,2),con(i,1)) = 1;
end


%plotting the deformed shape
k = 1:nn;
gplot(nodecon(k,k),ncor, ':.k');
hold on
gplot(nodecon(k,k),defcor, 'r');
legend('Initial shape','Deformed shape')
hold off
end

