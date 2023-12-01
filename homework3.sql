--homework 3
--3.1
CREATE TABLE ROOM(
   --Floor__,RTNumBeds*,HAddress*
   Floor INT PRIMARY KEY NOT NULL,
   RTNumBeds INT FOREIGN KEY REFERENCES ROOMTYPE(NumBeds) ON DELETE CASCADE ON UPDATE CASCADE,
   HAddress NVARCHAR(50) FOREIGN KEY REFERENCES HOTEL(Address) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT
);

CREATE TABLE ROOMTYPE(
   --Name__,numBeds,NumPerson
   RoomTypeID INT PRIMARY KEY IDENTITY(1, 1),
   Name VARCHAR(30) NOT NULL,
   NumBeds INT NOT NULL,
   NumPerson INT NOT NULL 
);

CREATE TABLE HOTEL(
   --Name,Address__,Rating,City,Country,RTName*,ResPaymentType*
   HotelID INT PRIMARY KEY IDENTITY(1, 1),
   Name VARCHAR(30),
   Address NVARCHAR(50),
   Rating INT,
   City NVARCHAR,
   Country VARCHAR,
); 

CREATE TABLE RESERVATION(
--ReservationDate,ArrivalDate,DepartureDate,RTName*,HAdress*,RTNumPersons*,NumRooms,PaymentType,status(completed,active,canceled)
   ReservationID INT IDENTITY(1, 1) PRIMARY KEY,
   ReservationDate DATE,
   ArrivalDate DATE,
   DepartureDate DATE,
   NumRooms INT,
   NumGuests INT,
   PaymentType VARCHAR CHECK (PaymentType IN ('card', 'cash')),
    ReservationStatus VARCHAR CHECK (ReservationStatus IN ('completed', 'active', 'canceled'))
   --(completed,active,canceled)
   --CONSTRAINT 
);

CREATE TABLE CLIENT(
--FirstName,LastName,Address__,Country
  ClientID INT IDENTITY(1, 1) PRIMARY KEY,
  FirstName VARCHAR(30) NOT NULL,
  LastName VARCHAR(30) NOT NULL,
  Country NVARCHAR(40),
  HAddress NVARCHAR(50) 
  --location, cleanliness, staff
);

CREATE TABLE SYSTEM(
    --comments-citY 
    Comments VARCHAR(30),
    LandMark VARCHAR(30) NOT NULL,
);

CREATE TABLE LANDMARK(
    --landmark(name, description, attractiveness, opening hours, and city.)
    LandmarkID INT IDENTITY(1, 1) PRIMARY KEY,
    Name VARCHAR(30),
    Description VARCHAR(60) NOT NULL,
    Attractiveness VARCHAR(30) NOT NULL,
    OpeningHours INT,
    city VARCHAR FOREIGN KEY REFERENCES HOTEL(City),
    distance DOUBLE
);

CREATE TABLE HotelRoomTypePrice (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Price INT,
    HotelID INT IDENTITY(1, 1) FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID),
    RoomTypeID INT IDENTITY(1, 1) FOREIGN KEY (RoomTypeID) REFERENCES ROOMTYPE(RoomTypeID)
)

CREATE TABLE ClientHotelRating(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    ClientID INT FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
    HotelID INT FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID),
    LocationRating INT,
    HygieneRating INT,
    StaffRating INT
)

CREATE TABLE Comment (
    CommentID INT IDENTITY(1, 1) PRIMARY KEY,
    ClientID INT FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
    HotelID INT FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID),
    Comment VARCHAR,
    CreatedAt DATETIME,

)

CREATE TABLE HotelLandmarkDIstance (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    HotelID INT FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID),
    LandmarkID INT FOREIGN KEY (LandmarkID) REFERENCES LANDMARK(LandmarkID),
    Distance INT
)

CREATE TABLE ClientLandmarkVisit(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    ClientID INT FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
    LandmarkID INT FOREIGN KEY (LandmarkID) REFERENCES LANDMARK(LandmarkID)
)


---------------------------------------------------------------------------------------------------------------------------------------
--3.2


CREATE TABLE AdditionalService(
  ID INT IDENTITY(1, 1) PRIMARY KEY,
  name VARCHAR(30) FOREIGN KEY REFERENCES Plan(name),
  PlanID INT FOREIGN KEY (PlanID) REFERENCES Plan(ID) ON DELETE CASCADE
);

CREATE TABLE Plan(
    --(Name,Desc)
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    name VARCHAR(30) FOREIGN KEY REFERENCES MobileOperator(name),
    description NVARCHAR(30) FOREIGN KEY REFERENCES MobileOperator(description),
    NumberPlanID INT FOREIGN KEY (NumberPlanID) REFERENCES NumPlan(ID) ON DELETE CASCADE
);

CREATE TABLE MobileOperator(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description NVARCHAR(30),
    CONSTRAINT OPERATOR CHECK (name='T-Mobile' OR name='Vip.One')
);

CREATE TABLE NumPlan(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    name VARCHAR(30) FOREIGN KEY REFERENCES Plan(name),
    description NVARCHAR(30) FOREIGN KEY REFERENCES Plan(description),
    num VARCHAR(30) FOREIGN KEY REFERENCES TelephoneNum(num),
    NumberID INT FOREIGN KEY (NumberID) REFERENCES TelephoneNum(ID) ON DELETE CASCADE,
    OperatorID INT FOREIGN KEY (OperatorID) REFERENCES MobileOperator(ID)
);

CREATE TABLE TelephoneNum(
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    num VARCHAR(10) UNIQUE,
    CONSTRAINT BROJ CHECK (num LIKE "0%"),
    ClientID INT FOREIGN KEY (ClientID) REFERENCES Client(ID)
);

CREATE TABLE Agreement( 
     ID INT IDENTITY(1, 1) PRIMARY KEY,
    ClientID INT FOREIGN KEY (ClientID) REFERENCES Client(ID),
    TelephoneID INT FOREIGN KEY (TelephoneID) REFERENCES TelephoneNum(ID),
    MobileOperatorID INT FOREIGN KEY (MobileOperatorID) REFERENCES MobileOperator(ID) ON   DELETE CASCADE,
    data DATA,
    num VARCHAR(30) FOREIGN KEY REFERENCES TelephoneNum(num),
    street NVARCHAR(30) FOREIGN KEY REFERENCES Client(Street)
);

CREATE TABLE Client(
     ID INT IDENTITY(1, 1) PRIMARY KEY,
     SNN INT UNIQUE NOT NULL,
     City VARCHAR(30),
     Street VARCHAR(30),
     Number INT,
     Type   VARCHAR(30)
);