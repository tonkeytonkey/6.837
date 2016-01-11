function [ h, vol1] = conserveVolume3D(h1,h0,b )

    %assume water is one big blob, no discrete sections that break off
    %this should be true for a smooth "beach", but it may not be true in
    %general

    s=size(b);
    N=s(1,1);
    M=s(1,2); 
    
    %compute old volume
    vol0=0; 
    for nx=1:1:N
        for ny=1:1:M
            if(h0(nx,ny)>b(nx,ny))
                vol0=vol0+(h0(nx,ny)-b(nx,ny));
            end
        end
    end
    
    %compute new volume
    vol1=0; 
    count1=0; 
    for nx=1:1:N
        for ny=1:1:M
            if(h1(nx,ny)>b(nx,ny))
                vol1=vol1+(h1(nx,ny)-b(nx,ny));
                count1=count1+1; 
            end
        end
    end
    
    h=h1; %calculate new height field
        
    dh=(-vol1+vol0)/(count1); %distribute height over cells which 
                                  %have water above ground 
        
    for nx=1:1:N
        for ny=1:1:M
            if(h1(nx,ny)>b(nx,ny))
                h(nx,ny)=h1(nx,ny)+dh; 
            end
        end
    end
        
    %fprintf('old vol %f new vol %f \n',vol0,vol1); 
    
end

