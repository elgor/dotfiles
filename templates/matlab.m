function [ Result, valid ] = analyzeData( Data, flags )
%ANALYZEDATA Summary of this function goes here
%   Detailed explanation goes here


% Constants to avoid magic numbers
NUMBER_OF_CYCLES = 3;


% create linear vector
time = linspace(1,100,0.1);

% loop for all Datasets
for i=1:length(Data)

	% print on console
	fprintf('Entering round %d of %d\n', i, length(Data))



end



% output
Result = Data;
valid = 1;
