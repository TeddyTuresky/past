
% For helping friend do homework assignment

t = input('What is the total amount of money you have to play this game? ');
w = input('How much do you wager? ');

while t >= w
    c = input('Do you want to bet under 7, 7, or over 7? indicate with u, s, or o\n','s');
    Die1=randi(6);
    Die2=randi(6);
    Roll=Die1+Die2;

    if Roll == 7
        A = 's';
    elseif Roll < 7
        A = 'u';
    else
        A = 'o';
    end
    disp(A); disp(c);
    if A == c && A == 's'
        pay = 4*w;
        p = num2str(pay);
        disp(['Congratulations, you have earned $' p '. Spend it wisely.'])
    elseif A == c && A ~= 's'
        pay = w;
        p = num2str(pay);
        disp(['Congratulations, you have earned $' p '. Spend it wisely.'])
    else
        pay = w*-1;
        p = num2str(pay);
        disp('Better luck next time.')
    end
    t = t + pay;
    ts = num2str(t);
    w = input(['You have $' ts ' left. How much do you want to wager? ']);
end

disp('You have sought to wager more than you have. Please restart game.')