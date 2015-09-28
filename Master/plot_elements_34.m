function plot_elements_34(plot_tor,Connect, x,y,z)
% plot_other_elements
% plots elements other than 5

elements=plot_tor.el_type;
for j=1:numel(elements)
    if elements(j) == 3
        color = 'g-';
    else color='b-';
    end
    for i=1:size(x,1)
       if Connect(i,3) == elements(j)
            plot3(x(i,:),y(i,:),z(i,:),color,'linewidth',1)
       end
    end
end
end
      


