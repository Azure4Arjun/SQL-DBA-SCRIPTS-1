-- Declare variables for Database to be backed up and folder to store the backup file
DECLARE
	  @DbName VARCHAR (100) = 'AdvatarHealth' -- Stores the database name to be backed up
	, @BackupFolder VARCHAR(128) = 'C:\Temp\' -- backslah necessary Stores the location of the folder for backups

DECLARE	
		@BackupStr VARCHAR (1000),
		@BackupDate VARCHAR(8), -- Sets the date
		@BackupHour VARCHAR(2), -- Sets the hour
		@BackupMinute VARCHAR (2), -- Sets the minute
		@BackupTime VARCHAR (18) -- Stores above info for backup time

-- Set the date part of the backup file name
SELECT
	  @BackupDate = CONVERT (VARCHAR(8),GETDATE(),112)
	, @BackupHour = DATEPART(HH,GETDATE())
	, @BackupMinute = DATEPART(MI,GETDATE())

-- Set length of the hour to 2 digit if it's 1 digit
IF LEN (@BackupHour) = 1
	BEGIN
		SET	@BackupHour = '0'+ @BackupHour
	END
-- Set length of the minute to 2 digit if it's 1 digit
IF LEN (@BackupMinute) = 1
	BEGIN
		SET	@BackupMinute = '0'+ @BackupMinute
	END

-- Set the time to append to the backup fil ename
SELECT	@BackupTime = '_' + @BackupDate + '_' + @BackupHour + @BackupMinute
-- Set the full path for backup command
SELECT	@BackupStr = @BackupFolder + @DbName + @BackupTime + '_db_full.bak'

--  Start database backup
BACKUP DATABASE @DbName TO DISK = @BackupStr
WITH STATS = 5, COMPRESSION;
