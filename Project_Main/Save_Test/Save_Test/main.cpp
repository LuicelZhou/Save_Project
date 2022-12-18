#include <iostream>  
#include <stdio.h>  
#include <stdlib.h>  
#include <string.h>  
#include<fstream>
#include <iomanip>

#include "winsock2.h"  
#include "windows.h"  
#include "mysql.h"   

using namespace std;


const char host[] = "localhost";    //MySQL IP address
const char user[] = "root";         
const char pswd[] = "Molanlan0738!";         
const char table[] = "save_test";    //database name
unsigned int port = 3306;           //default port number        
MYSQL myCont;                       //MySql connector  
MYSQL_RES* result = NULL;
MYSQL_ROW sql_row;                   //array to store a line of result
MYSQL_FIELD* fd;                    // Structure containing field information
char column[32][32];
int res;



void query_rule(char *query,string filename, string number) {

    ofstream fout(filename, ios::trunc);
    if (!fout)
    {
        cout << "cannot open file!" << endl;
        exit(1);
    }

    
    res = mysql_query(&myCont, query);//Execute the query statement, if the query is successful, return zero; if there is an error, non-zero
    if (!res)
    {
        result = mysql_store_result(&myCont);//Save the query data to result
        if (result)
        {
            int i, j;
            cout << "\nNow doing " << number << " query, number of result : " << (unsigned long)mysql_num_rows(result) << endl << endl;
            for (i = 0; fd = mysql_fetch_field(result); i++)//get column name  
            {
                strcpy_s(column[i], fd->name);
            }
            j = mysql_num_fields(result);

            for (i = 0; i < j; i++)
            {
                printf("%s\t", column[i]);
                fout << column[i] << "\t";

            }
            printf("\n");
            fout << endl;
            while (sql_row = mysql_fetch_row(result))//Get specific data  
            {
                for (i = 0; i < j; i++)
                {

                    printf("%s\t", sql_row[i]);
                    fout << setw(10) << sql_row[i] << "\t";
                }
                printf("\n");
                fout << endl;
            }
        }
        cout << "\nQuery results are successfully stored in " << filename << endl;
    }
    else
    {
        cout << "query sql failed!" << endl;
    }
    fout.close();


}



int main()
{
  
    mysql_library_init(0, NULL, NULL);//Initializing the MySQL Library  
    mysql_init(&myCont);//Initializing connection handlers   
    if (mysql_real_connect(&myCont, host, user, pswd, table, port, NULL, 0))
    {//Connect to the server by calling mysql_real_connect()   
        cout << "connect succeed!" << endl;
        char query_rule1[2048];

        sprintf_s(query_rule1, 2048,
            "SELECT DISTINCT CONCAT(Account_Info.first_name, ' ', Account_Info.last_name) AS 'Name', Account_Info.account_number AS 'Account Number', Transactions.transaction_number AS 'Transaction Number', Transactions.merchant_name AS 'Merchant', Transactions.transaction_amount AS 'Transaction Amount' FROM MAD INNER JOIN Median ON MAD.account_number = Median.account_number AND MAD.merchant_name = Median.merchant_name INNER JOIN Transactions ON MAD.account_number = Transactions.account_number AND MAD.merchant_name = Transactions.merchant_name INNER JOIN Account_Info ON Account_Info.account_number = Transactions.account_number WHERE ABS(Transactions.transaction_amount - MAD.median_absolute_deviation) / MAD.median_absolute_deviation > 10 AND ABS(Transactions.transaction_amount - Median.median) > 10 * MAD.median_absolute_deviation AND Transactions.transaction_amount > 100 ORDER BY Account_Info.account_number, Transactions.transaction_number; "
        );

        char query_rule2[2048];

        sprintf_s(query_rule2, 2048,

            "SELECT CONCAT(Account_Info.first_name, ' ', Account_Info.last_name) AS 'Name', Account_Info.account_number AS 'Account Number', Transactions.transaction_number AS 'Transaction Number', Account_Info.state AS 'Expected Transaction Location', Transactions.merchant_state AS 'Actual Transaction Location' FROM Account_Info INNER JOIN Transactions ON Account_Info.account_number = Transactions.account_number WHERE Account_Info.state <> Transactions.merchant_state ORDER BY Account_Info.account_number, Transactions.transaction_number;"
        );

        query_rule(query_rule1, "E:/rule1.txt", "rule1");
        query_rule(query_rule2, "E:/rule2.txt", "rule2");
    }
    else
    {
        cout << "connect failed!" << endl;
    }
 
    if (result != NULL) mysql_free_result(result);//Release results resources  
    mysql_close(&myCont);//Closing MySQL Connection
    mysql_library_end();//Closing MySQL Library

    return 0;
}