 
% Submarine SONAR data available from NSDIC at 
% Submarine Upward Looking Sonar Ice Draft Profile Data and Statistics, Version 1
% Data set id:
% G01360
% DOI: 10.7265/N54Q7RWK


list = dir(fullfile("Copy_of_DIPS", '**','*.series')); % read in every file that ends in .series in the folder
    
    for n = 1:length(list)
        fid = fopen(list(n).name,'r');
        numLines = 33;
        headertext = cell(numLines,1);
        for m = 1:numLines
            headertext(m) = {fgetl(fid)};
        end
        fclose(fid);
        headertext = string(headertext([2:11 15:17 21:29], :)); % identifying header text
        tmp = split(headertext(11)); data(n).date.year = str2num(tmp(end));
        tmp = split(headertext(12)); data(n).date.mon = tmp(end);
        tmp = split(headertext(13)); data(n).date.third = str2num(tmp(end)); 
        tmp = split(headertext(14)); data(n).latitude.start = str2num(tmp(end));
        tmp = split(headertext(15)); data(n).longitude.start = str2num(tmp(end));
        tmp = split(headertext(16)); data(n).latitude.end = str2num(tmp(end));
        tmp = split(headertext(17)); data(n).longitude.end = str2num(tmp(end));
        tmp = data(n).latitude.start + data(n).longitude.start + ...
            data(n).latitude.end + data(n).longitude.end;
        if abs(tmp) > 0
        else
            tmp = split(headertext(12)); data(n).date.year = str2num(tmp(end));
            tmp = split(headertext(13)); data(n).date.mon = tmp(end);
            data(n).date.third = 2; 
            tmp = split(headertext(15)); data(n).latitude.start = str2num(tmp(end));
            tmp = split(headertext(16)); data(n).longitude.start = str2num(tmp(end));
            tmp = split(headertext(17)); data(n).latitude.end = str2num(tmp(end));
            tmp = split(headertext(18)); data(n).longitude.end = str2num(tmp(end));
            tmp = data(n).latitude.start + data(n).longitude.start + ...
                data(n).latitude.end + data(n).longitude.end;

                  if abs(tmp) > 0
                     else
                disp('missing end')
                  end
        end

        tmp = split(headertext(19)); data(n).length = str2num(tmp(end));
        tmp = split(headertext(6)); data(n).rollno = str2num(tmp(end));
          
        data(n).raw =readmatrix(list(n).name, NumHeaderLines=33, FileType="text");

        % interpolating the starting and ending latitude and longitude of
        % each track to assign each data point a coordinate location 
        if length(data(n).latitude.start) > 0 && length(data(n).latitude.end) > 0 &&...
           length(data(n).longitude.start) > 0 && length(data(n).longitude.end) > 0
 
                [data(n).lat, data(n).lon] = gcwaypts(data(n).latitude.start, data(n).longitude.start, data(n).latitude.end, data(n).longitude.end,...
                length(data(n).raw));
                data(n).filename = list(n).name;
        end 

    end
    
end