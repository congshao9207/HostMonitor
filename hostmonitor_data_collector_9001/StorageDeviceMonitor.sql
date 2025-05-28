-- 创建数据库  
CREATE DATABASE IF NOT EXISTS StorageDeviceMonitor DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;  
USE StorageDeviceMonitor;  
  
-- 创建分散式监控记录表  
CREATE TABLE IF NOT EXISTS DispersedMonitorRecord (  
    hostname VARCHAR(255) NOT NULL,  
    ip VARCHAR(50) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    MemUsage DOUBLE NOT NULL,  
    CpuUsage DOUBLE NOT NULL,  
    NetRecv DOUBLE NOT NULL,  
    NetSent DOUBLE NOT NULL,  
    DiskReadRates DOUBLE NOT NULL,  
    DiskWriteRates DOUBLE NOT NULL,  
    IOPS DOUBLE NOT NULL,  
    PRIMARY KEY (ip, timestamp)  
);  
  
-- 创建磁盘故障表  
CREATE TABLE IF NOT EXISTS DiskFailure (  
    ip VARCHAR(50) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    details TEXT NOT NULL,  
    PRIMARY KEY (ip, timestamp)  
);  
  
-- 创建磁盘硬件信息表  
CREATE TABLE IF NOT EXISTS diskHardwareInfo (  
    diskSerial VARCHAR(255) NOT NULL,  
    hostName VARCHAR(255) NOT NULL,  
    capacity DOUBLE NOT NULL,  
    isSSD BOOLEAN NOT NULL,  
    model VARCHAR(255) NOT NULL,  
    hostIp VARCHAR(50) NOT NULL,  
    state BOOLEAN NOT NULL,  
    modifiedTimestamp TIMESTAMP NOT NULL,  
    PRIMARY KEY (diskSerial)  
);  
  
-- 创建磁盘采样信息表  
CREATE TABLE IF NOT EXISTS diskSampleInfo (  
    diskSerial VARCHAR(255) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    IOPS DOUBLE NOT NULL,  
    ReadSpeed DOUBLE NOT NULL,  
    WriteSpeed DOUBLE NOT NULL,  
    PRIMARY KEY (diskSerial, timestamp),  
    FOREIGN KEY (diskSerial) REFERENCES diskHardwareInfo(diskSerial)  
);  
  
-- 创建磁盘故障预测信息表  
CREATE TABLE IF NOT EXISTS diskDFPInfo (  
    diskSerial VARCHAR(255) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    predictProbability DOUBLE NOT NULL,  
    modelName VARCHAR(255) NOT NULL,  
    predictTime TIMESTAMP NOT NULL,  
    PRIMARY KEY (diskSerial, timestamp),  
    FOREIGN KEY (diskSerial) REFERENCES diskHardwareInfo(diskSerial)  
);  
  
-- 创建磁盘SMART属性数据表  
CREATE TABLE IF NOT EXISTS diskSmartInfo (  
    diskSerial VARCHAR(255) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    attributeID INT NOT NULL,  
    attributeName VARCHAR(255) NOT NULL,  
    value INT NOT NULL,  
    worst INT NOT NULL,  
    threshold INT NOT NULL,  
    raw BIGINT NOT NULL,  
    PRIMARY KEY (diskSerial, timestamp, attributeID),  
    FOREIGN KEY (diskSerial) REFERENCES diskHardwareInfo(diskSerial)  
);  
  
-- 创建实际磁盘故障记录表  
CREATE TABLE IF NOT EXISTS RealDiskFailureInfo (  
    timestamp TIMESTAMP NOT NULL,  
    diskSerial VARCHAR(255) NOT NULL,  
    PRIMARY KEY (timestamp, diskSerial),  
    FOREIGN KEY (diskSerial) REFERENCES diskHardwareInfo(diskSerial)  
);  
  
-- 创建模型训练信息表  
CREATE TABLE IF NOT EXISTS trainInfo (  
    timestamp TIMESTAMP NOT NULL,  
    PredictModel INT NOT NULL,  
    DiskModel VARCHAR(255) NOT NULL,  
    FDR FLOAT NOT NULL,  
    FAR FLOAT NOT NULL,  
    AUC FLOAT NOT NULL,  
    FNR FLOAT NOT NULL,  
    Accuracy FLOAT NOT NULL,  
    Pre FLOAT NOT NULL,  
    Specificity FLOAT NOT NULL,  
    ErrorRate FLOAT NOT NULL,  
    Parameters TEXT NOT NULL,  
    OperatorID VARCHAR(255) NOT NULL,  
    PRIMARY KEY (timestamp, PredictModel, DiskModel)  
);  
  
-- 创建报告信息表  
CREATE TABLE IF NOT EXISTS reportInfo (  
    reportID INT AUTO_INCREMENT NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    reportType VARCHAR(50) NOT NULL,  
    content TEXT NOT NULL,  
    creatorID VARCHAR(255) NOT NULL,  
    PRIMARY KEY (reportID)  
);  
  
-- 创建系统用户表  
CREATE TABLE IF NOT EXISTS SystemUser (  
    user_id VARCHAR(255) NOT NULL,  
    user_name VARCHAR(255) NOT NULL,  
    user_password VARCHAR(255) NOT NULL,  
    user_type INT NOT NULL,  
    valid_state INT NOT NULL,  
    user_phone VARCHAR(20),  
    user_email VARCHAR(255),  
    phone_valid_state INT NOT NULL,  
    email_valid_state INT NOT NULL,  
    last_edit_time TIMESTAMP NOT NULL,  
    PRIMARY KEY (user_id)  
);

-- 修改用户表名称  
CREATE TABLE IF NOT EXISTS UserTable (  
    UserID VARCHAR(255) NOT NULL,  
    UserName VARCHAR(255) NOT NULL,  
    Password VARCHAR(255) NOT NULL,  
    UserType INT NOT NULL,  
    ValidState INT NOT NULL,  
    Phone VARCHAR(20),  
    Email VARCHAR(255),  
    PhoneValidState INT NOT NULL,  
    EmailValidState INT NOT NULL,  
    LastEditTime TIMESTAMP NOT NULL,  
    PRIMARY KEY (UserID)  
);  
  
-- 创建进程数据表  
CREATE TABLE IF NOT EXISTS ProcessData (  
    hostname VARCHAR(255) NOT NULL,  
    ip VARCHAR(50) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    pid INT NOT NULL,  
    processName VARCHAR(255) NOT NULL,  
    cpuUsage DOUBLE NOT NULL,  
    memoryUsage DOUBLE NOT NULL,  
    user VARCHAR(255),  
    command TEXT,  
    PRIMARY KEY (ip, timestamp, pid)  
);  
  
-- 创建HustMonitorRecord表（如果需要）  
CREATE TABLE IF NOT EXISTS HustMonitorRecord (  
    id INT AUTO_INCREMENT NOT NULL,  
    hostname VARCHAR(255) NOT NULL,  
    ip VARCHAR(50) NOT NULL,  
    timestamp TIMESTAMP NOT NULL,  
    recordType VARCHAR(50) NOT NULL,  
    recordData TEXT NOT NULL,  
    PRIMARY KEY (id)  
);