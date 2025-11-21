% this requires having a folder with all of the sea ice age .nc files in
% a folder called AgeData

% Download those from: 
% EASE-Grid Sea Ice Age, Version 4
% Data set id:
% NSIDC-0611
% DOI: 10.5067/UTAV7490FEPB

basename = 'AgeData/iceage_nh_12.5km_%d0101_%d1231_v4.1.nc';


for yy = 1984:2005



    filename = sprintf(basename, yy, yy);

    age_data = ncread(filename, 'age_of_sea_ice');
    lat = ncread(filename, 'latitude');
    lon = ncread(filename, 'longitude');
    
    rind = find(XXS(:,5) == yy);
    for m = 1:length(rind)
                Rlat = XXS(rind(m), 1);
                Rlon = XXS(rind(m), 2);
               disterror = (lat - Rlat).^2 + (lon-Rlon).^2;
               [~, index] = min(disterror, [], 'all', 'omitnan');
               [row, col] = ind2sub(size(lat), index);
        
         switch XXS(rind(m), 13)
            case 1
                Rdate = datenum(yy*ones(1,10), XXS(rind(m), 12)*ones(1,10), 1:10);
            case 2
                Rdate = datenum(yy*ones(1,10), XXS(rind(m), 12)*ones(1,10), 11:20);
            case 3
                Rdate = datenum(yy*ones(1,10), XXS(rind(m), 12)*ones(1,10), 21:30);
            otherwise
                Rdate = [];
         end

         weeks = ceil(dayofyear(Rdate)/7);

           uweeks = unique(weeks);
           ucounts = [];
                       iceage = [];
           for n = 1:length(uweeks) % find how many days in each week to weight by
               ucounts(n) = sum(weeks == uweeks(n));
                iceage(n) = age_data(row, col, uweeks(n));
            end

            XXS(rind(m), 9) = mean(iceage, 'Weights', ucounts);

    end


    % repeat for large ridges

     rind = find(XXL(:,5) == yy);
    for m = 1:length(rind)
                Rlat = XXL(rind(m), 1);
                Rlon = XXL(rind(m), 2);
               disterror = (lat - Rlat).^2 + (lon-Rlon).^2;
               [~, index] = min(disterror, [], 'all', 'omitnan');
               [row, col] = ind2sub(size(lat), index);
        
         switch XXL(rind(m), 13)
            case 1
                Rdate = datenum(yy*ones(1,10), XXL(rind(m), 12)*ones(1,10), 1:10);
            case 2
                Rdate = datenum(yy*ones(1,10), XXL(rind(m), 12)*ones(1,10), 11:20);
            case 3
                Rdate = datenum(yy*ones(1,10), XXL(rind(m), 12)*ones(1,10), 21:30);
            otherwise
                Rdate = [];
         end

         weeks = ceil(dayofyear(Rdate)/7);

           uweeks = unique(weeks);
           ucounts = [];
                       iceage = [];
           for n = 1:length(uweeks) % find how many days in each week to weight by
               ucounts(n) = sum(weeks == uweeks(n));
                iceage(n) = age_data(row, col, uweeks(n));
            end

            XXL(rind(m), 9) = mean(iceage, 'Weights', ucounts);

    end





disp(yy)

end