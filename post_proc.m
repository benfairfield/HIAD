function post_proc(FEM, plot_tor)

for i=1:length(plot_tor)
    if plot_tor(i).n ~= 0
        %Get inputs
        n = plot_tor(i).n;
        n = n+1;
        LS = plot_tor(i).LS;
        scale = plot_tor(i).scale;

        Connect = FEM.GEOM.connect;
        nodes = FEM.GEOM.nodes;
        F = FEM.BOUND.F;
        FEM.OUT.U(1:size(FEM.OUT.Uinc,1)) = FEM.OUT.Uinc(:,LS);
        U = FEM.OUT.U;
        DOF = FEM.ANALYSIS.DOF;
        
        U2 = zeros(length(U)/DOF,DOF);
        F2 = zeros(length(F)/DOF,DOF);
        for j = 1:DOF
            U2(:,j) = U(j:DOF:length(U));
            F2(:,j) = F(j:DOF:length(F));
        end
        FEM.OUT.U2 = U2;
        FEM.BOUND.F2 = F2;
      % CSA
       % Variables
        % Undeformed
        x = [nodes(Connect(:,1),1) nodes(Connect(:,2),1)];

        y = [nodes(Connect(:,1),2) nodes(Connect(:,2),2)];

        z = [nodes(Connect(:,1),3) nodes(Connect(:,2),3)];

        % Deformed
        x1 = [nodes(Connect(:,1),1) + U2(Connect(:,1),1)*scale...
            nodes(Connect(:,2),1) + U2(Connect(:,2),1)*scale];

        y1 = [nodes(Connect(:,1),2) + U2(Connect(:,1),2)*scale...
            nodes(Connect(:,2),2) + U2(Connect(:,2),2)*scale];

        z1 = [nodes(Connect(:,1),3) + U2(Connect(:,1),3)*scale...
            nodes(Connect(:,2),3) + U2(Connect(:,2),3)*scale];
      
        if plot_tor(i).def==1
            x2 = x1;
            y2 = y1;
            z2 = z1;
        else x2 = x;
            y2 = y;
            z2 = z;
        end
        
        for j = 1:size(x2,1)
            orientation = FEM.GEOM.orientation(FEM.GEOM.connect(j,1),:)';
    
             if Connect(j,3) == 5
               
                cent1 = [x2(j,1),y2(j,1),z2(j,1)]';
                cent2 = [x2(j,2),y2(j,2),z2(j,2)]'; 
             

           % run function
            [x_plot(:,n*j-(n-1):n*j),y_plot(:,n*j-(n-1):n*j),...
            z_plot(:,n*j-(n-1):n*j),xyz(n*j-(n-1):n*j,:)] = ...
            Circular_Cross_Section(cent1,cent2,orientation,FEM.CONFIG.r,n);
             end
        end
        x_plot=x_plot(:,1:size(Connect(Connect(:,3)==5),1)*n);
        y_plot=y_plot(:,1:size(Connect(Connect(:,3)==5),1)*n);
        z_plot=z_plot(:,1:size(Connect(Connect(:,3)==5),1)*n);
        xyz=xyz(1:size(Connect(Connect(:,3)==5),1)*n,:);
 
     %Color matrices
        if plot_tor(i).plot_type == 1
            
            % Initialize color matrices 
            x_color0 = zeros(size(U2,1),n);
            y_color0 = zeros(size(U2,1),n);
            z_color0 = zeros(size(U2,1),n);
            c_color0 = zeros(size(U2,1),n);
            
            % Populate color matrices
            for k=1:size(U2,1)
                if Connect(i,3) == 5
                    % Populate color matrices
                    x_color0(k,:) = U2(k,1);
                    y_color0(k,:) = U2(k,2);
                    z_color0(k,:) = U2(k,3);
                    c_color0(k,:) = sum(U2(k,1:3).^2)^.5; % sum(abs(U2(k,1:3))); % 
                end
            end
            
            % Determine specific color matrix
            if plot_tor(i).u_comp == 1
                color_plot0=x_color0;
            elseif plot_tor(i).u_comp == 2
                color_plot0=y_color0;
            elseif plot_tor(i).u_comp == 3
                color_plot0 = z_color0;
            else color_plot0 = c_color0;
            end
            % Transpose color matrix
            color_plot1 = color_plot0';
            %Vectorize color matrix
            color_plot2 = color_plot1(:);
            % Transpose color vector
            color_plot3 = color_plot2';
            
            % Create final color matrix
            color_plot = [color_plot3(1:end - n)
                color_plot3(n + 1:end)
                color_plot3(n + 1:end)
                color_plot3(1:end - n)];
            
%             if size(color_plot,2) ~= size(x_plot,2)
            if numel(unique(Connect(:,3)))>1
                color_plot=color_plot(1:4,1:size(x_plot,2)-n);
                for j=1:n
                color_plot(1:4,end+i) = [color_plot(2,end-(n-i))
                    color_plot(1,1+i-1)
                    color_plot(4,1+i-1)
                    color_plot(3,end-(n-i))];
                end
            end
        else 
            color_plot = 0;
        end
        
     % Plot the figure
        figure(plot_tor(i).fig)
        hold on
        plot_elements_5(x_plot, y_plot, z_plot, xyz, color_plot,plot_tor(i))

    %Plot elements other than 5 
    if numel(unique(Connect(:,3))) ~= 1
       if isempty(plot_tor(i).el_type) == 0
          plot_elements_34(plot_tor(i),Connect,x2,y2,z2)
       end
    end

    % Plot forces
       if plot_tor(i).PF == 1
          plot_forces(FEM,plot_tor(i).scale)
       end

    % axes 
        if plot_tor(i).triad == 1;
            triad_loc = plot_tor(i).triad_loc;
            Axes_Triad(triad_loc(1), triad_loc(2), triad_loc(3),10,3)
        end
        if plot_tor(i).axis==0
            axis off
        end
        axis equal

    %view of torus
        view_orient(plot_tor(i).view)

    % Helps speed up rotating figure
           set(plot_tor(i).fig,'renderer','opengl')

    end
end
end