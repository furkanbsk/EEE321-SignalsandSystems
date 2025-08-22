filename = 'animation.gif'; % Name of the gif file

Si=0.25; %resolution
tlim = 10;
tau = -tlim : Si : tlim;
tau_out = -20 : Si : 20;
Nt = length(tau);

%unit step function
u = @(t) double(t>=0);

%define sequences
x = @(t) u(t+5) - u(t-5); %x(t)
h = @(t) u(t+2.5) - u(t-2.5); %h(t)

x_t = x(tau);
h_t = h(tau);
y= convFUNC(x_t,h_t);
h_t_flip = h(-tau);

figure;


subplot(3,1,1);
 plot(y);
 title('Plot of y(t)');
 xlabel('t');
 ylabel('x(t)');
subplot(3,1,2);
 plot(x_t);
 title('Plot of x(t)');
 xlabel('t');
 ylabel('x(t)');
 subplot(3,1,3);
 plot(h_t);
 title('Plot of h(x)');
 xlabel('t');
 ylabel('h(t)');



for ii = 1:length(tau)
    % Update the plot
    subplot(2, 2, 1);
    plot(tau, x_t, 'Color', "#0072BD", 'LineWidth', 1.5);
    xlim([-tlim, tlim]); %tau limits
    ylim([-0.25, 1.25]);
    title('Plot of x(t)');
    xlabel('t');
    ylabel('x(t)');
    
    subplot(2, 2, 2);
    plot(tau, h_t, 'Color', "#77AC30",'LineWidth', 1.5);
    xlim([-tlim, tlim]); 
    ylim([-0.25, 1.25]);
    title('Plot of h(t)');
    xlabel('t');
    ylabel('h(t)');
    
    subplot(2, 2, 3);

    plot(tau, x_t, 'Color', "#0072BD", 'LineWidth', 1);
    hold on;
    plot(tau - 20 + ii/2, h_t_flip, 'Color', "#77AC30", 'LineWidth', 1.5);  
    hold off;
    
    title('Plot of the Animation');
    xlabel('t');
    xlim([-20, 20])
    ylabel('x(t),h(t)');
    ylim([-0.5, 1.5]); % Set y-axis limits
    
    subplot(2, 2, 4);
 
    plot(tau_out(1:4:2*ii-1), y(1:4:2*ii-1) / 4,'Color', "#A2142F", 'LineWidth', 1.5);
    title('Plot of the Convolution');
    xlabel('t');
    ylabel('x(t)*h(t)');
    xlim([-20, 20]); % Set x-axis limits
    ylim([-3, 6]);  

    % Capture the frame
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256); % Convert to indexed image
    
    % Write to GIF file
    if ii == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    end

end


