clc;clear;
load('A:\OneDrive - Nexus365\Work\Papers\DAXM\Experiment\Slip\DAXM\SB5-fine-result-reindex_height40_strain.mat','Maps_new')

% %%
% Maps_new.X = Maps_new.X(2:6,1:5,1:7);    Maps_new.Y = Maps_new.Y(2:6,1:5,1:7);    
% Maps_new.Z = Maps_new.Z(2:6,1:5,1:7);
% Maps_new.Intensity_rect = Maps_new.Intensity_rect(2:6,1:5,1:7);      
% Maps_new.phi1_rect = Maps_new.phi1_rect(2:6,1:5,1:7);
% Maps_new.Phi_rect  = Maps_new.Phi_rect(2:6,1:5,1:7);  
% Maps_new.phi2_rect = Maps_new.phi2_rect(2:6,1:5,1:7);

%%
xx = unique(Maps_new.X);     yy = unique(Maps_new.Y);     zz = unique(Maps_new.Z);
[X, Y, Z] = meshgrid(1:length(unique(Maps_new.X)),1:length(unique(Maps_new.Y)), ...
                     1:length(unique(Maps_new.Z)));
ebsd_data = [[1:length(Maps_new.X(:))]'     ones(size(Maps_new.X(:)))      X(:)  Y(:)  Z(:) ...
            deg2rad(Maps_new.phi1_rect(:))  deg2rad(Maps_new.Phi_rect(:))	...
            deg2rad(Maps_new.phi2_rect(:)) ...
            Maps_new.Intensity_rect(:)	Maps_new.Intensity_rect(:)  ones(size(Maps_new.X(:)))];

xdim = length(unique(Maps_new.X(:)));     ydim = length(unique(Maps_new.Y(:)));     
zdim = length(unique(Maps_new.Z(:)));

[ orientation_matricies ] = euler_convert(ebsd_data, xdim, ydim, zdim);
[ nearest_neighbor_misorientation ] = ...
    KAM_calc(ebsd_data,xdim,ydim,zdim,orientation_matricies,1);
[ clean_mat,boundary_mat ] = KAM_clean( nearest_neighbor_misorientation );

% scatter3(X(:),Y(:),Z(:),20,clean_mat(:),'filled')
% Plot3D(clean_mat,X,Y,Z,'mm','KAM')
save('A:\OneDrive - Nexus365\Work\Papers\DAXM\Experiment\Slip\DAXM\SB5-fine-result-reindex_height40_KAM2.mat')
