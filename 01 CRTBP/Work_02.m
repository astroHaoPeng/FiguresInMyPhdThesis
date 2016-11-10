% 画 U(x,y) 的三维示意图
%
%
%   created by PH at 2016-04-xx
% Copyright (c) 2014-2016 Hao Peng (AstroH.Peng@gmail.com). All rights reserved.

mu = 0.0554;

funU = @(x,y,z) 1/2*(x.^2+y.^2) + (1-mu)./((x+mu).^2+y.^2+z.^2).^(1/2) + mu./((x-1+mu).^2+y.^2+z.^2).^(1/2) + 1./2.*mu.*(1-mu);

xmin = (1-mu)/2 - 2.5;
xmax = (1-mu)/2 + 1.5;
ymin = -2;
ymax =  2;
zmin = -1.5;
zmax =  1.5;

Nx = 201;
Ny = 201;
Nz = 201;

Xvec = linspace(xmin,xmax,Nx);
Yvec = linspace(ymin,ymax,Ny);
Zvec = linspace(zmin,zmax,Nz);
[X,Y,Z] = meshgrid(Xvec,Yvec,Zvec);
UU = funU(X,Y,Z);


figure(11);
clf
set(gcf,'Position',[300,300,600,500])


%%
% x>0 y<0 z>0 部分不显示
U1 = UU;
U1( Yvec<0, Xvec>-mu, : ) = NaN;
Cmin = 1;
Cmax = 2;
Cvec = [1.1, 1.4, 1.712, 1.9, 2.2];
% colorvec = lines(length(Cvec));
colorvec = jet(length(Cvec));
for ii = 1:length(Cvec)
    p(ii) = patch(isosurface(X,Y,Z,U1,Cvec(ii)));
    p(ii).FaceAlpha = 0.7;
    p(ii).FaceColor = colorvec(ii,:);
    p(ii).EdgeColor = 'none';
end
axis equal
axis tight
a = gca;
a.View = [24,28];
xlabel('$x$','interpreter','latex','fontsize',15);
ylabel('$y$','interpreter','latex','fontsize',15);
zlabel('$z$','interpreter','latex','fontsize',15);
light;
light; drawnow update;
light; drawnow update;
ii = 1; text(1,-0.1,-1.5,['$J_C=', num2str(Cvec(ii)), '$'],'interpreter','latex','rotation',45,'horizontalalignment','right')
ii = 2; text(1.3,-0.1,-1.5,['$J_C=', num2str(Cvec(ii)), '$'],'interpreter','latex','rotation',45,'horizontalalignment','right')
ii = 3; text(1.55,-0.1,-1.5,['$J_C=', num2str(Cvec(ii)), '$'],'interpreter','latex','rotation',45,'horizontalalignment','right')
ii = 4; text(1.75,-0.1,-1.5,['$J_C=', num2str(Cvec(ii)), '$'],'interpreter','latex','rotation',45,'horizontalalignment','right')
ii = 5; text(1.75,0.7,-1,['$J_C=', num2str(Cvec(ii)), '$'],'interpreter','latex','rotation',45,'horizontalalignment','left')


%% 画边界的线
U2 = UU;
U2(:, Xvec<-mu, :) = NaN;
U2(Yvec>0, :, :) = NaN;
cs = contourslice(X,Y,Z,U2,-mu,0,[],Cvec);
for ii = 1:numel(cs)
    cs(ii).EdgeColor = 'k';
    cs(ii).LineWidth = 1;
end

cs2 = contourslice(X,Y,Z,U1,[],[],[-1.5,1.5],Cvec);
for ii = 1:numel(cs2)
    cs2(ii).EdgeColor = 'k';
    cs2(ii).LineWidth = 1;
end

%%
set(gcf,'PaperPositionMode','auto')
print -dpng Work_02_jet.png -r300
