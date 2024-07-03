Ticketing Application
Overview
The Ticketing Application is a comprehensive system designed to manage tickets, users, and agents within an organization. This application provides functionalities to create, update, and manage tickets, register users, and assign roles such as agents or customers. The application is built using ASP.NET Core for the backend and Angular for the frontend, ensuring a robust and scalable solution.
Features
•	- User Registration and Authentication
•	- Role-based Access Control (Admin, Agent, Customer)
•	- Ticket Management (Create, Update, Delete)
•	- User Profile Management
•	- Agent Management
•	- Secure Password Handling with AES Encryption
•	- JWT Token-based Authentication
Prerequisites
•	- .NET 6.0 or later
•	- SQL Server
•	- Visual Studio 2022 or later / Visual Studio Code
•	- Angular CLI
Getting Started
Setup SQL Server
1. Create Database: Create a new database in your SQL Server instance.
```sql
CREATE DATABASE TicketDesk;
```
2. Create Tables: Execute the provided SQL scripts to create necessary tables (`Users`, `Tickets`, `UserProfile`, `Agents`).
3. Create Stored Procedures: Execute the provided stored procedures scripts in the database.
Setup Backend (ASP.NET Core)
1. Clone the Repository
```bash
git clone https://github.com/your-repo/ticketing-application.git
cd ticketing-application
```
2. Update Connection String
Update the connection string in `appsettings.json` to point to your SQL Server database.
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=YOUR_SERVER;Database=TicketDesk;Trusted_Connection=True;"
}
```
3. Install Dependencies
```bash
dotnet restore
```
4. Build and Run the Application
```bash
dotnet build
dotnet run
```
The backend will start running at `https://localhost:5001` or `http://localhost:5000`.
Setup Frontend (Angular)
1. Navigate to the Frontend Directory
```bash
cd ClientApp
```
2. Install Dependencies
```bash
npm install
```
3. Update API Endpoint
Update the API endpoint in `environment.ts` to point to your backend URL.
```typescript
export const environment = {
  production: false,
  apiUrl: 'https://localhost:5001/api'
};
```
4. Build and Run the Angular Application
```bash
ng serve
```
The frontend will start running at `http://localhost:4200`.
Usage
Registration
- Register a new user through the registration form.
- Depending on the role selected (Agent, Customer), additional entries will be created in corresponding tables.
Login
- Login using the registered email and password.
- A JWT token will be generated and used for subsequent authenticated requests.
Ticket Management
- Create, update, and delete tickets as an authenticated user.
- Agents can view and manage tickets assigned to them.
User Profile
- View and update user profile information.
- Admins can manage all user profiles.
Database Schema
Tables
Users
| Column         | Type            | Description                |
|----------------|-----------------|----------------------------|
| UserId         | UNIQUEIDENTIFIER| Primary key                |
| FirstName      | NVARCHAR(50)    | User's first name          |
| LastName       | NVARCHAR(50)    | User's last name           |
| EmailAddress   | NVARCHAR(100)   | User's email address       |
| PhoneNumber    | BIGINT          | User's phone number        |
| Password       | NVARCHAR(100)   | Encrypted password         |
| RoleId         | INT             | Role of the user           |
| CreatedOn      | DATETIME        | Record creation date       |
Tickets
| Column            | Type            | Description                 |
|-------------------|-----------------|-----------------------------|
| TicketId          | INT             | Primary key                 |
| TicketTypeId      | INT             | Type of the ticket          |
| DepartmentId      | INT             | Department handling ticket  |
| TicketTitle       | NVARCHAR(150)   | Title of the ticket         |
| TicketDescription | NVARCHAR(MAX)   | Description of the ticket   |
| StatusId          | INT             | Status of the ticket        |
| CreatedOn         | DATETIME        | Record creation date        |
| CreatedBy         | UNIQUEIDENTIFIER| User who created the ticket |
| ModifiedOn        | DATETIME        | Record modification date    |
| ModifiedBy        | UNIQUEIDENTIFIER| User who modified the ticket|
UserProfile
| Column      | Type            | Description                |
|-------------|-----------------|----------------------------|
| ProfileId   | UNIQUEIDENTIFIER| Primary key                |
| UserId      | UNIQUEIDENTIFIER| Foreign key to Users table |
| DisplayName | NVARCHAR(20)    | User's display name        |
| GenderId    | INT             | User's gender              |
| CountryId   | INT             | User's country             |
| CreatedOn   | DATETIME        | Record creation date       |
| CreatedBy   | UNIQUEIDENTIFIER| User who created the record|
| ModifiedOn  | DATETIME        | Record modification date   |
| ModifiedBy  | UNIQUEIDENTIFIER| User who modified the record|
Agents
| Column    | Type            | Description                |
|-----------|-----------------|----------------------------|
| AgentId   | UNIQUEIDENTIFIER| Primary key                |
| UserId    | UNIQUEIDENTIFIER| Foreign key to Users table |
| CreatedOn | DATETIME        | Record creation date       |
| CreatedBy | UNIQUEIDENTIFIER| User who created the record|

**There also other tables but not included in this file, you can find schema script uploaded in DB Scripts folder in this repo.**

Stored Procedures
•	usp_CreateAgent
•	usp_CreateTicket
•	usp_DeleteAgent
•	usp_DeleteTicket
•	usp_GetAgentById
•	usp_GetAgentsPaginated
•	usp_GetAllAgents
•	usp_GetAllTickets
•	usp_GetMasterData
•	usp_GetTicketById
•	usp_GetTicketByUser
•	usp_GetTicketsByAgent
•	usp_GetTicketsWithAgent
•	usp_GetUserProfile
•	usp_RegisterUser
•	usp_UpdateAgent
•	usp_UpdateTicket
•	usp_UpdateUserProfile
•	usp_UpsertAgentTicketMapping
•	usp_ValidateUser

Security
- Passwords are encrypted using AES before storing them in the database.
- JWT tokens are used for securing API endpoints.
  
Contact
**For Admin Login use :
 email address - akashmadhu824@gmail.com
 password - 19891181Aa***

**Please find the ERD Diagram & API Document attached below
ERD - ![TicketDesk_ERD](https://github.com/akashmadhuCodeZone/TicketDeskApp/assets/173632323/b3ceeb98-3914-48e4-94d9-0192d1b2e90f)
API Document - [TicketDesk_APIDocumentation.docx](https://github.com/user-attachments/files/16075900/TicketDesk_APIDocumentation.docx)**


For further queries, please contact akashmadhu824@gmail.com.
