%% make Figure 3 in Eilers and Bradley 2025


ratioL = 1./XXL(:,8);
ratioS = 1./XXS(:,8);
widthL = XXL(:,6)./XXL(:,10);
widthS = XXS(:,6)./XXS(:,10);


QCL =  widthL > 0 & XXL(:,10) >= 2;
QCS =  widthS > 0 & XXS(:,10) >= 0.5;

figure(51)



subplot(5,5,1)
yL = ratioL(XXL(QCL,3) == 1 & XXL(QCL,5) >= 2000);
yS = ratioS(XXS(QCS,3) == 1 & XXS(QCS,5) >= 2000);

[cl(1), cs(1)] = maketheplot(yL, yS, 1, 1, '2000s', 'North Pole');

subplot(5,5,2)
yL = ratioL(XXL(QCL,3) == 2 & XXL(QCL,5) >= 2000);
yS = ratioS(XXS(QCS,3) == 2 & XXS(QCS,5) >= 2000);

[cl(2), cs(2)] = maketheplot(yL, yS, 0, 1, '2000s', 'Beaufort');


subplot(5,5,3)
yL = ratioL(XXL(QCL,3) == 3 & XXL(QCL,5) >= 2000);
yS = ratioS(XXS(QCS,3) == 3 & XXS(QCS,5) >= 2000);

[cl(3), cs(3)] = maketheplot(yL, yS, 0, 1, '2000s', 'Chukchi');


subplot(5,5,6)
yL = ratioL(XXL(QCL,3) == 1 & XXL(QCL,5) < 2000 & XXL(QCL,5) >= 1990);
yS = ratioS(XXS(QCS,3) == 1 & XXS(QCS,5) < 2000 & XXS(QCS,5) >= 1990);

[cl(6), cs(6)] = maketheplot(yL, yS, 1, 0, '1990s', ' ');


subplot(5,5,7)
yL = ratioL(XXL(QCL,3) == 2 & XXL(QCL,5) < 2000 & XXL(QCL,5) >= 1990);
yS = ratioS(XXS(QCS,3) == 2 & XXS(QCS,5) < 2000 & XXS(QCS,5) >= 1990);

