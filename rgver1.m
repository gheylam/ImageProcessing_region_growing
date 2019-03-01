%Implementing the region growing algorithm for a binary image 

%Read the image 
img = imread('BinaryImage.jpeg'); 
%Convert the image to grayscale 
bwImg = rgb2gray(img);

%record the size of the image 
[m,n] = size(bwImg); 

%declare output image
outputImage = zeros(m, n);

%Threshold value declaration 
threshold = 100; 

%Array of visited pixel locations 
visited = zeros(100); 

%Get the seed from the user input 
seedx = input('please input seed x value'); 
seedy = input('please input seed y value');
%Initialize the queue 
Q = zeros(2,30000);
Q = Q-1;
Q(1,1) = seedx; 
Q(2,1) = seedy; 
next = 1;
currPoint = 1; 
endOfQueue = 1; 
while next ~= -1
    if visited(Q(1, currPoint), Q(2, currPoint)) ~= 1
        if include(bwImg(Q(1,currPoint), Q(2,currPoint)), threshold) == 1
            include(bwImg(Q(1,currPoint), Q(2,currPoint)), threshold)
            %Enqeue the neighbours that we can find
            [Q, endOfQueue] = findN(Q(1, currPoint), Q(2, currPoint), 4, Q, endOfQueue, n, m, bwImg);
            %Modify the output image 
            outputImage(Q(1, currPoint), Q(2, currPoint)) = 255; 
            %Input in the visitedmap that we have visited this node before 
            visited(Q(1, currPoint), Q(2, currPoint)) = 1; 
        end
    end
    %if the next point in Q is -1 then there is no more points to check 
    if Q(1, currPoint+1) == -1
        next = -1;
    else 
        currPoint = currPoint+1;
    end 
end 

subplot(2,1,1); 
imshow(bwImg);
subplot(2,1,2); 
imshow(outputImage);
        
function [N, T] = findN(pointX, pointY, numberOfConnectedComponents, currQ, currQPos, imgMaxX, imgMaxY, img)
    newQ = currQ; 
    if numberOfConnectedComponents == 4 
        %check if there is a pixel above by seeing if it is at the top  
        if pointY ~= 1
            %if there is a point above 
            currQPos = currQPos + 1;
            newQ = enQ(newQ, currQPos, pointX, pointY-1);
        end 
        if pointX ~= imgMaxX
            currQPos = currQPos + 1; 
            newQ = enQ(newQ, currQPos, pointX+1, pointY); 
        end 
        if pointY ~= imgMaxY
            currQPos = currQPos + 1;
            newQ = enQ(newQ, currQPos, pointX, pointY+1);
        end
        if pointX ~= 1
            currQPos = currQPos + 1;
            newQ = enQ(newQ, currQPos, pointX-1, pointY);
        end 
        N = newQ; 
        T = currQPos;
    end
end

function Q = enQ(currQ, currQPos, valueX, valueY)
    currQ(1, currQPos) = valueX; 
    currQ(2, currQPos) = valueY;
    Q = currQ; 
end

function value = include(pixelVal, threshold)
    if pixelVal < threshold 
        value = 0; 
    elseif pixelVal > threshold 
        value = 1; 
    end 
end 


