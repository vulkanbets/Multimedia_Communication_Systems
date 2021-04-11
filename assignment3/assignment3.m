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
    
    
    for x=1:11
        for y=1:9
            if(x == 1) x_left_direction = 0; else x_left_direction = 8; end
            if(x == 11) x_right_direction = 0; else x_right_direction = 8; end
            if(y == 1) y_up_direction = 0; else y_up_direction = 8; end
            if(y == 9) y_down_direction = 0; else y_down_direction = 8; end

            search_x = ((x-1)*16) + 1 - x_left_direction;
            search_x_end = ((x-1)*16) + 16 + x_right_direction;
            search_y = ((y-1)*16) + 1 - y_up_direction;
            search_y_end = ((y-1)*16) + 16 + y_down_direction;

            % This dynamically sets the boundaries for the search window in the !!!reference!!! frame depending on where the macroblock is
            search_window = reference_frame_y(search_y:search_y_end, search_x:search_x_end);
            % This dynamically sets the boundaries for the search window in the !!!reference!!! frame depending on where the macroblock is

            % The extracted macro block from the target frame and the x and y coordinates
            MB = macro_blocks{y, x};
            MB_x = ((x-1)*16) + 1;
            MB_y = ((y-1)*16) + 1;
            % The extracted macro block from the target frame and the x and y coordinates


            % Determine the Best Match Macroblock
            min_SAD = inf;
            for i=1:length(search_window(1,:)) - 15
                for j=1:length(search_window(:,1)) - 15
                    overlay = cat(3, MB, search_window(j:j+15, i:i+15));
                    difference_matrix = overlay(:,:,2) - overlay(:,:,1);
                    cur_SAD = abs( sum( difference_matrix(:) ) );
                    if(cur_SAD < min_SAD)
                        min_SAD = cur_SAD;
                        u = i;
                        v = j;
                    end
                end
            end
            % Determine the Best Match Macroblock
        end
    end
    
    
    
    
    
%     figure();
%     imshow(difference_matrix);
%     title('Difference Matrix');
    
%     figure();
%     imshow(MB);
%     title('Current Macro Block');
%     figure();
%     imshow(search_window);
%     title('Search Window of Reference Frame');
%     figure();
%     imshow(target_frame_y);
%     title('Entire Target Frame');
    
end





