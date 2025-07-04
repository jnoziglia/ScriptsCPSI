vect_mi = zeros(906, 66);
vect_mi_af = zeros(1064, 66);

for j=1:length(mat_mi_norm_all)
    count = 1;
    tri = triu(squeeze(mat_mi_norm_all(j,:,:)), 1);
    for k=1:length(tri)
        for l=1:length(tri)
            if(tri(k,l) > 0)
                vect_mi(j, count) = tri(k,l);
                count = count + 1;
            end
        end
    end
end

for j=1:length(mat_mi_af_all)
    count = 1;
    tri = triu(squeeze(mat_mi_af_all(j,:,:)), 1);
    for k=1:length(tri)
        for l=1:length(tri)
            if(tri(k,l) > 0)
                vect_mi_af(j, count) = tri(k,l);
                count = count + 1;
            end
        end
    end
end

vect_mi(:, 67) = 1;
vect_mi_af(:, 67) = 2;