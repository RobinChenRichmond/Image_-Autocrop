function autocrop_refinement

%This function finds out the images that are larger than normal size and
%crop them the second time

%the directory of the dataset
folders = dir('/home/gc7xv/Desktop/Result/*');
nfolders = length(folders);

for aa = 3:nfolders
    currentfoldername = folders(aa).name

    files = dir(fullfile('/home/gc7xv/Desktop/Result/',currentfoldername,'*.jpg'));
    nfiles = length(files);

    area = [1:nfiles];
    
    for ii = 1:nfiles
        currentfilename = strcat(num2str(ii),'.jpg');
        A = imread(fullfile('/home/gc7xv/Desktop/Result/', currentfoldername, currentfilename)) ;
        [a,b,c] = size(A);
        area(ii) = a*b;
    end

    medianNumber = median(area);
    
    for jj = 1:nfiles
        currentfilename = strcat(num2str(jj),'.jpg');
        A = imread(fullfile('/home/gc7xv/Desktop/Result/', currentfoldername, currentfilename)) ;
        [a,b,c] = size(A);
        if a*b > 1.8*medianNumber
            
            M = secondcrop(A);
            N = imcrop(A,M);
            [yvalue,xvalue,zvalue] = size(N);
            imshow(N);

            filepath = fullfile('/home/gc7xv/Desktop/Result/',currentfoldername);
            
            set(gcf,'resize','off');
            set(gcf,'position',[0,0,yvalue,xvalue]);
            frm = getframe(gcf);
            imwrite(frm.cdata,fullfile(filepath,strcat(num2str(jj),'.jpg')));
            
            
            fprintf('image %d cropped.   \n' , ...
            jj);
            
        end
    end
    
    
end






end