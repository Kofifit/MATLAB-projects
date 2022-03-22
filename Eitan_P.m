str = 'a salor went To see';
count_mat = {};
str=lower(str);
str = str(find(~isspace(str)));
leters = num2cell('a':'z');
for i = 1:length(str)
    char = length(strfind(str,leters{i}));
    count_mat(end+1,:) = [leters(i) char];
end