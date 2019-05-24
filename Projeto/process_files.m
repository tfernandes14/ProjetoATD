Expr={'21','22','23','24','25','26','27','28','29','30'};
User={'10','11','12','13','14','15'};

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