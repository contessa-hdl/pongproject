fid = fopen(player1data.txt, 'w');
fprinf(fid,'%f',mousePos);
fclose(fid);


fid = fopen(player2data.txt, 'r');
pad2pos = fscanf(fid,'%f',[1,2]);
fclose(fid);