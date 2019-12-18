# CarRepairTracker
Car Repair Web Application using .Net API back-end and Vue for front-end. Allows customer to request a repair, approve particular repairs, and keep track of the status at every step of process. And employees to process and update repair requests.

(Partners: Kevin Schott, Jason Thomas & Jess Foltz)

**Still Work In Progress - Will Update When done.**

To Use:
** Run SQL script in CarRepairWebApi\CarRepairService\DAOs\Scripts to build the database
** Run npm install in VS Code console to install the required node modules
** Run CarRepairWebApi in VS and car-repair-vue npm run serve in VS Code console
** No default data added to the database yet, will have to register new customer and add incident to see anything.
** To log in as Employee, there is a default Admin account added when you run the sql script, to login the username is "Admin" and the password is "pass".

Personal work:

(Back End API)
1) I wrote most/all of the API controller methods, others worked on them but often I at least adjusted them to work as intended.
2) I did everything related to user authentication, except the new controller method for an admin adding a new employee/admin.
 -- Though many of the user security files were files I adapted from another project Tech Elevator gave me, but I had to adapt them to work with the current one. Everything in the controller except that new method was done by hand.
4) I wrote a few of the DAO methods, like the GetIncidentsbyUser and GetUserbyId ones, but most of those were written by my partners (Jason mainly, but also Kevin). I was usually just filling in gaps that I came across.
5) I take no credit for the tests that are in there, all credit goes to Kevin for those.
6) I worked together with Kevin to design the SQL database.

(Front End Vue)
1) I wrote most of code in the script tags was written by me.
    -- I got the API calls and methods to work but they were adapted from the same files from the project for the user authentication in the API.
    -- On the vue side, I've been mainly handling getting the components to pass the information required between them, getting the data from the API and some manipulating of it, like with the cost totals.
2) Other components were done by others, like the AddRepairLine (Jason), AddEmployee (Kevin).
    -- I'm probably forgetting a few though, as I've been weaving in and out of these files so much I've lost track of what I did originally did and what I worked with after the fact. So please don't take this as me taking credit for everything else.
3) CSS work, html structure, vue work was done/overseen by Jesse. The only parts that are mine are basic work to let me prototype the page quickly and make sure the js for it was working when I got ahead of where Jesse was. (Example: Incident Details view in this upload.)
    -- I expect most of that work with get replaced as he goes through it.
4) Jesse was the one in charge of the vue front end, I've been trying to keep in line for what he wants/needs for it.