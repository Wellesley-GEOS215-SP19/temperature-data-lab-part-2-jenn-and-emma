function [baseline_model, tempAnnMeanAnomaly, P] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [OUTPUTS] = StationModelProjections(INPUTS) <--update here
%
% DESCRIPTION:
%   **Add your description here**
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    tempAnnMeanAnomaly: Annual mean temperature anomaly, as compared to
%       the 2006-2025 baseline period
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%   **list any other outputs you choose to include**
%
% AUTHOR:   Add your names here!
%
% REFERENCE:
%    Written for GEOS 215: Earth System Data Science, Wellesley College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
stationdata = readtable(filename);
tempData = table2array(stationdata)


%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
% <-- (this will take multiple lines of code - see the procedure you
 yrInd = find(stationdata.Year > 2006 & stationdata.Year < 2025);
 baseline_model(1)= mean(tempData(yrInd,2));
 baseline_model(2)= std(tempData(yrInd,2));

  %followed last week for a reminder of how you can do this)
%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
 tempAnnMeanAnomaly= tempData(:,2)-baseline_model(1);
 anom5year= movmean(tempAnnMeanAnomaly, 5);

%Calculate the linear trend in temperature this station over the modeled 21st century period
 P= polyfit(tempData(:,1), tempAnnMeanAnomaly, 1)

end