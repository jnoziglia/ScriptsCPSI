function my_vec=matrix_to_vec(DATA)
l=1;
[fil, ~]=size(DATA)
for j=2:fil
    for k=1:fil
        my_vec(l)=DATA(j,k);
        l=l+1;
    end
end