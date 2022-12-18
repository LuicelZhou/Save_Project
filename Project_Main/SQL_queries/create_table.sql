  DROP TABLE Transactions;
  -- DROP TABLE Account_Info;

CREATE TABLE IF NOT EXISTS Account_Info(
   last_name      VARCHAR(10) NOT NULL, 
   first_name     VARCHAR(13) NOT NULL,
   street_address VARCHAR(26) NOT NULL,
   unit           VARCHAR(10) ,
   city           VARCHAR(17) NOT NULL,
   state          VARCHAR(30) NOT NULL,
   zip            VARCHAR(10)  NOT NULL,
   dob            VARCHAR(20)  NOT NULL,
   ssn            VARCHAR(11) NOT NULL,
   email_address  VARCHAR(33) NOT NULL,
   mobile_number  VARCHAR(15)  NOT NULL,
   account_number VARCHAR(15)  NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Transactions(
   account_number         VARCHAR(15)  NOT NULL,
   transaction_datetime   VARCHAR(17)  NOT NULL,
   transaction_amount     FLOAT  NOT NULL,
   post_date              VARCHAR(20)  NOT NULL,
   merchant_number        VARCHAR(15)  NOT NULL,
   merchant_category_code VARCHAR(20)  NOT NULL,
   transaction_number     VARCHAR(10)  NOT NULL,
   merchant_name		  VARCHAR(50)  NOT NULL,
   merchant_state		  VARCHAR(50)  NOT NULL,

	FOREIGN KEY (account_number) REFERENCES Account_Info(account_number)
				ON DELETE CASCADE
				ON UPDATE RESTRICT
  
);
