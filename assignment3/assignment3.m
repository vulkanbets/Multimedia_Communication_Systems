clc
clear all
close all

video_frames = VideoReader('walk_qcif.avi');

for m=6:10
    if(m == 6) reference_frame = read(video_frames, m);
    else reference_frame = target_frame; end
    target_frame = read(video_frames, m + 1);
    
    reference_frame_y = reference_frame(:,:,1);
    target_frame_y = target_frame(:,:,1);
    
    % Divide the target frame into 16x16 Macro Blocks
    macro_blocks = mat2cell(target_frame_y, [16 16 16 16 16 16 16 16 16], [16 16 16 16 16 16 16 16 16 16 16]);
    % Divide the target frame into 16x16 Macro Blocks
    
    x1_matrix = [];
    x2_matrix = [];
    y1_matrix = [];
    y2_matrix = [];
    error_frame = zeros(144, 176, 'uint8');
    for y=1:9
        for x=1:11
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
            center_x = x_left_direction + 1;
            center_y = y_up_direction + 1;
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
            x_value = center_x - u;
            y_value = center_y - v;
            x1_matrix = [x1_matrix, MB_x];
            x2_matrix = [x2_matrix, x_value];
            y1_matrix = [y1_matrix, MB_y];
            y2_matrix = [y2_matrix, y_value];
            
            % Best Match Macro Block
            best_match_macro_block = search_window(v:v+15, u:u+15);
            % Best Match Macro Block
            
            % Error Macro Block
            error_macro_block = MB - best_match_macro_block;
            % Error Macro Block
            
            % Append to Error Frame
            error_frame((y-1)*16 + 1:(y-1)*16 + 16, (x-1)*16 + 1:(x-1)*16 + 16) = error_macro_block;
            % Append to Error Frame
        end
    end
    
    if(m==8)
        figure();
        quiver(x1_matrix, y1_matrix, x2_matrix, y2_matrix, 0.5);
        title('Motion Vectors Frame');

        figure();
        imshow(error_frame);
        title('Error Frame');

        % Reconstruct the Frame
        reconstructed_frame = error_frame + reference_frame_y;
        % Reconstruct the Frame

        figure();
        imshow(target_frame_y);
        title('Target Frame');

        figure();
        imshow(reconstructed_frame);
        title('Reconstructed Frame');
    end
end

