function [ output_args ] = projectPoint( grid, point )
    %projectPoint othrographically project point ont grid
    
    %% define grid range for projection
    MAX_Z = 60;
    MIN_Z = 0;
    MAX_X = 10;
    MIN_X = -10;
    SCALE_X = 10;
    SCALE_Z = 10;

    if(point(3) < MIN_Z || point(3) > MAX_Z || point(1) < MIN_X || point(1) > MAX_X)
       disp('selected point cant be visualized (out of bounds)');
    else
       u = (point(1) - MIN_X) * SCALE_X;
       v = (MAX_Z - point(3)) * SCALE_Z;
       grid.CData(uint16(v), uint16(u)) = 255;
    end


end

