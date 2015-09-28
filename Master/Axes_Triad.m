function Axes_Triad(x_origin,y_origin,z_origin,length,thickness)

%---------------------------------------------------------------------%
%-                             Axes_Triad                           --%
%-       Creates an axes triad at a specified point showing the     --%
%-                         x,y,and z directions                     --%
%-                          Updated 6/2/2015                        --%
%-                            Project 1263                          --%
%---------------------------------------------------------------------%

% x_origin - specified x coordinate of triad
% y_origin - specified y coordinate of triad
% z_origin - specified z coordinate of triad
% length - length of each triad segment
% thickness - thickness of each triad segment

hold on
h1 = plot3([x_origin,x_origin + length],[y_origin,y_origin],[z_origin,z_origin],'r');
h2 = plot3([x_origin,x_origin],[y_origin,y_origin + length],[z_origin,z_origin],'g');
h3 = plot3([x_origin,x_origin],[y_origin,y_origin],[z_origin,z_origin + length],'b');

text((x_origin + length), y_origin, z_origin, '\bf X')
text(x_origin, (y_origin + length), z_origin, '\bf Y')
text(x_origin, y_origin, (z_origin + length), '\bf Z')

set(h1,'Linewidth',thickness)
set(h2,'Linewidth',thickness)
set(h3,'Linewidth',thickness)
