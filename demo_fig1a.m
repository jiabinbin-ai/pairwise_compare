%This is a demo to draw the Fig.1(a) in the follow article:
%B.-B. Jia, J.-Y. Liu, M.-L. Zhang. Pairwise statistical comparisons of multiple algorithms, In: Frontiers of Computer Science, 2025, 19(12): 1912372.
clc;clear;close all;
k = 4;
wtl=[0, 1, -1, 0;...
	-1, 0, -1, 0;...
	1, 1, 0, 1;...
	0, 0, -1, 0];
algo_name = cell(k,1);
for ik=1:k
    algo_name{ik} = ['A',num2str(ik)];
end
pairwise_compare( wtl,algo_name );
%print('wtl','-djpeg','-r300');