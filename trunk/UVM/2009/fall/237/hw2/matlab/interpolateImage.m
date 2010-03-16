function interpolateImage()

clf;

imgPath = input('Location of the image: ');

img = imread(imgPath);
imagesc(img)

%Get the number of objects
numObjs = input('How many objects? ');

points = getPoints(numObjs);

objects = cell(1, numObjs);

%For each object...
for i=1:numObjs
    object = cell(1, length(points{i}));
    
    %For each section...
    for j=1:length(points{i})
        %Get all the points for the section
        X = points{i}{j}(:,1);
        Y = -1*points{i}{j}(:,2);
        
        %find the range...
        low = X(1);
        high = X(1);
        if length(X) ~= 1
            for k = 2:length(X)
                if X(k) < low
                    low = X(k);
                end
                if X(k) > high
                    high = X(k);
                end
            end
        end
        
        %Interpolate stuff...
        %Polynomial
        section.range = [low,high];
        section.polyFunction = makePolynomial(X,Y);
        section.cubicSpline = makeNatCubicSpline(X,Y);
        section.linSpline = makeLinSpline(X,Y);
        object{j} = section;
        
        %Linear spline
        
        %Cubic spline
        
    end
    objects{i} = object;
end

%Plot the stuff...
%clear the plot...
clf;
%For each object...
for i=1:length(objects)
    %For each section...
    for j=1:length(objects{i})
        %Plot the polynomial
       subplot(3,1,1)
       hold on;
       s = objects{i}{j};
       fplot(s.polyFunction, s.range);
    end
end

%hold off;

for i=1:length(objects)
    %For each section...
    for j=1:length(objects{i})
        %Plot the cubic spline
        subplot(3,1,2)
        hold on;
        cubicSpline = objects{i}{j}.cubicSpline;
        for k=1:length(cubicSpline)
            fplot(cubicSpline{k}.function, cubicSpline{k}.range);
        end
    end
end
hold off;

hold on;
for i=1:length(objects)
    %For each section...
    for j=1:length(objects{i})
        %Plot the linear spline
        subplot(3,1,3)
        hold on;
        linSpline = objects{i}{j}.linSpline;
        for k=1:length(linSpline)
            fplot(linSpline{k}.function, linSpline{k}.range);
        end
        
    end
end
hold off;

end