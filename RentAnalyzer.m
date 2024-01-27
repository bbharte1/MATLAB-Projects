% Name: Brianna Harte - no partner
% Email: bbharte@ncsu.edu
% Date: 9/7/22
% Lab Section #: 207
% Project 1: Rent and Min Wage Analysis, Fall 2022
clc; clear; close('all');

%% 2.1 Script Name
% Script was named "RentAnalyzer.m" and stored in project folder 

%% 2.2 Load the Input Data


% print options for user
fprintf('File to Analyze\n     (1) nc2018.xlsx\n     (2) nc2022.xlsx\n') 

choice = input('Enter Option: '); % input here 

% for the fprintf function and the graphs at the end
if choice == 1
    year = 2018;
else 
    year = 2022;

end


% switch case on which matrix to read and store as data
% display stars and tell the user which file it is analyzing
switch choice
    case 1
        data = readmatrix('nc2018 CSC 113 Project.xlsx');
        fprintf('\n******************************************************\n');
        fprintf('Analyzing file nc%d.xlsx\n',year);
        fprintf('******************************************************\n\n');
    case 2
        data = readmatrix('nc2022 CSC 113 Project.xlsx');
        fprintf('\n******************************************************\n');
        fprintf('Analyzing file nc%d.xlsx\n',year);
        fprintf('******************************************************\n\n');
end





%% 2.3 Analyzing and Printing Data to the Command Window

% title 
disp('Income and Rent Affordability for full time, 40 hrs/week job')
%display stars
fprintf('*****************************************************************\n')




% 2.3 Part A: For a full time worker earning minimum wage, find:




% get minimin wage data in one variable
min_wage = data(:,4);
% get the minimum wage as a single value
avg_min = mean(min_wage);
% print what the min wage is
fprintf ('\n               Min Wage: %10.2f\n',avg_min)

% a. Total Yearly Income 
T_year_inc = avg_min * 40 * 52;
fprintf('    Total Yearly Income: %10.2f\n', T_year_inc);


% b. Income that can be allocated for rent
%30% of yearly income
for_rent = .30 * T_year_inc;
fprintf('Income for monthly rent: %10.2f\n',for_rent);


% c. Rent Affordability per month
% yearly divided by 12 months
afford = for_rent / 12;
fprintf('     Rent Affordability: %10.2f\n',afford);




% 2.3 Part B: For a Full Time Worker Earning the Average Renters Wage, find:




% get average wage in one variable 
% a. Average Renters Wage
avg_wage = data(:,5);
est_wage = mean(avg_wage);
fprintf ('\n    Average Renter Wage: %10.2f\n',est_wage);

% b. Total Yearly Income
year_avg = est_wage *52 *40;
fprintf('    Total Yearly Income: %10.2f\n', year_avg);

% c. Income that can be allocated for rent 
for_rent_avg = .30 * year_avg;
fprintf('Income for monthly rent: %10.2f\n',for_rent_avg);

% d. Rent Affordability per month
afford_avg = for_rent_avg / 12;
fprintf('     Rent Affordability: %10.2f\n',afford_avg);

%display stars
fprintf('\n*****************************************************************\n')




% 2.3 Part C: Average Fair Market Rent for 2 Bedrooms in NC




% data into one variable
avg_fair = data(:,8);
avg_avg_fair = mean(avg_fair);

%print the statement
fprintf('Average Fair Market Rent for 2 bedroom: %10.2f\n',avg_avg_fair);




% 2.3 Part D:  Determine the Average Housing Wage to afford Part C



avg_housing_wage = (avg_avg_fair) / (40 * .30 * 4.33);
fprintf('         Requires Average Housing Wage: %10.2f\n',avg_housing_wage);





% 2.3 Part E: For a Min Wage Worker determine:





% a. The extra money they need per month to be able to afford Part C
extra = avg_avg_fair - afford;

% b. How many hours they have to work in a week to get part a
extra_hrs = (avg_housing_wage/avg_min)*40;

% print the statement
fprintf('Min Wage Workers need additional: %7.2f and thus work %.2f hrs/week.\n',extra,extra_hrs);




% 2.3 Part F: For an Average Renter Wage Worker, determine:




% a. Extra Money they need per month to afford Part C
extra_avg = avg_avg_fair - afford_avg;

