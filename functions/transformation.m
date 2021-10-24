%This function calculates the transformation matrix used to convert the
%truss element from the global coordinate system to the local coordinate
%system
function [T] = transformation(ne,theta)

for i = 1:ne
    %calculates the sin and cos of the angle
    c(i)=cosd(theta(i)); s(i)=sind(theta(i));
    
    %assembles the transformation matrix
    T(:,:,i) = [c(i) s(i) 0 0; 
               -s(i) c(i) 0 0; 
                0 0 c(i) s(i); 
                0 0 -s(i) c(i)];
end
end

