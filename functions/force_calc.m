%This function is used to calculate the nodal and internal memeber forces
function [F_el,F_int] = force_calc(K_glob, K_gl, index, T, disp, ne)

%calculating the nodal forces
F = K_glob*disp';  

%calculating the element force vectors
for i = 1 : ne
    F_el(:,i) = K_gl(:,:,i)*disp';
end

%calculating internal axial forces
for i = 1 : ne
    for j=1:4
       F_redel(j,i) = F_el(index(i,j),i);
    end
  F_int(:,i) = T(:,:,i)*F_redel(:,i);  %the axial forces in the truss members
end
end