[cl(7), cs(7)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');

subplot(5,5,8)
yL = ratioL(XXL(QCL,3) == 3 & XXL(QCL,5) < 2000 & XXL(QCL,5) >= 1990);
yS = ratioS(XXS(QCS,3) == 3 & XXS(QCS,5) < 2000 & XXS(QCS,5) >= 1990);

[cl(8), cs(8)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');

subplot(5,5,11)
yL = ratioL(XXL(QCL,3) == 1 & XXL(QCL,5) < 1990 & XXL(QCL,5) >= 1980);
yS = ratioS(XXS(QCS,3) == 1 & XXS(QCS,5) < 1990 & XXS(QCS,5) >= 1980);

[cl(11), cs(11)] = maketheplot(yL, yS, 1, 0, '1980s', ' ');

subplot(5,5,12)
yL = ratioL(XXL(QCL,3) == 2 & XXL(QCL,5) < 1990 & XXL(QCL,5) >= 1980);
yS = ratioS(XXS(QCS,3) == 2 & XXS(QCS,5) < 1990 & XXS(QCS,5) >= 1980);
[cl(12), cs(12)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');


subplot(5,5,13)
yL = ratioL(XXL(QCL,3) == 3 & XXL(QCL,5) < 1990 & XXL(QCL,5) >= 1980);
yS = ratioS(XXS(QCS,3) == 3 & XXS(QCS,5) < 1990 & XXS(QCS,5) >= 1980);

[cl(13), cs(13)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');


subplot(5,5,16)
yL = ratioL(XXL(QCL,3) == 1 & XXL(QCL,5) < 1980 & XXL(QCL,5) >= 1970);
yS = ratioS(XXS(QCS,3) == 1 & XXS(QCS,5) < 1980 & XXS(QCS,5) >= 1970);

[cl(16), cs(16)] = maketheplot(yL, yS, 1, 0, '1970s', ' ');

subplot(5,5,17)
yL = ratioL(XXL(QCL,3) == 2 & XXL(QCL,5) < 1980 & XXL(QCL,5) >= 1970);
yS = ratioS(XXS(QCS,3) == 2 & XXS(QCS,5) < 1980 & XXS(QCS,5) >= 1970);

[cl(17), cs(17)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');

subplot(5,5,18)
yL = ratioL(XXL(QCL,3) == 3 & XXL(QCL,5) < 1980 & XXL(QCL,5) >= 1970);
yS = ratioS(XXS(QCS,3) == 3 & XXS(QCS,5) < 1980 & XXS(QCS,5) >= 1970);

[cl(18), cs(18)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');

subplot(5,5,21)
yL = ratioL(XXL(QCL,3) == 1 & XXL(QCL,5) < 1970 & XXL(QCL,5) >= 1960);
yS = ratioS(XXS(QCS,3) == 1 & XXS(QCS,5) < 1970 & XXS(QCS,5) >= 1960);

[cl(21), cs(21)] = maketheplot(yL, yS, 1, 0, '1960s', ' ');

subplot(5,5,22)
yL = ratioL(XXL(QCL,3) == 2 & XXL(QCL,5) < 1970 & XXL(QCL,5) >= 1960);
yS = ratioS(XXS(QCS,3) == 2 & XXS(QCS,5) < 1970 & XXS(QCS,5) >= 1960);

[cl(22), cs(22)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');

subplot(5,5,23)
yL = ratioL(XXL(QCL,3) == 3 & XXL(QCL,5) < 1970 & XXL(QCL,5) >= 1960);
yS = ratioS(XXS(QCS,3) == 3 & XXS(QCS,5) < 1970 & XXS(QCS,5) >= 1960);

[cl(23), cs(23)] = maketheplot(yL, yS, 0, 0, '1990s', ' ');



subplot(5,5,4)
yL = ratioL(XXL(QCL,9) <= 2.1 & XXL(QCL,5) < 2010 & XXL(QCL,5) >= 2000  );
yS = ratioS(XXS(QCS,9) <= 2.1 & XXS(QCS,5) < 2010 & XXS(QCS,5) >= 2000);

[cl(4), cs(4)] = maketheplot(yL, yS, 0, 1, '', 'FYI');

subplot(5,5,5)
yL = ratioL(XXL(QCL,9) > 2.1 & XXL(QCL,5) < 2010 & XXL(QCL,5) >= 2000  );
yS = ratioS(XXS(QCS,9) > 2.1 & XXS(QCS,5) < 2010 & XXS(QCS,5) >= 2000);

[cl(5), cs(5)] = maketheplot(yL, yS, 0, 1, '', 'MYI');


subplot(5,5,9)
yL = ratioL(XXL(QCL,9) <= 2.1 & XXL(QCL,5) < 2000 & XXL(QCL,5) >= 1990  );
yS = ratioS(XXS(QCS,9) <= 1.1 & XXS(QCS,5) < 2000 & XXS(QCS,5) >= 1990);

[cl(9), cs(9)] = maketheplot(yL, yS, 0, 0, '', 'FYI');

subplot(5,5,10)
yL = ratioL(XXL(QCL,9) > 2.5 & XXL(QCL,5) < 2000 & XXL(QCL,5) >= 1990  );
yS = ratioS(XXS(QCS,9) > 2.5 & XXS(QCS,5) < 2000 & XXS(QCS,5) >= 1990);

[cl(10), cs(10)] = maketheplot(yL, yS, 0, 0, '', 'MYI');

subplot(5,5,14)
yL = ratioL(XXL(QCL,9) <= 2.5 & XXL(QCL,5) < 1990 & XXL(QCL,5) >= 1980  );
yS = ratioS(XXS(QCS,9) <= 2.5 & XXS(QCS,5) < 1990 & XXS(QCS,5) >= 1980);

[cl(14), cs(14)] = maketheplot(yL, yS, 0, 0, '', 'FYI');

subplot(5,5,15)
yL = ratioL(XXL(QCL,9) > 2.5 & XXL(QCL,5) < 1990 & XXL(QCL,5) >= 1980  );
yS = ratioS(XXS(QCS,9) > 2.5 & XXS(QCS,5) < 1990 & XXS(QCS,5) >= 1980);

[cl(15), cs(15)] = maketheplot(yL, yS, 0, 0, '', 'MYI');


cl(25) = 0;
cs(25) = 0;

cl = reshape(cl, 5, 5)';
cs = reshape(cs, 5, 5)';



function [count_l, count_s] = maketheplot(yL, yS, leftedge, topedge, lefttitle, toptitle)
purple = [80, 0, 130]/256;
yellow = [255, 190, 10]/256;

sienna = [222, 107, 72]/256;
melon = [244, 185, 178]/256;
sky = [125, 187, 195]/256;

edges = 0:0.05:1;
middles = (edges(1:end-1)+edges(2:end))/2;
ulim = 0.25;

    cL = histcounts(yL, edges, "Normalization","probability");
    cS = histcounts(yS, edges, "Normalization","probability");
    fill([.45 .45 .55 .55], [0 ulim ulim 0], [0.8 0.8 0.8], 'LineStyle','none')
    
    hold on
    plot(middles, cL, 'LineWidth', 2, 'Color', purple)
    plot(middles, cS, 'LineWidth', 2, 'Color', yellow)

    hold off
    xticks(0:.5:1);
    ylim([0 ulim])
    set(gca, 'FontSize', 15)
    text(0.1, 0.22, num2str(length(yL)), 'Color', purple, 'FontSize',15)
    text(0.1, 0.18, num2str(length(yS)), 'Color', yellow, 'FontSize',15)

    count_l = length(yL);
    count_s = length(yS);
    
    if leftedge
        ylabel(lefttitle, 'FontSize', 20, 'FontWeight','bold')
    end

    if topedge
        title(toptitle, 'FontSize', 20, 'FontWeight','bold')
    end
end


