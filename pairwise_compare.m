function pairwise_compare( wtl,algo_name, para )
%This function draws the pairwise statistical comparison plot designed in [1]
%Type 'help pairwise_compare' under Matlab prompt for more detailed information about this function
%
%	Syntax
%
%       pairwise_compare( wtl,algo_name, para )
%
%	Description
%
%   pairwise_compare takes,
%       wtl         - An kxk matrix, wtl(i,j)=+1/-1 denotes the ith
%       algorithm is better/worse than the jth algorithm and wtl(i,j)=0
%       denotes no significant difference exists in their performance
%       (NOTE: This function only uses the upper left part of the matrix)
%       algo_name   - An kx1 cell, algo_name{i} stores the name of the ith algorithm
%       para        - A struct where
%                       para.ratio is a scalar or a length-k vector that
%                       determines the position of each algorithm's name (default: 0.1)
%                       para.font is scalar that determine the font size of
%                       each algorithm's name (default: 20)
%
%  [1] B.-B. Jia, J.-Y. Liu, M.-L. Zhang. Pairwise statistical comparisons of multiple algorithms, In: Frontiers of Computer Science, 2025, 19(12): 1912372.

    if nargin<3
        para.ratio = 0.1;
        para.font = 20;
    end
    k = length(algo_name);
    radius = 1;
    ratio = para.ratio;
    %Calculate the vertices of an equilateral polygon (#sides = k)
    if mod(k,2)
        theta = linspace(0.5*pi, 2.5*pi, k+1); %k+1 uniformly distributed angles
    else
        bias = 2*pi/k/2;
        theta = linspace(0.5*pi+bias, 2.5*pi+bias, k+1); %k+1 uniformly distributed angles
    end
    x = radius * cos(theta);
    y = radius * sin(theta);

    %Create an equilateral polygon with k sides
    figure;hold on;
    for ii=1:k
        drawpoint([x(ii),y(ii)]);
        if length(ratio)==k
            ratio_ii = ratio(ii);
        elseif length(ratio)==1
            ratio_ii = ratio;
        else
            error('Incorrect input for para.ratio');
        end
        if x(ii)>1e-6
            txt_loc_x = x(ii) + ratio_ii*radius;
            txt_loc_y = y(ii);
        elseif x(ii)<-1e-6
            txt_loc_x = x(ii) - ratio_ii*radius;
            txt_loc_y = y(ii);
        else
            txt_loc_x = x(ii);
            if y(ii)>0
                txt_loc_y = y(ii) + 0.5*ratio_ii*radius;
            else
                txt_loc_y = y(ii) - 0.5*ratio_ii*radius;
            end
        end
        text_details = algo_name{ii};
        text(txt_loc_x,txt_loc_y,text_details,'HorizontalAlignment','center','FontSize',para.font);
    end

    for i1=1:k-1
        for i2=i1+1:k
            switch wtl(i1,i2)
              case -1
                drawarrow([x(i2),y(i2)],[x(i1),y(i1)]);
              case 0
                drawline([x(i1),y(i1)],[x(i2),y(i2)]);
              case +1
                drawarrow([x(i1),y(i1)],[x(i2),y(i2)]);
              otherwise
                disp('error');
            end
        end
    end
    axis off;
    axis equal; %Ensure that the scales of the x-axis and the y-axis are consistent.
end
%The end!