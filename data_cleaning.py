import pandas as pd

data = pd.read_csv('banking_loan_Raw_Data.csv')

data = data.dropna(how='all')

data['Interest_Rate'] = data.groupby("Loan_Type")['Interest_Rate'].transform(lambda x: x.fillna(x.median()))

data['Annual_Income'] = data['Annual_Income'].fillna(
            data['Annual_Income'].median()
)

data['Employment_Type'] = data['Employment_Type'].fillna(
                data['Employment_Type'].mode()[0]
)

data['Credit_Score'] = data.groupby('Risk_Category')['Credit_Score'].transform( lambda y: y.fillna(y.median()))

text_columns = ['Loan_ID','Customer_ID','Loan_Type','Employment_Type','Region','Loan_Status','Risk_Category']

for i in text_columns:
    data[i] = data[i].str.strip()

numerical_columns = ['Loan_Amount','Interest_Rate','Loan_Term_Months','Customer_Age','Annual_Income','Credit_Score','Outstanding_Amount','Repaid_Amount','Days_Past_Due']

for j in numerical_columns:
    data[j] = pd.to_numeric(data[j],errors='coerce')


date_columns = ['Application_Date','Approval_Date']

for k in date_columns:
    data[k] = pd.to_datetime(data[k],errors='coerce')

convert_to_int_dtypes = ['Loan_Amount','Loan_Term_Months','Customer_Age','Annual_Income','Credit_Score','Outstanding_Amount','Repaid_Amount','Days_Past_Due']

for l in convert_to_int_dtypes:
    data[l] = data[l].astype(int)

Removed_inconsistent_data = ['Loan_Type','Employment_Type','Region','Loan_Status','Risk_Category']

for p in Removed_inconsistent_data:
    data[p] = data[p].str.strip().str.title()

# print(data[data['Customer_Age']<18])

# print(data[data['Interest_Rate']<0])

# print(data[data['Loan_Amount']<=0])

# print(data[data['Annual_Income']<=0])

# print(data[data['Loan_Term_Months']<=0])

# print(data[data['Outstanding_Amount']<0])

# print(data[data['Repaid_Amount']<0])

# print(data[data['Days_Past_Due']<0])

# print(data[data['Outstanding_Amount'] > data['Loan_Amount']]) -- Not in case of rejected loan.

# print(data[data['Approval_Date']< data['Application_Date']]) --checking errors that apply date is less than approval date or not.

# print(data[data["Repaid_Amount"] < data["Loan_Amount"]]) -- Not in case of rejected loan.


data['Application_Year'] = data['Application_Date'].dt.year

data['Application_Month'] = data['Application_Date'].dt.month

data['Application_Month_Name'] = data['Application_Date'].dt.strftime('%B')

data['Approval_Year'] = data['Approval_Date'].dt.year

data['Approval_Month'] = data['Approval_Date'].dt.month

data['Approval_Month_Name'] = data['Approval_Date'].dt.strftime('%B')


data["Approval_Year"] = data["Approval_Year"].astype("Int64")


data["Approval_Month"] = data["Approval_Month"].astype("Int64")


data.to_csv('banking_loan_portfolio_cleaned_data.csv',index=False)

















