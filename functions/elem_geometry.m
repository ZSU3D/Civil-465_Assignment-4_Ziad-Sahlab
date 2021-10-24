%This function uses the node coordinates and element connectivity to
%calulate the length of each element and the orientation of the elements in
%the global coordinate system
function [L, theta, con, Ndof, ne, nn] = elem_geometry(ncor, elements)

ne = size(elements,1); %determins the number of elements from the input
nn = size(ncor,1); %determins the number of nodes from the input

%calculates the number of degrees of freedom, 2*nn is used 
%since only the x and y displacements are considered
Ndof = 2*nn; 

%sets the element connectivity by node
con = elements(:,1:2);

%calculates the length of the elements from the nodal coordinates
for i = 1:ne 
    Lx(i) = ncor(con(i,2),1)-ncor(con(i,1),1); %x component
    Ly(i) = ncor(con(i,2),2)-ncor(con(i,1),2); %y component
    L(i) = sqrt(Lx(i)^2 +Ly(i)^2);             %element length
    
    theta(i) = atand(Ly(i)/Lx(i));  %angle calculatuion in degrees
    
    if Lx(i)<0 
        theta(i)=theta(i)+180; %angle correction
    end
end 

end

