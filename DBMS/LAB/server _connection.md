SQL Server Authentication Setup from Windows Authentication

Step 1: Check Authentication Mode

Run this query in SQL Server Management Studio (SSMS):

SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') AS AuthMode;

If the result is 1, Windows Authentication Only is enabled.

If the result is 0, Mixed Mode Authentication (Windows + SQL Server Authentication) is enabled.

Step 2: Enable Mixed Mode Authentication (If Required)

Open SQL Server Management Studio (SSMS).

Right-click the server instance (in Object Explorer) → Properties.

Go to Security tab.

Under Server authentication, select SQL Server and Windows Authentication mode.

Click OK.

Restart the SQL Server service:

Open SQL Server Configuration Manager.

Find SQL Server (MSSQLSERVER).

Right-click and select Restart.

Step 3: Create SQL Server Authentication Login

Once Mixed Mode Authentication is enabled, you can create a SQL Server login for the user.

-- Create a new SQL Server authentication login
CREATE LOGIN NewUser WITH PASSWORD = 'SecureP@ssw0rd!',
    CHECK_EXPIRATION = OFF,
    CHECK_POLICY = OFF;

-- Switch to the target database
USE YourDatabase;

-- Create a user for the login
CREATE USER NewUser FOR LOGIN NewUser;

-- Grant necessary roles or permissions
ALTER ROLE db_owner ADD MEMBER NewUser; -- Full database access
-- OR
GRANT SELECT, INSERT, UPDATE, DELETE ON DATABASE::YourDatabase TO NewUser; -- Limited access

Step 4: Verify the Login

Run:

SELECT name, type_desc, is_disabled
FROM sys.server_principals
WHERE name = 'NewUser';

type_desc should be SQL_LOGIN.

is_disabled = 0 means the account is active.

Step 5: Allow SQL Authentication for Remote Access

Open SQL Server Configuration Manager.

Expand SQL Server Network Configuration → Click Protocols for MSSQLSERVER.

Enable TCP/IP:

Right-click TCP/IP and select Enable.

Restart SQL Server.

Step 6: Connect from Another Server

In SSMS, choose SQL Server Authentication.

Enter:

Login: NewUser

Password: 'SecureP@ssw0rd!'

Click Connect.

Final Notes

If Windows Authentication is enforced, you cannot create a SQL Server login and must use Windows-based users.

If SQL Authentication is required, enable Mixed Mode Authentication in SQL Server settings.

Ensure TCP/IP is enabled for remote access.

This guide ensures you can create and connect a SQL Server login from Windows Authentication.

