N_range = 100:300:10000;
t = -10000:0.001:10000;

u = @(t) double(t>=0);
a = [0,0.05,0.10,0.25,0.5];
disp(a(1));
n=0; 
for i = 1:length(a)
sgtitle("BIBO Stability Test");


subplot (5, 1, i);                   
f_f = exp(-t * (a(i)));
h = f_f .* u(t);
y = sumElements(h, N_range);
stem(N_range, y);

if i == 1
    title("Discrete version of the Ideal Integrator 'a = 0' ");
else
    title(['a =',' ',num2str(a(i))]);
end

n = n+1;

end
