clear all
close all
clc

Expr={'21','22','23','24','25','26','27','28','29','30'};
User={'10','11','12','13','14','15'};

infoFch = cell(1, 10);

process_raw_data(Expr{1,1}, User{1,1})
pause()
j=2;
for i=2:(size(User,2)-1)
    process_raw_data(Expr{1,j}, User{1,i})
    pause()
    j=j+1;
    process_raw_data(Expr{1,j}, User{1,i})
    pause()
    j=j+1;
end
process_raw_data(Expr{1,size(Expr,2)}, User{1,size(User,2)})

[aac_x, aac_y, aac_z, aac_x_hamming, aac_y_hamming, aac_z_hamming, aac_x_hann, aac_y_hann, aac_z_hann, aac_x_blackman, aac_y_blackman, aac_z_blackman] = process_raw_data_novo(expr, usr)
