function resultV = secondcrop(img)


    result = img;
    [p,q,r] = size(result);


    %cut off the green pixels
    for i = 1:p
        for j = 1:q
            
            if result(i,j,2) > result(i,j,1)+30 & result(i,j,2) < result(i,j,1)+40
                if result(i,j,3) > result(i,j,2)+15 & result(i,j,3) < result(i,j,2)+25
                    result(i,j,:) = 255;
                end
            end
            
            if result(i,j,2) > result(i,j,1) & result(i,j,2) > result(i,j,3)-5
                result(i,j,:) = 255;
            end
            
        end
    end
    
    %find the largest area
    B = uint8(255) - result;
    B = im2bw(B,0.1);
    B = bwareafilt(B,1);
    
    C = result;
    for i = 1:p
        for j = 1:q
            if B(i,j) == 0
                C(i,j,:) = 255;
            end
        end
    end
    
    xmin1 = 0;
    xmax1 = 0;
    ymin1 = 0;
    ymax1 = 0;

    for i = 1:p
        for j = 1:q
            if B(i,j) == 1
                ymin1 = i;
                break
            end
        end
        if ymin1~= 0
            break
        end
    end

    for j = 1:q
        for i = 1:p
            if B(i,j) == 1
                xmin1 = j;
                break
            end
        end
        if xmin1~= 0
            break
        end
    end

    i = p;
    while i > 1
        for j = 1:q
            if B(i,j) == 1
                ymax1 = i;
                break
            end
        end
        if ymax1~= 0
            break
        end
        i = i - 1;
    end

    j = q;
    while j > 1
        for i = 1:p
            if B(i,j) == 1
                xmax1 = j;
                break
            end
        end
        if xmax1~= 0
            break
        end
        j = j - 1;
    end

    wid1 = xmax1 - xmin1;
    leng1 = ymax1 - ymin1;

    result = imcrop(result,[xmin1 ymin1 wid1 leng1]);
    [p,q,r] = size(result);

    % point A
    AAA = false;
    G = 1;
    while G < p-90
        H = 1;
        while H < q-90

            really = true;
            truth = true;

            for aa = G:G+60
                if result(aa,H,:) == 255
                    really = false;
                end
            end

            for bb = H:H+60
                if result(G,bb,:) == 255
                    truth = false;
                end
            end

            if really & truth
                firstX = G+40;
                firstY = H+40;
                AAA = true;
                break;
            end

            H = H + 5;
        end

        if AAA == true
           break;
        end
        G = G+5;
    end


    % point B
    AAA = false;
    G = p;
    while G >90
        H = q;
        while H >90

            really = true;
            truth = true;

            aa = G;
            while aa > G-60 & really
                if result(aa,H,:) == 255
                    really = false;
                end
                aa = aa-1;
            end

            bb = H;
            while bb > H-60 & truth
                if result(G,bb,:) == 255
                    truth = false;
                end
                bb = bb-1;
            end

            if really & truth
                secondX = G-40;
                secondY = H-40;
                AAA = true;
                break;
            end

            H = H-5;
        end

        if AAA == true
           break;
        end
        G = G-5;
    end

    % point C
    AAA = false;
    H = q;
    while H > 90
        G = 1;
        while G < p-90

            really = true;
            truth = true;

            aa = G;
            while aa < G+60 & really
                if result(aa,H,:) == 255
                    really = false;
                end
                aa = aa+1;
            end

            bb = H;
            while bb > H-60 & truth
                if result(G,bb,:) == 255
                    truth = false;
                end
                bb = bb-1;
            end

            if really & truth
                thirdX = G+40;
                thirdY = H-40;
                AAA = true;
                break;
            end

            G = G+5;
        end

        if AAA == true
           break;
        end
        H = H-5;
    end

    % point D
    AAA = false;
    H = 1;
    while H < q-90
        G = p;
        while G > 90

            really = true;
            truth = true;

            aa = G;
            while aa > G-60 & really
                if result(aa,H,:) == 255
                    really = false;
                end
                aa = aa-1;
            end

            bb = H;
            while bb < H+60 & truth
                if result(G,bb,:) == 255
                    truth = false;
                end
                bb = bb+1;
            end

            if really & truth
                fourthX = G-40;
                fourthY = H+40;
                AAA = true;
                break;
            end

            G = G-5;
        end

        if AAA == true
           break;
        end
        H = H+5;
    end

    %locate x and y value
    xValue = [firstY secondY thirdY fourthY];
    yValue = [firstX secondX thirdX fourthX];

    xmin2 = min(xValue)-60
    ymin2 = min(yValue)-60

    xmax2 = max(xValue)+60
    ymax2 = max(yValue)+60
    
    
    wid2 = xmax2 - xmin2;
    leng2 = ymax2 - ymin2;

    resultV = [xmin1+xmin2 ymin1+ymin2 wid2 leng2];
    

end

