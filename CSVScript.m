function CSVScript(Input_File)

CSVFileArray = [];

if isempty(Input_File)
    [FileName, FileNamePath]=uigetfile('*.csv','','multiselect','on');
end

CSVFileName = strcat(FileNamePath, FileName);
CSVFileName
CSVFileArray = csvread(CSVFileName, 1, 1);    

whos CSVFileArray

mean(CSVFileArray(1:17, 1:2))
mean(CSVFileArray(18:34, 1:2))
mean(CSVFileArray(35:51, 1:2))
mean(CSVFileArray(52:68, 1:2))

SubtractA_B = CSVFileArray(:, 1) - CSVFileArray(:, 2);

SUM_Target1 = mean(SubtractA_B(1:17))
AVE_Target1 = SUM_Target1 / 17

SUM_Target2 = mean(SubtractA_B(18:34))
AVE_Target2 = SUM_Target2 / 17

SUM_Target3 = mean(SubtractA_B(35:51))
AVE_Target3 = SUM_Target3 / 17

SUM_Target4 = mean(SubtractA_B(52:68))
AVE_Target4 = SUM_Target4 / 17




end