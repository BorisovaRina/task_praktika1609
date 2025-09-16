USE master;
GO

IF DB_ID('TimeClubDB') IS NOT NULL
DROP DATABASE TimeClubDB;
GO

CREATE DATABASE TimeClubDB;
GO

USE TimeClubDB;
GO

CREATE TABLE Visitors (
    VisitorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100) UNIQUE,
    RegistrationDate DATE DEFAULT GETDATE()
);
GO

CREATE TABLE Rates (
    RateID INT IDENTITY(1,1) PRIMARY KEY,
    RateName NVARCHAR(100) NOT NULL,
    FirstHourPrice DECIMAL(10,2) NOT NULL CHECK (FirstHourPrice >= 0),
    FollowingHoursPrice DECIMAL(10,2) NOT NULL CHECK (FollowingHoursPrice >= 0)
);
GO

CREATE TABLE Zones (
    ZoneID INT IDENTITY(1,1) PRIMARY KEY,
    ZoneName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL
);
GO

CREATE TABLE Visits (
    VisitID INT IDENTITY(1,1) PRIMARY KEY,
    VisitorID INT NOT NULL,
    ZoneID INT NULL,
    RateID INT NULL,
    VisitStart DATETIME NOT NULL,
    VisitEnd DATETIME NULL,
    TotalPrice DECIMAL(10,2) NULL,
    CONSTRAINT FK_Visits_Visitors FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID) ON DELETE CASCADE,
    CONSTRAINT FK_Visits_Zones FOREIGN KEY (ZoneID) REFERENCES Zones(ZoneID) ON DELETE SET NULL,
    CONSTRAINT FK_Visits_Rates FOREIGN KEY (RateID) REFERENCES Rates(RateID) ON DELETE SET NULL
);
GO

INSERT INTO Visitors (FirstName, LastName, Phone, Email) VALUES
('Александр', 'Иванов', '+7 123 456 7890', 'alex.ivanov@example.com'),
('Екатерина', 'Смирнова', '+7 234 567 8901', 'kate.smirnova@example.com');
GO

INSERT INTO Rates (RateName, FirstHourPrice, FollowingHoursPrice) VALUES
('Дневной тариф', 300.00, 200.00),
('Вечерний тариф', 400.00, 250.00);
GO

INSERT INTO Zones (ZoneName, Description) VALUES
('Игры', 'Игровая зона с настольными играми и приставками'),
('Коворкинг', 'Зона для работы с Wi-Fi и розетками');
GO

INSERT INTO Visits (VisitorID, ZoneID, RateID, VisitStart, VisitEnd, TotalPrice) VALUES
(1, 1, 1, '2025-09-10 14:00', '2025-09-10 16:30', 700.00),
(2, 2, 2, '2025-09-11 18:00', NULL, NULL);
GO

SELECT * FROM Visitors;
SELECT * FROM Rates;
SELECT * FROM Zones;
SELECT * FROM Visits;
