%% Import data from video file 
%  Our video files are in a *.cine file format which is a binary encoded
%  file type. We already have a way to extract all the information out of
%  it, but please take a look at it. 

addpath("External Functions\")
addpath("Test Data\")

filename = "Al KClO4 modified.cine";
% filename = "Al KClO4 phi1 20L p89 run 4 512x512 24000 EXP6.cine";
% filename = "Test Data\run000_5L_30_2000fps_490us_dec1_trimmed.cine";

% The most important variable that is returned here is the raw_image_array.
% This is the "raw" image from the camera. For now, I'll add a way for you
% to convert it to a conventional three color image. The other variables
% are metadata about the video file. These are structure files, kind of
% like dictionaries from Python. Properties can be acessed with typical
% object oriented programming. 

[header, bitmap, setup, raw_image_array] = automated_MatCine(filename);

% Video Size Parameters 
im_height = size(raw_image_array, 1);
im_width = size(raw_image_array, 2);
num_images = size(raw_image_array, 3);

% Time in seconds [s] t = (# of frames)/(Frames/Second) 
time_s = (0:1:num_images-1)./(setup.FrameRate);

%% Display Frame(s)
clc

frame = 200;
bayer_pattern = "gbrg";

demosaiced_image = demosaic(raw_image_array(:,:,frame), bayer_pattern);
gray = rgb2gray(demosaiced_image);


ratio = 255/4095;
gain = 3.573;
color_image = uint8(double(demosaiced_image)*ratio*gain);

imshow(color_image);