x = rand(1, 100);
y = x;

%%%%% Cross Correlation 
cross1 = xcorr(x, y);
%%%%% Shifting The Points In The Vector
y = circshift(y, [0, 10]);

%%%%% Plotting The Graph
plot(cross1);
%%%%% Tell It To Keep Displaying
hold on;
%%%%% Cross Correlation 
cross2 = xcorr(x, y);

%%%%% Now Find The Peak
middle = length(x);
%%%%% Where The Window Of Variables You Want To See Is
theWindow = middle - 20 : middle + 20;

%%%%% Find The Max Height
theMax = max(cross2);
thePeak = find(cross2 == theMax) - middle;

%%%%% Plotting The Windowed View
plot(theWindow - middle, cross2(theWindow));

display(['The Peak Is At : ' num2str(thePeak)]);
display(['The Max Is At  : ' num2str(theMax)]);
%%%%% Displays Vector
display(x);



