function [L, theta, con, Ndof, ne, nn] = elem_geometry(ncor, elements)

ne = size(elements,1);
nn = size(ncor,1);
Ndof = 2*nn;
con = elements(:,1:2);


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

