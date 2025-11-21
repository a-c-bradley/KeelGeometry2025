%% Ridge Picking and Shape Identification 

PLOT = 0;


% Loop through each element (track) in the 'data' structure array
for p = 1:length(data) 

    data(p).deformedL = [];
    data(p).deformedS = [];
    data(p).shapeL = [];
    data(p).shapeS = [];
    data(p).ridgeinfoL = [];
    data(p).ridgeinfoS = [];
    data(p).ridgelocL = [];
    data(p).ridgelocS = [];

    X = data(p).raw(:,1); % Horizontal along track
    Y = data(p).raw(:,2); 

     Y_middle = Y; % Copy all draft data to be filtered 

    dY = [diff(Y); 0];
    dY = abs(movmean(dY, 3, 1, "omitmissing"));
    flatice = dY < 0.3 ;
    Y_middle(~flatice) = NaN;  % masking out any sloped ice

    thickice = prctile(Y, 60); % Setting thick ice to be at 60th percentile - was 50th
    thinice = prctile(Y, 5); % Setting thin ice to be at 10th percentile - was 5th
    Y_middle(Y > thickice | Y < thinice) = NaN; % Masking any ice that did not qualify as thin or thick 

    Y_flat = movmean(Y_middle, 10, 1, "omitmissing"); % Apply a moving average (window of 200 points), ignoring NaNs, to get a smoothed draft line
    Y_flat = fillmissing(Y_flat, "linear");

    % Optional plot to visualize filtering process
    if(PLOT)
    figure(p)
        plot(X, Y, '.-', 'MarkerSize', 8, 'Color', '#06080E') % Original draft values
        set(gca, 'ydir', 'reverse')
        hold on
    %    plot(X, Y_middle, 'ob') % Filtered draft values 
        plot(X, Y_flat, '-', 'LineWidth', 2, 'Color', '#4567B0') % Smoothed draft (moving mean) 
 
    end

    
    Z = Y-Y_flat; % Calculating how much the draft deviates from the mean at each point
    Z_altL = Z; % Create a copy for large deformation detection
    Z_altS = Z; % Create a copy for small deformation detection (used below)

% Picking out large ridges

    Z_altL(Z < 1) = -100; % Force values below 1 to a large negative number to simplify peak detection
    [peaksL, indicesL] = findpeaks(Z_altL, "MinPeakHeight", 2, "MinPeakProminence", 1); % Find significant peaks: at least 2m high and prominent by 1m 
    
    % Optional plot to visualize anomalies and detected peaks
 if(PLOT)
        plot(X(Z_altL < 0), Y(Z_altL < 0), '.', 'Color', '#6EA2C4') % Anomalies 
 end


    data(p).deformedL = []; % Initialize storage for deformed segments
    FrontSideL = [];
    BackSideL = [];
    
    for n = 1:length(indicesL)  
        try
            % Search backward from the peak to find the last point where anomaly dropped below threshold
            FrontSideL(n) = find(Z_altL(1:indicesL(n))<0, 1, 'last'); 
        catch
            % If not found, default to the beginning
            FrontSideL(n) = 1;
        end
        
        try
            % Search forward from the peak to find first drop below threshold
            BackSideL(n) = indicesL(n) + find(Z_altL(indicesL(n):end)<0, 1, 'first') - 1; 
        catch
            % If not found, default to end of the profile
            BackSideL(n) = length(Z_altL);
        end
        
        % Optional plot of deformed segment 

        if(PLOT)
            area(X(FrontSideL(n):BackSideL(n)), Y(FrontSideL(n):BackSideL(n)), 'FaceColor', '#AE76A6', 'FaceAlpha', 0.5)
        end

        Z_altS(FrontSideL(n):BackSideL(n)) = NaN; % Mask out detected large deformation region in small copy 
    
        % Add deformed segment
        if isempty(data(p).deformedL) || ...
           ~any(data(p).deformedL(:,1) == FrontSideL(n)) && ~any(data(p).deformedL(:,2) == BackSideL(n))
           data(p).deformedL = [data(p).deformedL; FrontSideL(n), BackSideL(n)];
        end
    
    end

