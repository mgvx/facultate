function [fx, fy, cx, cy, baseline] = getCameraParams()
%getCameraParams returns focal lengths, principal point and baseline values
  fx = 1389.4351/2;
  fy = 1412.95/2;
  cx = (635.34601-16)/2;
  cy = (341.39502-13.5)/2;
  baseline =  0.12*2;
end

