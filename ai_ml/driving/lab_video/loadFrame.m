function [ frame ] = loadFrame( frame_path )
%loadFrame loads a downscaled version of original frame located at frame_path
  
    raw = imread(frame_path);
    heightOffset = 10;
    widthOffset  = 13;
   
    dispWidth = 624;
    dispHeight = 347;
    
    frame = zeros(dispHeight, dispWidth);
    
    for r = 1:(dispHeight)
        for c = 1:(dispWidth)
            % cumulate
            frame(r, c) = 0.5  * (raw(r + heightOffset, 2*c + widthOffset) + raw(r + heightOffset, 2*c + 1 + widthOffset));
            % normalise
            frame(r, c) = frame(r, c);
        end
    end
    
    rgbFrame = zeros(dispHeight, dispWidth, 3, class(raw));
    
    for chan = 1:3
        rgbFrame(:, :, chan) = frame;
    end
    
    frame = uint8(rgbFrame / 2^8);
end