% b. How many hours do they have to work in a week to get extra income
extra_hrs_avg = (avg_housing_wage/est_wage)*40;

% print the statement
fprintf('Avg Wage Workers need additional: %7.2f and thus work %.2f hrs/week.\n',extra_avg,extra_hrs_avg);





%% 2.4 Graphing



% 2.4 Part A: Generate a Figure that has two subplots




% a. subplot 1
figure(1)

% setting x value equal to number of columns in data
len = length(data);
x=1:len;

% setting y values for est. renter wage, minimum wage, and housing wages
y1 = data(:,5);
y2 = data(:,4);
y3 = data(:,8)/(40*.30*4.33);


% first subplot - with scatter plots
subplot(2,1,1);

% Estimated Wages
scatter(x,y1,'b*');

% add grid, axis titles, and hold for additional scatterplot data
grid on;
xlabel('Counties');
ylabel('Dollars Per Hour');
hold on;

% Housing Wage
scatter(x,y3,'dk');
hold on;

% Min Wage plotted as a red line
plot(x,y2,'-r');

% adding a legend 
legend('Estimated Wages','Housing Wages','Min Wage');

% adding titles based off what data was chosen
title('Wages, NC ',year);


% b. subplot 2

%data for the subplot
est_rent_wage = data(:,5);
need_housing_wage = data(:,8) / (40 * .30 * 4.33);

%finding the difference between the two 
difference = est_rent_wage - need_housing_wage;

%placing in new subplot
subplot(2,1,2);

%creating bar graph
bar(x,difference)

%adding labels
xlabel('Counties')
ylabel('Dollars Per Hour')

%adding titles based on data selection 
title('Shortfall between Estimated Wages and Housing Wages, NC',year);




% 2.4 Part B: Generate a Figure




% bar graph of Annual Income Comparison for Avg Income and Renters Income
% data being used
ann_rent = data(:,7);
ann_avg = data(:,6);

% sum for graph based on Estimated Renter household

%find which cells in ann_rent display less than 30000
less30rent = ann_rent <30000;
% the sum of people less than $30000
sumless30rent = sum(less30rent);

%find which cells in ann_rent display >30000 and <35000
less35rent = ann_rent <35000 & ann_rent>30000;
% sum the amount for plotting
sumless35rent = sum(less35rent);

% find which cells in ann_rent display <45000 and >35000
less45rent = ann_rent <45000 & ann_rent >35000;
% sum of people between 35000 and 45000
sumless45rent = sum(less45rent);

%find which cells in ann_rent display <75000 and >45000
less75rent = ann_rent <75000 & ann_rent >45000;
% sum of people between 45000 and 75000
sumless75rent = sum(less75rent);

%find which cells in ann_rent display >75000
great75rent = ann_rent >75000;
% sum of people >75000
sumgreat75rent = sum(great75rent);


%move on to ann_avg data set 

% %find which cells in ann_avg display less than 30000
less30avg = ann_avg <30000;
% the sum of people less than $30000
sumless30avg = sum(less30avg);


%find which cells in ann_avg display >30000 and <35000
less35avg = ann_avg <35000 & ann_avg > 30000;
% sum the amount for plotting
sumless35avg = sum(less35avg);

% find which cells in ann_avg display <45000 and >35000
less45avg = ann_avg <45000 & ann_avg > 35000;
% sum the amount for plotting
sumless45avg = sum(less45avg);

%find which cells in ann_avg display <75000 and >45000
less75avg = ann_avg <75000 & ann_avg > 45000;
% sum the amount for plotting
sumless75avg = sum(less75avg);

%find which cells in ann_rent display >75000
great75avg = ann_avg >75000;
% sum the amount for plotting
sumgreat75avg = sum(great75avg);



%create matrix of sums to graph
graphingmatrix = [sumless30avg,sumless30rent;sumless35avg,sumless35rent;
    sumless45avg,sumless45rent;sumless75avg,sumless75rent;
    sumgreat75avg,sumgreat75rent];

% new figure
figure(2);
% create bar graph
bar(graphingmatrix);

% display features
grid on 
ylabel('Number of Counties')
set(gca, 'XTickLabel',{'Less 30K','Less 35K','Less 45K','Less 75k','Greater 75K'});
legend('Annual Avg Income','Annual Renter Income');

% change title based off of data choice 
title('Annual Income Comparison ',year);










