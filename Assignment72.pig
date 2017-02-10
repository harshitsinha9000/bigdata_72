//assignment 7.2
//1
dataset = load 'employee_details.txt' using PigStorage(',') as (id:int,name:chararray,salary:int,rating:int);
dataset_rating = order dataset by rating;
dataset_final = LIMIT dataset_rating 5;

//2
dataset_salary = order dataset by salary DESC;
oddid = FILTER dataset_salary BY id%2 !=0;
oddid_3 = LIMIT oddid 3;
dump oddid_3;

//3
dataseta = load 'employee_details.txt' using PigStorage(',') as (id:int,name:chararray,salary:int,rating:int);
datasetb = load 'employee_expenses.txt' AS (id:int,expenses:int);
dataset_joined = JOIN dataseta BY id,datasetb BY id;
max_expenses_top = FOREACH dataset_joined GENERATE dataseta::id,name,expenses;

max_expenses_top1 =  GROUP max_expenses_top BY expenses;
max_expenses_top2 = ORDER max_expenses_top1 by group DESC;
max_expenses_top3 = LIMIT max_expenses_top2 1 ;
max_expenses_top4 = FOREACH max_expenses_top3 GENERATE group,max_expenses_top.name;

//4
dataseta = load 'employee_details.txt' using PigStorage(',') as (id:int,name:chararray,salary:int,rating:int);
datasetb = load 'employee_expenses.txt' AS (id:int,expenses:int);
dataset_joined = JOIN dataseta by id LEFT OUTER ,datasetb by id;
dataset_entry = FILTER dataset_joined BY expenses IS NOT NULL;
dataset_entry = FOREACH dataset_entry GENERATE dataseta::id,name;

//5
dataseta = load 'employee_details.txt' using PigStorage(',') as (id:int,name:chararray,salary:int,rating:int);
datasetb = load 'employee_expenses.txt' AS (id:int,expenses:int);
dataset_joined = JOIN dataseta by id LEFT OUTER ,datasetb by id;
dataset_no_entry = FILTER dataset_joined BY expenses IS NULL;
dataset_no_entry = FOREACH dataset_no_entry GENERATE dataseta::id,name;

