#pragma once
#include <stdio.h>
#include <iostream>
#include <WinSock.h>
#include <Windows.h>
#include <mysql.h>
using namespace std;
using namespace std;

MYSQL mysql;
const char DataBase_UserName[] = "root";    //username
const char DataBase_Password[] = "Molanlan0738!";   //password
const char DataBase_Host[] = "localhost";  //Database connection address
const char DataBase_Name[] = "save_test";  //database name
unsigned int DataBase_Port = 3306;

bool ConnectDatabase(); //Function declaration
void FreeConnect();   //Release Resources


bool ConnectDatabase()
{
	//initial mysql
	mysql_init(&mysql);  

	if (!(mysql_real_connect(&mysql, DataBase_Host, DataBase_UserName, DataBase_Password, DataBase_Name, DataBase_Port, NULL, 3306)))
	{
		cout << "Error connecting to database:" << mysql_error(&mysql) << endl;
		return false;
	}
	else
	{
		cout << "Connected to MYSQL database successfully!" << endl;
		cout << "Connected..." << endl;
		return true;
	}
}

//Release Resources
void FreeConnect()
{
	//Release Resources
	//mysql_free_result(res);
	mysql_close(&mysql);
	cout << "The database has been released!" << endl;
}