% Picking out small ridges

    Z_altS(Z_altS < 0) = -100;
    [peaksS, indicesS] = findpeaks(Z_altS, "MinPeakHeight", 0.5, "MinPeakProminence", 2);


    data(p).deformedS = [];
    FrontSideS = [];
    BackSideS = [];

    for n = 1:length(indicesS)
    
        try
            FrontSideS(n) = find(Z_altS(1:indicesS(n))<0, 1, 'last'); 
        catch
            FrontSideS(n) = 1;
        end
    
        try
            BackSideS(n) = indicesS(n) + find(Z_altS(indicesS(n):end)<0, 1, 'first') -1; 
        catch
            BackSideS(n) = length(Z_altS);
            
        end

        if(PLOT)
       area(X(FrontSideS(n):BackSideS(n)), Y(FrontSideS(n):BackSideS(n)), 'FaceColor', '#993955', 'FaceAlpha', 0.5)
        end
    
    
        % Add deformed segment 
        if isempty(data(p).deformedS) || ...
           ~any(data(p).deformedS(:,1) == FrontSideS(n)) && ~any(data(p).deformedS(:,2) == BackSideS(n))
           data(p).deformedS = [data(p).deformedS; FrontSideS(n), BackSideS(n)];
        end

    end

% Shape identification for large ridges 

    % Initialize storage 
    data(p).shapeL = [];
    data(p).ridgeinfoL = []; 
    data(p).ridgeregionL = [];
    data(p).ridgelocL = [];  

    for n = 1:length(data(p).deformedL) 
        if length(data(p).deformedL) > 2 
            % Finding the corresponding along-track distances for the deformed segment
            W = X(data(p).deformedL(n,1):data(p).deformedL(n,2)); 
            % Assigning ridge width to be the difference between the first and last along-track distance of the segment
            Wcalc = W(end) - W(1); 
            % Finding the corresponding drafts for the deformed segment 
          %  H = Z_altL(data(p).deformedL(n,1):data(p).deformedL(n,2));  
            snipY = Y(data(p).deformedL(n,1):data(p).deformedL(n,2));
            H = snipY - max(snipY(1), snipY(end));
          % check here whether it is z_altL doing something weird?
            % Setting all drafts less than 0 equal to 0
            H(H < 0) = 0; 
            % Finding the maximum draft (maximum keel depth) 
            [maxH, maxIdx] = max(H); 
            % Locating the maximum keel depth in the original indexing
            OGmaxIdxL = data(p).deformedL(n,1) + maxIdx - 1; 
    
            % Shape classification 
            if length(H)>2
                % Finding the "area" based on width and maximum depth 
                calcA = Wcalc*maxH; 
                % Integrating over the width and depth
                intA = trapz(W', H);  
                ratioA = intA/calcA;
                % If K_A (keel area coefficient) is greater than 0.45 times
                % the W*H and less than 0.55 times the W*H, classify as
                % triangle (1)
                if intA >= 0.45*calcA && intA <= 0.55*calcA 
                    shape = 1; % triangle
                % If K_A is less than 0.45 times W*H, classify as cusp (2)
                elseif intA < 0.45*calcA 
                    shape = 2;
                % If K_A is greater than 0.55 times W*H, classify as
                % trapezoid (3)
                elseif intA > 0.55*calcA  
                    shape = 3;
                else
                    shape = 0; 
                end
            
                shapevec = 'VYU';
                % If a shape is 1, 2, or 3, save result with additional information 
                if shape > 0   
                     data(p).shapeL = [data(p).shapeL; calcA, intA, shape, maxH];

                     if(PLOT)
                     snip = data(p).deformedL(n,1):data(p).deformedL(n,2);
                     xes = [X(snip); flipud(X(snip))];
                     yupper = max(Y(snip), max(Y(snip(1)), Y(snip(end))));
                     yes = [yupper; max(Y(snip(1)), Y(snip(end)))*ones(size(Y(snip)))];
                     yes(yes > 40) = 0;
                     fill(xes, yes , hex2rgb('#AE76A6'), 'FaceAlpha', 0.9)
                     text(X(data(p).deformedL(n,1)+ maxIdx)+10, maxH, shapevec(shape), 'FontSize', 20);

                     end

                end
            end
            
            % Extract ridge information and organize in a field within the
            % data structure 
            if ~isempty(data(p).lat)
                year = data(p).date.year;
                month = data(p).date.mon;
                third = data(p).date.third; 
                lat = data(p).lat(OGmaxIdxL);
                lon = data(p).lon(OGmaxIdxL); 
                region = regionpicker(lat, lon);
            end
            
            if shape > 0 
                data(p).ridgeinfoL = [data(p).ridgeinfoL; year, month, third, shape];
                data(p).ridgeregionL{end+1} = region;
                data(p).ridgelocL = [data(p).ridgelocL; lat, lon];
            end
        end
    
    end

% Shape identification for small ridges 
 
    data(p).shapeS = [];
    data(p).ridgeinfoS = []; 
    data(p).ridgeregionS = [];
    data(p).ridgelocS = [];

    for n = 1:length(data(p).deformedS) 
        if length(data(p).deformedS) > 2
            W = X(data(p).deformedS(n,1):data(p).deformedS(n,2)); 
            Wcalc = W(end) - W(1); 
            snipY = Y(data(p).deformedS(n,1):data(p).deformedS(n,2));
            H = snipY - max(snipY(1), snipY(end));
            H(H < 0) = 0;
            [maxH, maxIdx] = max(H);
            OGmaxIdxS = data(p).deformedS(n,1) + maxIdx - 1;
    
            if length(H)>2
                calcA = Wcalc*maxH; 
                intA = trapz(W', H);
                if intA >= 0.45*calcA && intA <= 0.55*calcA 
                    shape = 1;  % triangle
                elseif intA < 0.45*calcA 
                    shape = 2;  % cusp
                elseif intA > 0.55*calcA
                    shape = 3;  % trapezoid
                else
                    shape = 0;
                end
            
                if shape > 0 
                     data(p).shapeS = [data(p).shapeS; calcA, intA, shape, maxH];
                     if(PLOT)
                     snip = data(p).deformedS(n,1):data(p).deformedS(n,2);
                     xes = [X(snip); flipud(X(snip))];
                     yes = [Y(snip); min(Y([snip(1) snip(end)]))*ones(size(Y(snip)))];
                     yes(yes > 40) = 0;
                     fill(xes, yes , hex2rgb('#993955'), 'FaceAlpha', 0.9)
                    text(X(data(p).deformedS(n,1)+ maxIdx) + 10, maxH, shapevec(shape), 'FontSize', 20)
                     end

                
                end
            end
    
            
            if ~isempty(data(p).lat)
                year = data(p).date.year;
                month = data(p).date.mon;
                third = data(p).date.third;
                lat = data(p).lat(OGmaxIdxS);
                lon = data(p).lon(OGmaxIdxS); 
                region = regionpicker(lat, lon);
            end
            
            if shape > 0 
                
                data(p).ridgeinfoS = [data(p).ridgeinfoS; year, month, third, shape];
                data(p).ridgeregionS{end+1} = region;
                data(p).ridgelocS = [data(p).ridgelocS; lat, lon];
            end
        end
    end


    data(p).Z_altL = Z_altL;
    data(p).Z_altS = Z_altS;
    data(p).Y_flat = Y_flat;

    if mod(p, 100) ==0
        disp(p)
    end
end


if(PLOT)
set(gca, 'FontSize', 15)
xlabel('Along track distance (m)')
ylabel('Depth (m)')
grid on

xlim([0 500])
end