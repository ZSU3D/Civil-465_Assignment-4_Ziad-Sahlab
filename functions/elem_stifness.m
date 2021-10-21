function [K_glob, K_gl, K_red, index] = elem_stifness(ne, elements, T, Ndof,L, fi, index)
E = elements(:,4);
A = elements(:,3);
con = elements(:,1:2);

%unit stiffness matrix of element in local coordinate system
K_unit=[1 0 -1 0; 
        0 0 0 0; 
       -1 0 1 0; 
        0 0 0 0];
    
for i = 1:ne
    k(i) = E(i)*A(i)/L(i);
end

%element stiffness in global coordinate system
for i = 1:ne 
    k_el(:,:,i) = k(i)*T(:,:,i)'*K_unit*T(:,:,i);
end


%initializing structure stiffness matrix in global coordinate system
K_glob = zeros(Ndof);

%assembeling the structure and element stiffness matrices in global coordinate system
for z = 1:ne
    for i=1:4
        for j=1:4
            %structure stiffness matrix
            K_glob(index(z,i),index(z,j))=K_glob(index(z,i),index(z,j))+k_el(i,j,z); 
            
            %element stiffness matrix
            K_gl(index(z,i),index(z,j),z)=k_el(i,j,z);
        end
    end
end 
K_red = K_glob(fi,fi);
end

