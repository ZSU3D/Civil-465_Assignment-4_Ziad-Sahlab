%This function is used to index the matrix entries with the elements and
%their correspondin nodes
function [fi, sup_index, index] = node_dof(Ndof,sup,con,ne)

%assigning DoF indices to nodes
for i = 1: ne
index(i,:)=[2*con(i,1)-1,2*con(i,1),2*con(i,2)-1,2*con(i,2)];
end

%sets the fixed nodes based on the user selected support nodes
sup_index = zeros(1,Ndof);
for i = 1: length(sup)
sup_index(2*sup(i)-1) = 1;
sup_index(2*sup(i)) = 1;
end


%assigning DoF indices to free nodes
for i = 1: Ndof
    if sup_index(i) < 1
        fi(i) = i;
    end     
end

fi = fi(fi ~= 0);
end

