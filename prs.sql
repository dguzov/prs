DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;

	-- create the User table
CREATE TABLE user (
ID				INT			PRIMARY KEY AUTO_INCREMENT,
UserName		VARCHAR(20) UNIQUE not null,
Password		VARCHAR(10) not null,
FirstName		VARCHAR(20) not null,
LastName		VARCHAR(20) not null,
PhoneNumber		VARCHAR(12) not null,
Email			VARCHAR(75) not null,
IsReviewer		TinyInt(1)  not null,
IsAdmin			TinyInt(1)  not null,
IsActive		TinyInt(1)  not null,
DateCreated		DATETIME 	default current_timestamp not null,
DateUpdated		DATETIME 	default current_timestamp on update current_timestamp not null,
UpdatedByUser	INT	   	    default 1 not null
  );
  
	-- create the Vendor table
CREATE TABLE vendor  (
ID				INT 		 PRIMARY KEY AUTO_INCREMENT,
Code			VARCHAR(10)	 UNIQUE not null,
Name			VARCHAR(255) not null,
Address			VARCHAR(255) not null,
City			VARCHAR(255) not null,
State			VARCHAR(2)   not null,
Zip				VARCHAR(5)   not null,
PhoneNumber		VARCHAR(12)  not null,
Email			VARCHAR(100) not null,
IsPreApproved	TinyInt(1)   not null,
IsActive		TinyInt(1)   not null,
DateCreated		DATETIME	 default current_timestamp not null,
DateUpdated		DATETIME	 default current_timestamp on update current_timestamp not null,
UpdatedByUser	INT			 default 1 not null
);

-- create the Product table
CREATE TABLE product (
ID				INT 			PRIMARY KEY AUTO_INCREMENT,
VendorID		INT				not null,
PartNumber		VARCHAR(50) 	not null,
Name			VARCHAR(150)	not null,
Price			DECIMAL(10,2)	not null,
Unit			VARCHAR(255),
PhotoPath		VARCHAR(255),
IsActive		TinyInt(1)		default 1 not null,
DateCreated		DATETIME 		default current_timestamp not null,
DateUpdated		DATETIME 		default current_timestamp on update current_timestamp not null,
UpdatedByUser	INT 			default 1 not null,
		FOREIGN KEY (VendorID) REFERENCES vendor(ID)
);
    
    -- create the PurchaseRequest table
CREATE TABLE purchaserequest (
ID					INT				PRIMARY KEY AUTO_INCREMENT,
UserID				INT				not null,
Description			VARCHAR(100)	not null,
Justification		VARCHAR(255)	not null,
DateNeeded			DATE			not null,
DeliveryMode		VARCHAR(25)		not null,
Status				VARCHAR(20)		not null,
Total				DECIMAL(10,2)	not null,
SubmittedDate		DATETIME 		default current_timestamp not null,
ReasonForRejection	VARCHAR(100),
IsActive			TinyInt(1)		default 1 not null,
DateCreated			DATETIME		default current_timestamp not null,
DateUpdated			DATETIME		default current_timestamp on update current_timestamp,
UpdatedByUser		INT				default 1 not null,
		FOREIGN KEY (UserID) REFERENCES user(ID)
);

-- create the PurchaseRequestLineItem table
CREATE TABLE purchaserequestlineitem (
ID					INT			PRIMARY KEY AUTO_INCREMENT,
PurchaseRequestID	INT			UNIQUE not null,
ProductID			INT			UNIQUE not null,
Quantity			INT			not null,
IsActive			TinyInt(1)	default 1 not null,
DateCreated			DATETIME	default current_timestamp not null,
DateUpdated			DATETIME	default current_timestamp on update current_timestamp not null,
UpdatedByUser 		INT			default 1 not null,
    FOREIGN KEY (PurchaseRequestID) REFERENCES purchaserequest(ID),
    FOREIGN KEY (ProductID) 		REFERENCES product(ID)
    );
    
