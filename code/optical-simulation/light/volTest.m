sCenters = [-30 -15 WD+20;
            -25 -15 WD-20;
            -30 15 WD+20;
            -25 15 WD-20;
            30 15 WD+20;
            30 15 WD-20;
            30 -15 W|D+20;
            30 -15 WD-20;];
shp = alphaShape(sCenters(:, 1), sCenters(:, 2), sCenters(:, 3));
plot(shp);