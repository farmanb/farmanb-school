clear

%Generate 10^6 random radii and angles
%as starting positions for the second bob.
r = (2-eps).*rand(10^6,1);
t = (2*pi).*rand(10^6,1);
a = [];
b = [];

for i=1:10^6
    w = r(i)*exp(j*t(i));
    a(i) = real(w);
    b(i) = imag(w);
    
    %r = norm([x,y]);
    if r(i) > 2
        alpha = 0;
    else
        alpha = acos(r(i)/2);
    end
    beta = atan2(b(i),a(i)) + pi/2;
    theta = [beta+alpha; beta-alpha];
    
    c = cos(theta(1) - theta(2));
    s = sin(theta(1) - theta(2));
    
    j31 = (-cos(theta(1)) - .5*sin(theta(2)))/(1 - .5*c^2) + (c*s*(sin(theta(1)) - .5*c*sin(theta(2))))/((1-.5*c^2)^2);
    j32 = (.5*s*sin(theta(2)) + .5*c*cos(theta(2)))/(1-.5*c^2) + (c*s*(-sin(theta(2)) + c*sin(theta(1))))/((1-.5*c^2)^2);
    j41 = (-s*sin(theta(1)) + c*cos(theta(2)))/(1 - .5*c^2) + (c*s*(sin(theta(2))-c*sin(theta(1))))/((1-.5*c^2)^2);
    j42 = (-cos(theta(2)) + s*sin(theta(1)))/(1-.5*c^2) + (c*s*(-sin(theta(2)) + c*sin(theta(1))))/((1-.5*c^2)^2);
    
    J = [0 0 1 0; 0 0 0 1; j31 j32 0 0; j41 j42 0 0];
    
    z(i) = max(real(eig(J)));
end

scatter(a,b,2,z,'filled');

colorbar('SouthOutside');


