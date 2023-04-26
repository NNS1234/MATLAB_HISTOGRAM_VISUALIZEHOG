P_W = [-1, -0.5, -1; -1, 0.5, -1; 1, 0.5, -1; 1, -0.5, -1; -1, -0.5, 1; -1, 0.5, 1; 1, 0.5, 1; 1, -0.5, 1; -1, 0, 1.5; 1, 0, 1.5;];

campoint = [10,10,0; -10,10,0; 0,0,10; 10,0,0; 10,10,10];
for i = 1:1:5
    
    icenter = [50,50,0];
    c = campoint(i,:);
    trx = atan2(norm(cross([1,0,0],(icenter-c))),dot([1,0,0],(icenter-c))); %angle
    trny = atan2(norm(-cross([0,1,0],(icenter-c))),dot([0,1,0],(icenter-c))); 
    trz = atan2(norm(cross([0,0,1],(icenter-c))),dot([0,0,1],(icenter-c)));

    Rtx = [1 0 0; 0 cos(trx) -sin(trx); 0 sin(trx) cos(trx)]; %rotation
    Rty = [cos(trny) 0 sin(trny); 0 1 0; -sin(trny) 0 cos(trny)];
    Rtz = [cos(trz) -sin(trz) 0; sin(trz) cos(trz) 0; 0 0 1];

    R = Rtz*Rty*Rtx; 
    
    figure;
    Cam = project_points(P_W, R, campoint(i,:).').';
    plot([Cam(1,1:4) Cam(1,1)], [Cam(2,1:4) Cam(2,1)],'-o', 'Color','g');
    hold on;
    plot([Cam(1,5:8) Cam(1,5)], [Cam(2,5:8) Cam(2,5)], '-o', 'Color','b');
    plot(Cam(1,9:10), Cam(2,9:10), '-o', 'Color','m');

    plot([Cam(1,1) Cam(1,5)], [Cam(2,1) Cam(2,5)], '-o', 'Color', 'r');
    plot([Cam(1,2) Cam(1,6)], [Cam(2,2) Cam(2,6)], '-o', 'Color', 'r');
    plot([Cam(1,3) Cam(1,7)], [Cam(2,3) Cam(2,7)], '-o', 'Color', 'r');
    plot([Cam(1,4) Cam(1,8)], [Cam(2,4) Cam(2,8)], '-o', 'Color', 'r');

    plot([Cam(1,5) Cam(1,9)], [Cam(2,5) Cam(2,9)], '-o', 'Color','m');
    plot([Cam(1,6) Cam(1,9)], [Cam(2,6) Cam(2,9)], '-o', 'Color','m');
    plot([Cam(1,7) Cam(1,10)], [Cam(2,7) Cam(2,10)], '-o', 'Color','m');
    plot([Cam(1,8) Cam(1,10)], [Cam(2,8) Cam(2,10)], '-o', 'Color','m');
    title(strcat('Camera view on ', mat2str(campoint(i,:))));
    hold off 
end
