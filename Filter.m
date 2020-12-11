I = rgb2gray(imread('input.png'));
I = im2double(I);
a = I;

subplot(2,4,1);
imshow(I);

%laplacian
O=zeros(size(I)+2);
[x,y]=size(O);
O(1+1:x-1,1+1:y-1) = I;

l=[0 1 0; 
   1 -4 1; 
   0 1 0];

p = zeros(size(O));
p1 = zeros(size(O));
p2 = zeros(size(O));

for i = 2:x-1
    for j =2:y-1
        Temp = O(i-1:i+1,j-1:j+1).*l;
        p(i,j)=sum(Temp(:));
    end
end

subplot(2,4,2);
imshow(p,[]);

c = I-p(2:x-1,2:y-1);
subplot(2,4,3);
imshow(c);

%Sobel
sx = [-1 0 1; 
      -2 0 2; 
      -1 0 1];
  
sy = [-1 -2 -1; 
      0 0 0; 
      1 2 1];
  
threshold = 0.1;

for i = 2:x-1
    for j =2:y-1
        Temp2 = O(i-1:i+1,j-1:j+1).*sx;
        p1(i,j)=sum(Temp2(:));
    end
end

for i = 2:x-1
    for j =2:y-1
        Temp3 = O(i-1:i+1,j-1:j+1).*sy;
        p2(i,j)=sum(Temp3(:));
    end
end
filtered_image = sqrt(p1.^2 + p2.^2);
for i = 1:x
    for j =1:y
        if(filtered_image(i,j)<threshold)
            filtered_image(i,j)=0;
        end
    end
end

subplot(2,4,4);
imshow(filtered_image(2:x-1,2:y-1));

%Avg Filter
avg = [1/25 1/25 1/25 1/25 1/25; 
      1/25 1/25 1/25 1/25 1/25;
      1/25 1/25 1/25 1/25 1/25; 
      1/25 1/25 1/25 1/25 1/25;
      1/25 1/25 1/25 1/25 1/25];

O2=zeros(size(filtered_image)+2);
[x,y]=size(O2);
O2(1+1:x-1,1+1:y-1) = filtered_image;

p3 = zeros(size(O2));
  
for i = 3:x-2
    for j =3:y-2
        Temp4 = O2(i-2:i+2,j-2:j+2).*avg;
        p3(i,j)=sum(Temp4(:));
    end
end

e = p3(3:x-2,3:y-2);
subplot(2,4,5);
imshow(e);

%step6
f = c.*e;
subplot(2,4,6);
imshow(f);

%step7
g = a+f;
subplot(2,4,7);
imshow(g);

%power law
c = 1;
gamma = 0.5;

[x,y]=size(g);
h = zeros(size(g));
for i = 1:x
    for j =1:y
        h(i,j) = c.*(g(i,j).^gamma);
    end
end

subplot(2,4,8);
imshow(abs(h));
