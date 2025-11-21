

XXL = [];

for m = 1:1580
    if ~isempty(data(m).shapeL)

        lat = data(m).ridgelocL(:,1);
        lon = data(m).ridgelocL(:,2);
    
        CC = zeros(size(lat));
        CC(lat>82.5) = 1;
        CC(lat<= 82.5 & wrapTo360(lon)>203.7) = 2;
        CC(lat<= 82.5 & wrapTo360(lon)<=203.7 & wrapTo360(lon)>170) = 3;
        
        if isempty(data(m).date.year)
            year = nan(size(lat));
        else
            year = data(m).date.year.*ones(size(lat));
        end


        if isempty(data(m).date.third)
            third = nan(size(lat));
        else
            third = data(m).date.third.*ones(size(lat));
        end

        if isempty(data(m).date.third)
            month = nan(size(lat));
        else
            month = data(m).date.third.*ones(size(lat));
        end



    
        % if isempty(data(m).age)
        %     age = nan(size(lat));
        % else
        %     age = data(m).age(:,3);
        % end
    
       XXL = [XXL;
            lat, ... %1
            lon, ... %2
            CC, ... %3 region
            data(m).shapeL(:,3), ... %4 shape code
            year, ... %5
            data(m).shapeL(:,1), ... %6
            data(m).shapeL(:,2), ... %7
            data(m).shapeL(:,1)./data(m).shapeL(:,2),... %8
           NaN(size(lat)), ... %9 fill in with age
           data(m).shapeL(:,4), ... %10 max depth
           m*ones(size(lat)), ... %11 index number
           month, ... %12
           third]; %13

    end
end



%% now do it for smalls


XXS = [];

for m = 1:1580
    if ~isempty(data(m).shapeS)

        lat = data(m).ridgelocS(:,1);
        lon = data(m).ridgelocS(:,2);
    
        CC = zeros(size(lat));
        CC(lat>82.5) = 1;
        CC(lat<= 82.5 & wrapTo360(lon)>203.7) = 2;
        CC(lat<= 82.5 & wrapTo360(lon)<=203.7 & wrapTo360(lon)>170) = 3;
        
        if isempty(data(m).date.year)
            year = nan(size(lat));
        else
            year = data(m).date.year.*ones(size(lat));
        end


        if isempty(data(m).date.third)
            third = nan(size(lat));
        else
            third = data(m).date.third.*ones(size(lat));
        end

        if isempty(data(m).date.third)
            month = nan(size(lat));
        else
            month = data(m).date.third.*ones(size(lat));
        end
    
       XXS = [XXS;
            lat, ... %1
            lon, ... %2
            CC, ... %3 region
            data(m).shapeS(:,3), ... %4 shape code
            year, ... %5
            data(m).shapeS(:,1), ... %6
            data(m).shapeS(:,2), ... %7
            data(m).shapeS(:,1)./data(m).shapeS(:,2),... %8
           NaN(size(lat)), ... %9 fill in with age
           data(m).shapeS(:,4), ... %10 max depth
           m*ones(size(lat)), ... %11 index number
           month, ... %12
           third]; %13

    end
end







