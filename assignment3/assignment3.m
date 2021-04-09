clc
clear all
close all

video_frames = VideoReader('walk_qcif.avi');

for m=6:6
    if(m == 6) reference_frame = read(video_frames, m);
    else reference_frame = target_frame; end
    target_frame = read(video_frames, m + 1);
    
    reference_frame_y = reference_frame(:,:,1);
    target_frame_y = target_frame(:,:,1);
    
    macro_blocks = mat2cell(target_frame_y, [16 16 16 16 16 16 16 16 16], [16 16 16 16 16 16 16 16 16 16 16]);
    
    
    x = 2;      % Max is 11
    y = 2;      % Max is 9
    if(x == 1) x_left_direction = 0; else x_left_direction = 8; end
    if(x == 11) x_right_direction = 0; else x_right_direction = 8; end
    if(y == 1) y_up_direction = 0; else y_up_direction = 8; end
    if(y == 9) y_down_direction = 0; else y_down_direction = 8; end
    
    search_window = zeros( (16 + y_up_direction + y_down_direction), (16 + x_left_direction + x_right_direction), 'uint8');
    
    search_x = ((x-1)*16) + 1 - x_left_direction;
    search_x_end = ((x-1)*16) + 1 + 16 + x_right_direction;
    search_y = ((y-1)*16) + 1 - y_up_direction;
    search_y_end = ((y-1)*16) + 1 + 16 + y_down_direction;
    
    
    
    search_window = target_frame_y(search_y:search_y_end, search_x:search_x_end);   % Rows vs Columns
    
    
    figure();
    imshow(macro_blocks{y, x});
    title('Current Macro Block');
    figure();
    imshow(search_window);
    title('Search Window of Target Frame');
    figure();
    imshow(target_frame_y);
    title('Entire Target Frame');
    
    
    
    
end





