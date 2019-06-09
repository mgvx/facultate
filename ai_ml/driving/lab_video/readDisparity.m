function [ D_Out ] = readDisparity( file )
%readDisparity: imports disparity map by specifying flags to filter unreliable disparities
%   Detailed explanation goes here

% Output parameters:
%   - D_Out            : matrix containing the real disparity values of the
%                        scene
% -----------------------------------------------------------------------------------------------------------
% Example:
% --- read disparity map ---
% file = 'disparity.pgm';
% D = readDisparity( file );
% figure, imshow(D,colormap(hsv(124)))
% -----------------------------------------------------------------------------------------------------------

    D_Out = imread(file);
    D_Out(D_Out > double(hex2dec('07FF'))) = 0;
 
end

