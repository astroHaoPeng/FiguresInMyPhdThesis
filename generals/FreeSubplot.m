function a = FreeSubplot(dxout,dyout,dx,dy,m,n,PositionMode)
% 生成间隔可控的子图，代替subplot的功能

%   created by PH at 2016-04-17:1003 
%   updated by PH at 2016-10-13:1555 @Rutgers 添加了对 2 维 dxout 与 dyout 的支持

% warning('!!! not fully tested yet !!!')

if nargin < 7
    PositionMode = 'OuterPosition';
    disp('Default is "OuterPosition" to avoid overlap.');
    if nargin < 6
        error('not enought input');
    end
end

% dxout = 0.05;
% dyout = 0.05;
% dx = 0.02;
% dy = 0.02;
if length(dxout)==1
    dxout = [dxout, dxout];
end
if length(dyout)==1
    dyout = [dyout,dyout];
end
w = ( 1 - sum(dxout) - (n-1)*dx ) / n;
h = ( 1 - sum(dyout) - (m-1)*dy ) / m;

for ii = 1:m
    for jj = 1:n
        a((ii-1)*n+jj) = axes(PositionMode, [dxout(1)+(jj-1)*(dx+w), dyout(1)+(m-ii)*(dy+h), w, h]);
    end
end

end
