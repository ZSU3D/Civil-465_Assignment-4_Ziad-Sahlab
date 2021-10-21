%This code is intended to perform a 2D truss analysis on the inputed truss elements
%Authors: Johnny Syriani; Ziad Sahlab
close all; clear all; clc

%%
addpath('./functions/');
addpath('./data/');
%%
%data input
ncor = load('node_coordinates.txt');
elements = load('elements.txt');
sup=[1 7]; %nodes where supports are located

[L, theta, con, Ndof, ne, nn] = elem_geometry(ncor, elements);

%%
%structural analysis 
%transformation matrix for each element
[T] = transformation(ne,theta);
[fi, sup_index, index] = node_dof(Ndof,sup, con, ne);
[K_glob, K_gl, K_red,k] = elem_stifness(ne, elements, T, Ndof, L, fi, index);

F_ext = zeros(Ndof,1);  %force vector initialization
%Input forces at DoF indices[kN]
F_ext(4) = -150;
F_ext(8) = -150; 
F_ext(12) = -150;

q = 100; %scale of deformed shape plot





%calculating the free nodes displacements
F_red = F_ext(fi);
disp_red = inv(K_red)*F_red;
disp = zeros(1,Ndof);
disp(fi) = disp_red;

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
  F_int(:,i) = T(:,:,i)*F_redel(:,i);  
end

%%
%plotting
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
gplot(nodecon(k,k),ncor, ':.k');
hold on
gplot(nodecon(k,k),defcor, 'r');
legend('Initial shape','Deformed shape')
hold off