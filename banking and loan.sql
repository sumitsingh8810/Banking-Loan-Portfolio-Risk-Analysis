CREATE DATABASE banking_loan;

USE banking_loan;

SELECT * FROM banking_loan_table;

-- Q1. Find the total number of loan applications?

SELECT COUNT(*) AS Total_loan_applications FROM banking_loan_table;

-- Q2. Find the number of unique customers who have applied for loans?

SELECT COUNT(DISTINCT Customer_ID) AS Unique_Customers 
FROM banking_loan_table;

-- Q3. Find the total loan amount in the portfolio?

SELECT SUM(Loan_Amount) AS Total_Loan_Amount FROM banking_loan_table;

-- Q4. Find the average, minimum, and maximum loan amount?

SELECT AVG(Loan_Amount) As Average_Loan_Amount,MIN(Loan_Amount) AS Minimum_Loan_Amount,
MAX(Loan_Amount) AS Maximum_Loan_Amount FROM banking_loan_table;

-- Q5. Find the total outstanding amount and total repaid amount?

SELECT SUM(Outstanding_Amount) AS Total_Outstanding_Amount,
SUM(Repaid_Amount) AS Total_Repaid_Amount FROM
banking_loan_table;

-- Q6. Find the average interest rate and average loan term?

SELECT AVG(Interest_Rate) AS Average_Interest_Rate,AVG(Loan_Term_Months)
AS Average_Loan_Term_Months FROM banking_loan_table;

-- Q7. Find the number of loans for each Loan_Status?

SELECT Loan_Status,COUNT(*) AS Total_Number_Of_Loans FROM
banking_loan_table
GROUP BY Loan_Status;

-- Q8. Find the number of loans for each Loan_Type?

SELECT Loan_Type,COUNT(*) AS Total_Number_Of_Loans
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q9. Find the total loan amount for each loan type?

SELECT Loan_Type,SUM(Loan_Amount) AS Total_Amount
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q10. Find the average loan amount for each loan type?

SELECT Loan_Type,AVG(Loan_Amount) AS Average_Total_Amount
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q11. Find the total outstanding amount for each loan type?

SELECT Loan_Type,AVG(Outstanding_Amount) AS Total_Outstanding_Amount
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q12. Find the total repaid amount for each loan type?

SELECT Loan_Type,SUM(Repaid_Amount) AS Total_Repaid_Amount
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q13. Find the average interest rate for each loan type?

SELECT Loan_Type,AVG(Interest_Rate) AS Average_Interest_Rate
FROM banking_loan_table
GROUP BY Loan_Type;

-- Q14. Find the loan type with the highest total loan amount?

WITH table_highest_amount AS (
	SELECT Loan_Type,SUM(Loan_Amount) AS Total_Loan_Type
    FROM banking_loan_table
    GROUP BY Loan_Type
)

SELECT Loan_Type FROM table_highest_amount
WHERE Total_Loan_Type = (
					SELECT MAX(Total_Loan_Type) FROM table_highest_amount
                    );
                    
-- Q15. Find the loan type with the highest outstanding amount?

WITH table_highest_amount AS (
	SELECT Loan_Type,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
    FROM banking_loan_table
    GROUP BY Loan_Type
)

SELECT Loan_Type FROM table_highest_amount
WHERE Total_Outstanding_Amount = (
					SELECT MAX(Total_Outstanding_Amount) FROM table_highest_amount
                    );
                    
-- Q16. Calculate the repayment ratio for each loan type?

SELECT Loan_Type,
				ROUND(SUM(Repaid_Amount)/SUM(Loan_Amount)*100,2) AS Repayment_Ratio
                FROM banking_loan_table
                GROUP BY Loan_Type;
                
-- Q17. Calculate the overall loan approval rate?

SELECT ROUND(
		SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2)
        AS Overall_Approval_Rate
        FROM banking_loan_table;
        
-- Q18. Calculate the overall loan rejection rate?

SELECT ROUND(
				SUM(CASE WHEN Loan_Status = 'Rejected' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2)
                AS Overall_Rejection_Rate
                FROM banking_loan_table;
                
-- Q19. Find the total loan amount associated with each loan status?

SELECT Loan_Status,SUM(Loan_Amount) AS Total_Loan_Amount
FROM banking_loan_table
GROUP BY Loan_Status;
                
-- Q20. Find the loan type with the highest number of rejected applications?

WITH Rejected_Table AS (
SELECT Loan_Type,SUM(CASE WHEN Loan_Status = 'Rejected' THEN 1 ELSE 0 END) AS Number_Of_Rejected_Loans
FROM banking_loan_table
GROUP BY Loan_Type
)

SELECT Loan_Type FROM Rejected_Table
WHERE Number_Of_Rejected_Loans = (
				SELECT MAX(Number_Of_Rejected_Loans) FROM Rejected_Table
                );
                
-- Q21. Find the region with the highest number of approved loans?

WITH Region_Approved_Loans AS (
SELECT Region,SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) AS Number_Of_Approved_Loans
FROM banking_loan_table
GROUP BY Region
)

