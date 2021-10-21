function [T] = transformation(ne,theta)

for i = 1:ne
    c(i)=cosd(theta(i)); s(i)=sind(theta(i));
    T(:,:,i) = [c(i) s(i) 0 0; 
               -s(i) c(i) 0 0; 
                0 0 c(i) s(i); 
                0 0 -s(i) c(i)];
end
end

