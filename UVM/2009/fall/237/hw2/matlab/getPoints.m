function points = getPoints(numObjs)

%Container for the functions.
points = cell(1,numObjs);

%Get the points for each interpolated object.
for i=1:numObjs
    %Figure out how many sections needed for the object.
    disp(strcat('Object #', int2str(i)));
    numSections = input('How many sections? ');
    tempVec = cell(1,numSections);
    
    %For each section, get the points
    for j=1:numSections
        disp(strcat('Section #', int2str(j)));
        numPoints = input('How many points? ');
        
        %Save the points for each section.
        tempVec{j} = ginput(numPoints);
    end
    
    %Save the points for each object
    points{i} = tempVec;
end

end