SELECT Region FROM Region_Approved_Loans
WHERE Number_Of_Approved_Loans = (
			SELECT MAX(Number_Of_Approved_Loans) FROM Region_Approved_Loans
            );
            
-- Q22. Find the monthly number of loan applications?

SELECT Application_Month_Name,COUNT(Loan_ID) AS Monthly_Loan_Applications
FROM banking_loan_table
GROUP BY Application_Month_Name
ORDER BY FIELD(
    Application_Month_Name,
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
);

-- Q23. Find the monthly approved loan amount?

SELECT Approval_Month_Name,SUM(Loan_Amount) AS Total_Approved_Amount
FROM banking_loan_table
WHERE Loan_Status = 'Approved'
GROUP BY Approval_Month_Name
ORDER BY FIELD(
Approval_Month_Name,
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
);

-- Q24. Find the month with the highest number of loan applications?

WITH Highest_Loan_Applications AS (
SELECT Application_Month_Name,COUNT(Loan_ID) AS Monthly_Loan_Applications
FROM banking_loan_table
GROUP BY Application_Month_Name
)
SELECT Application_Month_Name FROM Highest_Loan_Applications
WHERE Monthly_Loan_Applications = (
		SELECT MAX(Monthly_Loan_Applications) FROM Highest_Loan_Applications
        )
ORDER BY FIELD(
    Application_Month_Name,
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
);

-- Q25. Find the number of loans in each Risk_Category?

SELECT Risk_Category,COUNT(Loan_ID) AS Number_Of_Loans
FROM banking_loan_table
GROUP BY Risk_Category;

-- Q26. Find the total outstanding amount for each risk category?

SELECT Risk_Category,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
FROM banking_loan_table
GROUP BY Risk_Category;

-- Q27. Find the average credit score for each risk category?

SELECT Risk_Category,AVG(Credit_Score) AS Average_Credit_Score
FROM banking_loan_table
GROUP BY Risk_Category;

-- Q28. Calculate the default rate for each risk category?

