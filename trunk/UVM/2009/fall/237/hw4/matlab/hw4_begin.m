% Chris Danforth
% 11/3/09

clear all
close all

load hw4data				% load matrix A and two image matrices
whos					% what are my variables

%% USE THIS FOR NUMBER 1
figure					% bring up figure
spy(A); axis([0 40 0 40]);		% showing the top left corner of A
for k = [1 18]
  disp(A(k,:)); disp(sprintf('Sum of row %s of A = %g',int2str(k),sum(full(A(k,:)))));	% entries in row k and sum
end

% show me what the blurred pictures look like
figure 
subplot(2,1,1); imagesc(image_1); axis image; title('Image 1')
subplot(2,1,2); imagesc(image_2); axis image; title('Image 2')


