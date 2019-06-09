file = 'disparity.pgm'
D = readDisparity( 'disparity.pgm' );

frame = loadFrame('left.pgm');

blended = blend(frame, D, 0.5);

SCALE_DISP_16bit = 2^5;
SCALE_DISP_8bit = 2^(-4);

imshow(D * SCALE_DISP_16bit);

grid = imread('xz_grid.jpg');
im = imshow(grid);


% how to get at image contents
% gridHandle = imhandles(grid);
% grdiHandle.CData is the image

figure, h = imshow(blended);
set(h, 'ButtonDownFcn', {@dispPlotCallback, D, im, SCALE_DISP_8bit})


function [ x, y, z ] = reconstruct3dpoint( d, u, v )
    [fx, fy, cx, cy, b] = getCameraParams();
    fx = double(fx);
    fy = double(fy);
    cx = double(cx);
    cy = double(cy);
    b = double(b);
    d = double(d);

    z = fx*b/d;
    y = (v-cy)/fy*z;
    x = (u-cx)/fx*z;
end

function [ mx, my, mz ] = generateAll3D(D)
    mx = zeros(size(D));
    my = zeros(size(D));
    mz = zeros(size(D));
    for u = 1:(size(D)(1))
        for v = 1:(size(D)(2))
            d = D(u, v);
            if d > 0
                [x, y, z] = reconstruct3dpoint(d, u, v);
                mx(u, v) = x;
                my(u, v) = y;
                mz(u, v) = z;
            end
        end
    end
end

function [ ] = generateCloud( mx, my, mz )
    scatter3(mz(:), mx(:), my(:), ".")
    xlabel('x')
    ylabel('y')
    zlabel('z')
end

[mx, my, mz] = generateAll3D(D);
generateCloud(mx, my, mz);


