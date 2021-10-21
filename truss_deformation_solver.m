%This code is used to solve the deformations and internal forces in a 


%Authors: Johnny Syriani; Ziad Sahlab
close all; clear all; clc
%%
addpath('./functions/');
addpath('./data/bridge_2/');
%%
%data input
ncor = load('node_coordinates.txt');
elements = load('elements.txt');
F_ext = load('applied_loads.txt');  %force vector initialization
sup=[1 8]; %nodes where supports are located
%%
[L, theta, con, Ndof, ne, nn] = elem_geometry(ncor, elements);
[T] = transformation(ne,theta);
[fi, sup_index, index] = node_dof(Ndof,sup, con, ne);
[K_glob, K_gl, K_red] = elem_stifness(ne, elements, T, Ndof, L, fi, index);
[disp] = disp_calc(fi, Ndof, K_red, F_ext);
[F_el,F_int] = force_calc(K_glob, K_gl, index, T, disp, ne);
plotting(disp, ne, nn, ncor, elements);