SELECT Risk_Category,ROUND(
				SUM(CASE WHEN Loan_Status = 'Defaulted' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2)
                AS Default_Rate
FROM banking_loan_table
GROUP BY Risk_Category;

-- Q29. Find the risk category with the highest default rate?

WITH Highest_Default_Rate AS (
SELECT Risk_Category,ROUND(
				SUM(CASE WHEN Loan_Status = 'Defaulted' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2)
                AS Default_Rate
FROM banking_loan_table
GROUP BY Risk_Category
)

SELECT Risk_Category FROM Highest_Default_Rate
WHERE Default_Rate = (
			SELECT MAX(Default_Rate) FROM Highest_Default_Rate
            );

-- Q30. Find the average Days_Past_Due for each risk category?

SELECT Risk_Category,AVG(Days_Past_Due) AS Average_Days_Past_Due
FROM banking_loan_table
GROUP BY Risk_Category;

-- Q31. Find all customers who have a credit score below 600 and have a defaulted loan?

SELECT Customer_ID FROM banking_loan_table
WHERE Credit_Score < 600 AND Loan_Status = 'Defaulted';

-- Q32. Find the total outstanding amount for loans that are more than 30 days past due?

SELECT SUM(Outstanding_Amount) AS Total_Outstanding_Amount FROM banking_loan_table
WHERE Days_Past_Due > 30;

-- Q33. Find the number of loans that are more than 90 days past due?

SELECT COUNT(Loan_ID) FROM banking_loan_table
WHERE Days_Past_Due > 90;

-- Q34. Calculate the percentage of loans that are more than 30 days past due?

SELECT ROUND(
		SUM(CASE WHEN Days_Past_Due > 30 THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2) AS  Percentage_Of_Loans
        FROM banking_loan_table;

-- Q35. Find the top 10 customers by total loan amount?

SELECT Customer_ID,SUM(Loan_Amount) AS Total_Loan_Amount FROM banking_loan_table
GROUP BY Customer_ID
ORDER BY Total_Loan_Amount DESC
LIMIT 10;

-- Q36. Find the top 10 customers by outstanding amount?

SELECT Customer_ID,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
FROM banking_loan_table
GROUP BY Customer_ID
ORDER BY Total_Outstanding_Amount DESC
LIMIT 10;

-- Q37. Find customers who have more than one loan?

SELECT Customer_ID
FROM banking_loan_table
GROUP BY Customer_ID
HAVING COUNT(Loan_ID) > 1;

-- Q38. Find customers whose total outstanding amount is greater than their total repaid amount?

SELECT Customer_ID FROM banking_loan_table
GROUP BY Customer_ID
HAVING SUM(Outstanding_Amount) > SUM(Repaid_Amount);

-- Q39. Find the average loan amount by employment type?

SELECT Employment_Type,AVG(Loan_Amount) AS Average_Loan_Amount
FROM banking_loan_table
GROUP BY Employment_Type;

-- Q40. Find the employment type with the highest default rate?

WITH Default_Rate_Table AS (
SELECT Employment_Type,ROUND(SUM(CASE WHEN Loan_Status = 'Defaulted' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2) AS Default_Rate
FROM banking_loan_table
GROUP BY Employment_Type
)

SELECT Employment_Type
FROM Default_Rate_Table
WHERE Default_Rate = (
		SELECT MAX(Default_Rate) FROM Default_Rate_Table
        );
        
-- Q41. Find the total loan amount, outstanding amount, and repaid amount for each region?

SELECT Region,SUM(Loan_Amount) AS Total_Loan_Amount,SUM(Outstanding_Amount) AS Total_Outstanding_Amount,SUM(Repaid_Amount) AS Total_Repaid_Amount
FROM banking_loan_table
GROUP BY Region;        
   
-- Q42. Find the average credit score for each region?

SELECT Region,AVG(Credit_Score) AS Average_Credit_Score FROM banking_loan_table
GROUP BY Region;

-- Q43. Calculate the default rate for each region?

SELECT Region,ROUND(SUM(CASE WHEN Loan_Status = 'Defaulted' THEN 1 ELSE 0 END)/COUNT(Loan_ID)*100,2) AS Default_Rate
FROM banking_loan_table
GROUP BY Region;

-- Q44. Rank all regions based on their total outstanding amount using RANK()?

WITH Region_Table AS (
		SELECT Region,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
        FROM banking_loan_table
        GROUP BY Region
)

SELECT *,
		RANK() OVER(ORDER BY Total_Outstanding_Amount DESC) AS Rank_Of_Amount
        FROM Region_Table;

-- Q45. Find the top 3 customers in each region based on outstanding amount?

WITH Customer_Region_Table AS (
	SELECT Region,Customer_ID,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
    FROM banking_loan_table
    GROUP BY Region,Customer_ID
),
Second_Customer_Table AS(
SELECT Region,Customer_ID,Total_Outstanding_Amount,
	DENSE_RANK() OVER(PARTITION BY Region ORDER BY Total_Outstanding_Amount DESC) AS Rank_Number
    FROM Customer_Region_Table
)
    
SELECT Region,Customer_ID FROM Second_Customer_Table
WHERE Rank_Number IN (1,2,3);

-- Q46. Find the loan type whose average loan amount is greater than the overall average loan amount?

WITH Average_Loan_Amount_Table AS (
SELECT Loan_Type,AVG(Loan_Amount) AS Average_Loan_Type_Amount
FROM banking_loan_table
GROUP BY Loan_Type
)

SELECT Loan_Type FROM Average_Loan_Amount_Table
WHERE Average_Loan_Type_Amount > (
							SELECT AVG(Loan_Amount) FROM banking_loan_table
                            );

-- Q47. Find regions whose outstanding amount is greater than the average outstanding amount across all regions?

WITH Region_Outstanding_Table AS (
SELECT Region,SUM(Outstanding_Amount) AS Total_Outstanding_Amount
FROM banking_loan_table
GROUP BY Region
)

SELECT Region FROM Region_Outstanding_Table
WHERE Total_Outstanding_Amount > (
			SELECT AVG(Total_Outstanding_Amount) FROM Region_Outstanding_Table
            );
                
-- Q48. Calculate the month-over-month change in loan applications?

WITH Month_Over_Month_Table AS (
SELECT Application_Month_Name,COUNT(Loan_ID) AS Total_Number_Applications,
			LAG(COUNT(Loan_ID)) OVER(ORDER BY FIELD(
    Application_Month_Name,
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
)) AS Total_Previous_Number_Applications FROM banking_loan_table
GROUP BY Application_Month_Name
)

SELECT *,ROUND((Total_Number_Applications-Total_Previous_Number_Applications)/NULLIF(Total_Previous_Number_Applications,0)*100,2)
AS Percentage_Change_In_Applications_Number FROM Month_Over_Month_Table;

--  Q49. Find customers whose credit score is below the overall average credit score
--  but whose loan amount is above the overall average loan amount?

WITH table_customers AS (
SELECT Customer_ID,AVG(Credit_Score) AS Average_Score,SUM(Loan_Amount) AS Total_Loan_Amount
FROM banking_loan_table
GROUP BY Customer_ID
)

SELECT Customer_ID FROM table_customers
WHERE Average_Score < (SELECT AVG(Credit_Score) FROM banking_loan_table) AND Total_Loan_Amount > (SELECT AVG(Loan_Amount) FROM
banking_loan_table);











