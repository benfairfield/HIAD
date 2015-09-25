function [x_plot,y_plot,z_plot,xyz] = Circular_Cross_Section(cent1,cent2,orientation,r,n)
%---------------------------------------------------------------------%
%-                       Circular_Cross_Section                     --%
%-      Returns 3 plotting arrays for cross sectional slats between --%
%-      nodel circular cross sectional areas and also returns 2     --%
%-      arrays containing nodal location of nodal circular cross    --%
%-      sectional areas. Modified original function to create       --%
%-      normal vectors in direction of rotations                    --%
%-                          Updated 6/10/2015                       --%
%-                            Project 1263                          --%
%---------------------------------------------------------------------%
 
%   cent1 - center of circular cross sectional area for node 1 (column)
%   cent2 - center of circular cross sectional area for node 2 (column)
%   orientation - orientation point (column)
%   r - radius of circular cross sectional area
%   n1 - number of points

%% Plotting All Torus Elements that = 5 in FEM

% Declaring the varibles needed for the cross sectional area function

    v = cent2 - cent1;
    
    % Populating the nodal cross sectional area arrays
    xyz = circle3d(r,cent1,v,orientation, n);
    xyz2 = circle3d(r,cent2,v,orientation, n);
% elseif s == 1
%     % Populating the nodal cross sectional area arrays
%     xyz1 = circle3d(r,cent1,v1,orientation, n);
%     xyz2 = circle3d(r,cent2,v2,orientation, n);
% end

% Initialize the plotting arrays

%% Populating the plotting arrays
for j = 1:n;
    if j == n;
        x_plot(1:4,j) = [xyz(j,1), xyz2(j,1), xyz2(1,1), xyz(1,1)]';
        y_plot(1:4,j) = [xyz(j,2), xyz2(j,2), xyz2(1,2), xyz(1,2)]';
        z_plot(1:4,j) = [xyz(j,3), xyz2(j,3), xyz2(1,3), xyz(1,3)]';
           
    else
        x_plot(1:4,j) = [xyz(j,1), xyz2(j,1), xyz2(j+1,1), xyz(j+1,1)]';
        y_plot(1:4,j) = [xyz(j,2), xyz2(j,2), xyz2(j+1,2), xyz(j+1,2)]';
        z_plot(1:4,j) = [xyz(j,3), xyz2(j,3), xyz2(j+1,3), xyz(j+1,3)]';
    end
end

end