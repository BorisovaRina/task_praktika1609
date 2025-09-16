USE master;
GO

IF DB_ID('KadrDB') IS NOT NULL
DROP DATABASE KadrDB;
GO

CREATE DATABASE KadrDB;
GO

USE KadrDB;
GO

CREATE TABLE Photographers (
    PhotographerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100) UNIQUE NOT NULL,
    HireDate DATE NOT NULL
);
GO

CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE ServicePackages (
    PackageID INT IDENTITY(1,1) PRIMARY KEY,
    PackageName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
);
GO

CREATE TABLE PhotoSessions (
    SessionID INT IDENTITY(1,1) PRIMARY KEY,
    PhotographerID INT NOT NULL,
    ClientID INT NOT NULL,
    PackageID INT NULL, 
    SessionDate DATE NOT NULL,
    Location NVARCHAR(100),
    Status NVARCHAR(20) DEFAULT 'Scheduled'
        CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    CONSTRAINT FK_PhotoSessions_Photographers FOREIGN KEY (PhotographerID) REFERENCES Photographers(PhotographerID) ON DELETE CASCADE,
    CONSTRAINT FK_PhotoSessions_Clients FOREIGN KEY (ClientID) REFERENCES Clients(ClientID) ON DELETE CASCADE,
    CONSTRAINT FK_PhotoSessions_Packages FOREIGN KEY (PackageID) REFERENCES ServicePackages(PackageID) ON DELETE SET NULL
);
GO

INSERT INTO Photographers (FirstName, LastName, Phone, Email, HireDate) VALUES
('Иван', 'Иванов', '+7 123 456 7890', 'ivan.ivanov@kadr.ru', '2020-01-15'),
('Мария', 'Петрова', '+7 234 567 8901', 'maria.petrova@kadr.ru', '2019-07-23');
GO

INSERT INTO Clients (FirstName, LastName, Phone, Email) VALUES
('Алексей', 'Смирнов', '+7 345 678 9012', 'alexey.smirnov@example.com'),
('Ольга', 'Кузнецова', '+7 456 789 0123', 'olga.kuznetsova@example.com');
GO

INSERT INTO ServicePackages (PackageName, Description, Price) VALUES
('Стандартный', '1 час фотосессии, 30 обработанных фото', 5000.00),
('Премиум', '2 часа фотосессии, 70 обработанных фото, фотокнига', 12000.00);
GO

INSERT INTO PhotoSessions (PhotographerID, ClientID, PackageID, SessionDate, Location, Status) VALUES
(1, 1, 1, '2025-09-01', 'Центр города', 'Completed'),
(2, 2, 2, '2025-09-10', 'Парк', 'Scheduled');
GO

SELECT * FROM Photographers;
SELECT * FROM Clients;
SELECT * FROM ServicePackages;
SELECT * FROM PhotoSessions;
