%% Script to generate clumps using the approach of Favier et al (1999) manually
% 2021 © V. Angelidakis, S. Nadimi, M. Otsubo, S. Utili.
clc; clear; close all
addpath(genpath('../functions'))  % Add path to dependencies (external codes)
addpath(genpath('../lib'))  % Add path to dependencies (external codes)

% In this example we demonstrate the clump-generation technique used by Favier et al (1999).
% Axial symmetric particle shapes are generated using the following instructions:
%   1. The axis of symmetry is considered to be the global X axis (Y=0, Z=0)
%   2. Radii are given along the X axis, which are used to generate the axial
%      symmetric body.

clc; clear; close all

%% Option 1: Particle with gradually varying radius
% N=25;
% r1=35; %0.35
% r2=35; %0.1
% x=linspace(-355,365,N)';
% r=linspace(r1,r2,N)';
% 
% r(1:5)   = [45,50,55,55,60];
% r(6:10)  = [60,65,65,70,70];
% r(11:15) = [70,70,70,70,70];
% r(16:20) = flip(r(6:10));
% r(21:25) = flip(r(1:5));
% output='FA_varying_r.txt';

%% Option 2: Cylindrical particle
% N=25;
% length=1.5; %1.7
% x=linspace(0,length,N)';
% r=ones(N,1)*0.15';
% output='FA_cylinder.txt';

%% Option 3: Spheroid (ellipsoid with two equal axes)
N=20;
len=1.5; a=len/2; b=0.5; %(a,b: dimensions of spheroid, assuming a>b)
check_N=true;
x=linspace(-len/2,len/2,N+8)';
r=real(sqrt(b^2/(a^2-b^2)*(a^2-b^2-x.^2)));
x(r==0)=[];
r(r==0)=[];
output='FA_spheroid.txt';


%% Create clump in format [x,y,z,r]
clump=zeros(size(x,1),4);
clump(:,1:4)=[x,zeros(size(x)),zeros(size(x)),r]; 

%% Visualise: Plot clump in Cartesian space
[X,Y,Z]=sphere(40);
% figure()
for i=1:size(clump,1)
	hold on
	xc=clump(i,1);
	yc=clump(i,2);
	zc=clump(i,3);
	rc=clump(i,4);
	h{i}=surf(rc*X+xc, rc*Y+yc, rc*Z+zc, 'FaceColor',rand(1,3), 'EdgeColor','none','FaceAlpha',0.7);
end
axis equal
grid on
camlight

%% Output sphere coordinates in a .txt file
dlmwrite(output, clump, 'delimiter', ',', 'precision', '%10f')