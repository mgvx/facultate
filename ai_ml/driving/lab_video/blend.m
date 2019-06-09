function [ blended ] = blend( image, disp, alpha )
%blend image and disparity using alpha value
    RgbDisp = ind2rgb(disp, jet(2^11 - 1));
    blended = uint8((alpha * double(image)) + ... 
                   ((1.0-alpha) * double(RgbDisp * 255)));
end

