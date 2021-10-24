%This function is used to calculate the nodal displacements
function [u] = disp_calc(fi, Ndof, K_red, F_ext)

F_red = F_ext(fi); %forces acting on the free nodes

disp_red = inv(K_red)*F_red; %displacement of the free nodes
u = zeros(1,Ndof);
u(fi) = disp_red; %structural displacement vector
%the vector has the x and y displacements of each node in order starting
%from node_1 x displacement then node_2 y displacement and so on.

end

