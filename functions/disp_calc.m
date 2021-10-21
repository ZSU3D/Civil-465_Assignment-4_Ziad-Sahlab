
function [disp] = disp_calc(fi, Ndof, K_red, F_ext)

F_red = F_ext(fi);

disp_red = inv(K_red)*F_red;
disp = zeros(1,Ndof);
disp(fi) = disp_red;

end

