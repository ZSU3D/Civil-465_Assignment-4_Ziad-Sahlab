%This code is used to solve the deformations and internal forces in a 
%simply supported truss bridge. The code solved a 2D truss element FE
%problem using the matrix solution.
%Author: Ziad Sahlab
%Acknoledgment: This code has been adapted and modified from the code used
%to solve assignment 1 of the course Non-linear analysis of structures. The
%original code was written by Johnny Syriani and Ziad Sahlab
close all; clear all; clc
%%
%adds the funtions folder to the code path to be able to use all the 
%necessary functions for the code to run
addpath('./functions/');   
%adds the data folder to the code path to load the details of the nodes and
%elements that make up the truss bridge
addpath('./data/bridge_2/');%to solve bridge 1, the path should be changed 
%to './data/bridge_1/'
%%
%data input
%loads the node coordinates of the truss
ncor = load('node_coordinates.txt');
%loads the elements information (node connectivity, cross-section area, and
%young's modulus) for each element
elements = load('elements.txt');
%loads the applied load vector acting on the truss
F_ext = load('applied_loads.txt'); 
sup=[1 8]; %nodes where supports are located 
%for bridge 1, the supports are at nodes 1 and 7, for bridge 2, the
%supports are at nodes 1 and 8
%%
%structural anlysis
%This function uses the node coordinates and element connectivity to
%calulate the length of each element and the orientation of the elements in
%the global coordinate system
[L, theta, con, Ndof, ne, nn] = elem_geometry(ncor, elements);

%This function calculates the transformation matrix used to convert the
%truss element from the global coordinate system to the local coordinate
%system
[T] = transformation(ne,theta);

%This function is used to index the matrix entries with the elements and
%their correspondin nodes
[fi, sup_index, index] = node_dof(Ndof,sup, con, ne);

%This function is used to calculate the element stiffness matrix and
%assemble the global stiffness matrix
[K_glob, K_gl, K_red] = elem_stiffness(ne, elements, T, Ndof, L, fi, index);

%This function is used to calculate the nodal displacements
[u] = disp_calc(fi, Ndof, K_red, F_ext);

%This function is used to calculate the nodal and internal memeber forces
[F_el,F_int] = force_calc(K_glob, K_gl, index, T, u, ne);

%This function is used to plot the deformed and undefromed truss
plotting(u, ne, nn, ncor, elements);

disp('code run successfully')
