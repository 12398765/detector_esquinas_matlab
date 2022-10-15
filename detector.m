I=imread("fig.jpg");
Ir=rgb2gray(I);
[m,n] = size(Ir);
v=zeros(size(Ir));
s=zeros(size(Ir));
h=ones(3,3)/9;
Id=double(Ir);
lf= imfilter(Id, h);
Hx= [-0.5 0 0.5];
Hy= [-0.5; 0; 0.5];
Ix=imfilter(lf, Hx);
Iy=imfilter(lf, Hy);
HE11=Ix.*Ix;
HE22=Iy.*Iy;
HE12=Ix.*Iy;

%se crea matriz del filtro dado.
Hg=[0 1 2 1 0; 1 3 5 3 1; 2 5 9 5 2; 1 3 5 3 1; 0 1 2 1 0] * (1/57);
A=imfilter(HE11,Hg);
B=imfilter(HE22,Hg);
C=imfilter(HE12,Hg);
alfa=0.04;
RP= A+B;
RP1=RP.*RP;

%valor de la esquina
Q= ((A.*B)-(C.*C))-(alfa*RP1);
Th=1000;
u= Q>Th;
pixel=10;

for r=1:m
    for c=1:n
        if(u(r,c))
            I1= [r-pixel 1]; %se define el limite izq de la vecindad
            I2= [r+pixel m]; %derecha
            I3= [c-pixel 1]; %superior
            I4= [c+pixel n]; %inferior
            
            datx1=max(I1);
            datx5=min(I2);
            daty1=max(I3);
            daty5=min(I4);
            
            Bloc=Q(datx1:1:datx5, daty1:1:daty5);
            MaxB=max(max(Bloc));
            if (Q(r,c)==MaxB)
                s(r,c)=1;
            end
        end
    end
end

imshow(Ir);
hold on

for r=1:m
    for c=1:n
        if(s(r,c))
            plot(c,r,"x");
        end
    end
end

