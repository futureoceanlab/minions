dataDir = "data/cree";
dist = 15:5:30;
scanRange = 2592/2-1;
intensity = zeros(size(dist, 2), 2);
fList = dir(dataDir);
fList = fList(3:end);
kneeIdx = zeros(1, length(fList));
fov = zeros(1, length(fList));
nSamples = 25;
figure; hold on; 
title("Radial Intensity Profile (Air): Cree Photored & Carclo", 'FontSize', 12); % (XLamp XP-E2)
legendList = [];
for fIdx=3 %1:length(fList)
    file = fList(fIdx);
    C = textscan(file.name, '%s %s %s %d %d %d', 'Delimiter', '_');
    d = double(cell2mat(C(4)));
    img = imread(sprintf('%s/%s', dataDir, file.name));
    rI_raw = computeRadialIntensity(scanRange, [2592/2 1944/2], img);
    rI_raw = rI_raw(1:1275);
    s = reshape(rI_raw,  nSamples, length(rI_raw)/nSamples);
    rI_avg = mean(s);
    topIntensity = rI_avg(1);
    knee = 0.5*topIntensity;
    [~, i] = min(abs(rI_raw-knee));
    kneeIdx(fIdx) = i;
    a = atand((0:(length(rI_avg)-1))*(0.02*nSamples)/d);
    fov(fIdx) = atand(((kneeIdx(fIdx)-1)*0.02)/d);
    plot(a, rI_avg./max(rI_avg), 'LineWidth', 2); 
    legendName = sprintf("%s %s", cell2mat(C{2}), cell2mat(C{3}));
    legendList = [legendList; legendName];
end
xlabel("Angle (deg)");
xlim([0 15]);
ylim([0 1]);
ylabel("Relative Intensity");
legend(legendList);
ax = gca;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
grid on;
hold off;