-- insert users
INSERT INTO user (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin, IsActive)
VALUES
(1,'SYSTEM','xxxxx','System','System','XXX-XXX-XXXX','system@test.com',1,1,1),
(2,'sblessing','login','Sean','Blessing','513-600-7096','sean@blessingtechnology.com', 1,1,1),
(3,'jdow','murakami12','John','Dow','608-433-7096','jdow1plus@creativewebboom.com', 1,1,1);

-- insert vendors
INSERT INTO vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email, isPreApproved, IsActive) 
VALUES 
(1,'BB-1001','Best Buy','100 Best Buy Street','Louisville','KY','40207','502-111-9099','geeksquad@bestbuy.com',1,1),
(2,'AP-1001','Apple Inc','1 Infinite Loop','Cupertino','CA','95014','800-123-4567','genius@apple.com',1,1),
(3,'AM-1001','Amazon','410 Terry Ave. North','Seattle','WA','98109','206-266-1000','amazon@amazon.com',0,1),
(4,'ST-1001','Staples','9550 Mason Montgomery Rd','Mason','OH','45040','513-754-0235','support@orders.staples.com',0,1),
(5,'MC-1001','Micro Center','11755 Mosteller Rd','Sharonville','OH','45241','513-782-8500','support@microcenter.com',0,1);

-- insert base products
INSERT INTO product (`ID`,`VendorID`,`PartNumber`,`Name`,`Price`,`Unit`,`PhotoPath`) 
VALUES 
(1,1,'ME280LL','iPad Mini 2',296.99,NULL,NULL),
(2,2,'ME280LL','iPad Mini 2',299.99,NULL,NULL),
(3,3,'105810','Hammermill Paper, Premium Multi-Purpose Paper Poly Wrap',8.99,'1 Ream / 500 Sheets',NULL),
(4,4,'122374','HammerMill® Copy Plus Copy Paper, 8 1/2\" x 11\", Case',29.99,'1 Case, 10 Reams, 500 Sheets per ream',NULL),
(5,4,'784551','Logitech M325 Wireless Optical Mouse, Ambidextrous, Black ',14.99,NULL,NULL),
(6,4,'382955','Staples Mouse Pad, Black',2.99,NULL,NULL),
(7,4,'2122178','AOC 24-Inch Class LED Monitor',99.99,NULL,NULL),
(8,4,'2460649','Laptop HP Notebook 15-AY163NR',529.99,NULL,NULL),
(9,4,'2256788','Laptop Dell i3552-3240BLK 15.6\"',239.99,NULL,NULL),
(10,4,'IM12M9520','Laptop Acer Acer™ Aspire One Cloudbook 14\"',224.99,NULL,NULL),
(11,4,'940600','Canon imageCLASS Copier (D530)',99.99,NULL,NULL),
(12,5,'228148','Acer Aspire ATC-780A-UR12 Desktop Computer',399.99,'','/images/AcerAspireDesktop.jpg'),
(13,5,'279364','Lenovo IdeaCentre All-In-One Desktop',349.99,'','/images/LenovoIdeaCenter.jpg');

-- insert base purchaserequest
INSERT INTO purchaserequest (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, ReasonForRejection) 
VALUES
(1,1,'Multiple colors','Urgent','2019-5-15','mail','Red','122.80','The colors not follow the company''s brandbook'' color scheme'),
(2,2,'Pack of 24','For the whole department of 24 persons','2019-5-15','mail','Green','216.50',''),
(3,2,'paper','for the new P&G project','2019-5-15','mail','Green','359.80',''),
(4,1,'','Urgent','2019-5-15','pickup','Green','43.12','');

-- insert base purchaserequestlineitem
INSERT INTO `purchaserequestlineitem` (`ID`,`PurchaseRequestID`,`ProductID`,`Quantity`)
VALUES 
(1,1,'2','1'),
(2,2,'1','1'),
(3,3,'4','10'),
(4,4,'3','1');