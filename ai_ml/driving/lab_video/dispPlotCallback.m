function [res] = dispPlotCallback (blend, pos, disp, im, scaleDisp)
    grid = imhandles(im);
    uDispIdx = pos.('IntersectionPoint')(1);
    vDispIdx = pos.('IntersectionPoint')(2);
    uInt = uint16(uDispIdx);
    vInt = uint16(vDispIdx);
	
	[fx, fy, cx, cy, base] = getCameraParams();

    %% TODO implement
    
    
	
	point = [0, 0, 0];
    projectPoint(grid, point);
end