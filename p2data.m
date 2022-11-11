fid = fopen(player2data.txt, 'w');
fprinf(fid,'%f',mousePos);
fclose(fid);


fid = fopen(player1data.txt, 'r');
pad1pos = fscanf(fid,'%f',[1,2]);
fclose(fid);

% needs to be put in after mouse position is recorded. 
