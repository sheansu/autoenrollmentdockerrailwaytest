# Complete Setup and Deployment Guide

CED Pre-Enrollment System · Windows 11 · Docker Desktop · MySQL 8.4 · Node.js 22 · GitHub · Railway

This guide recreates the development and deployment setup on your friend's computer, starting from a Windows PC without Docker or Railway.

I inspected your latest uploaded project ZIP and tailored the instructions to its actual configuration, including `compose.yaml`, `dockerfile`, `config/db.js`, `config/itDb.js`, `server.js`, and the SQL files.

The guide covers local setup, importing the database, GitHub, Railway deployment, testing, and transferring updated Docker data to Railway.

## 1. Understand how the system works

The two MySQL databases are separate. Pushing code to GitHub can trigger a Railway application deployment, but it does not automatically transfer database records.

## 2. Install the required software

[Docker Desktop Review 2026: Container Development Made Simple](https://images.openai.com/static-rsc-4/WUvbItBSu5-VKimWTjpPD-zxX33IHx_jTVc3RpgxFaR8ZmnDw5PZ0pBc4Fk3tcpHsNHYMOxK6waFpKEZ0_BEoazN5XFRnBIQrGFmEENP4bb9WNdl9ASIPb5UKr7Hru8oJeyNfP8ZZ7uFbsPRW16rzi2HhlK6VM74Lhp-bZt1jRE?purpose=inline)

Docker Desktop

Install from [docker.com](https://www.docker.com/products/docker-desktop/). Use the Windows WSL 2 backend and enable virtualization if required.

[Git アイコン、ロゴ、シンボル – 無料ダウンロード PNG、SVG](https://images.openai.com/static-rsc-4/Sb9O7jvMvZHvARi9aABeXIsBR0rd39FouCmFfFC--ZTHNXo79OH1i9deenC1xIJDeNhErgpYvCNupQ86CyufXxgmC_VQuaWQJaVMQ1Bu_NZ1pz9CTE0V2o-hLrSXkvABahTtp3cJmsi0qPnuLXNK6XMJdccgzbVA2YTQJZF6slM?purpose=inline)

Git for Windows

Install from [git-scm.com](https://git-scm.com/downloads/win). This is used for version control and pushing code to GitHub.

[precis0x (@precisox) on X](https://images.openai.com/static-rsc-4/6UGebdew9WxthPsgkQBRJ_JmTfWW_y7agnczvltWrIQT3Fya6scbDbI6iPx5bLk5AYaAZn6vZ0m2arJ8MWgkkjeh-UTDFj7T_xmY-oHzvDmme3uha0Wp-xi3VPGSmRx9jEKG5QFBxu5oc1sgdei7nH2rGCbyU3I1ifuv0lVXmu0?purpose=inline)

Visual Studio Code

Install from [code.visualstudio.com](https://code.visualstudio.com/) to edit the project and use its integrated PowerShell terminal.

[Pengenalan Node JS Lengkap + Cara Install - Teziger Blog](https://images.openai.com/static-rsc-4/yhb6L_zHD89hq9StVnKJSbhV5YpcjpuXaUiwKe3Yd0Q3p8qLiwTo4xoM6cgkONkAC2R8lMT8_9O1FOAg1f3t88UK4wnh_g7GSnUoengav4u4Cuy4V1KWDeoEr_8EXAvRqrXtBzD4mBtIunoq3hjYaw1TePJfYx8Vj52vuhBOF50?purpose=inline)

Node.js 22 LTS

Install from [nodejs.org](https://nodejs.org/en/download). This is useful for local development outside Docker; Docker itself already supplies Node.js.

Also create a [GitHub account](https://github.com/signup) and a [Railway account](https://railway.com/). Railway may require billing setup or an eligible trial to run the services.

After installation, restart Windows if prompted, launch Docker Desktop, and wait until its engine is running.

Open PowerShell and verify:

```
docker --version
docker compose version
git --version
node --version
npm --version
```

## 3. Prepare the project files

Your ZIP contains the actual application, but also contains `.env`, Git history, SQL exports, and backups. Do not send the ZIP unchanged to your friend or upload it publicly. It can expose credentials and student information.

Create a clean project copy containing the application code, `compose.yaml`, `dockerfile`, `package.json`, `package-lock.json`, and an approved sanitized `database.sql`.

Exclude `.env`, `.git`, `node_modules`, personal database backups, and real student data. If the existing `.env` or SQL exports were shared beyond trusted developers, rotate the affected credentials.

The cleaned project should resemble:

```
ced-pre-enrollment/
├── config/
│   ├── db.js
│   └── itDb.js
├── middleware/
├── routes/
├── public/
├── compose.yaml
├── dockerfile
├── database.sql
├── package.json
├── package-lock.json
├── server.js
├── .dockerignore
├── .gitignore
└── .env             ← created privately on each PC
```

Your current `compose.yaml` expects a file named `database.sql` at the project root.

## 4. Configure the local environment

Create `.env` in the project root with these settings:

```
PORT=5000

DB_HOST=mysql
DB_PORT=3306
DB_USER=ced_app
DB_PASSWORD=replace_with_app_password
DB_NAME=ced_preenrollment

MYSQL_ROOT_PASSWORD=replace_with_root_password
MYSQL_APP_PASSWORD=replace_with_app_password

JWT_SECRET=replace_with_long_random_secret
```

The `DB_PASSWORD` and `MYSQL_APP_PASSWORD` values should match because your Compose file creates the `ced_app` database user using `MYSQL_APP_PASSWORD`.

Generate strong random values with PowerShell rather than reusing passwords:

```
$bytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
[Convert]::ToBase64String($bytes)
```

Run it separately for each secret.

Your project also has a secondary IT database connection in `config/itDb.js`. If your friend needs the IT synchronization feature, configure `IT_DB_HOST`, `IT_DB_PORT`, `IT_DB_USER`, `IT_DB_PASSWORD`, and `IT_DB_NAME` for a separately provisioned IT database. The current Compose file does not create that secondary database automatically.

Make sure `.gitignore` includes:

```
node_modules/
.env
.env.*
!.env.example
db-backups/
```

The SQL seed file should also be ignored if it contains real records or password hashes.

## 5. Run the project using Docker

Open PowerShell in the extracted project folder:

```
cd C:\Users\YOURNAME\Documents\ced-pre-enrollment
```

Build and start the containers:

```
docker compose up --build -d
```

Check their status:

```
docker compose ps
```

Your Compose configuration creates two containers:

| Container   | Purpose                 | Local port |
| ----------- | ----------------------- | ---------- |
| `ced-app`   | Node.js/Express website | `5000`     |
| `ced-mysql` | MySQL 8.4 database      | `3307`     |

The MySQL container uses port `3306` internally, but exposes port `3307` on Windows.

Open:

[http://localhost:5000](http://localhost:5000)

If the database is initialized correctly, your friend should see the login page.

Important: MySQL executes `database.sql` automatically only when its data volume is initialized for the first time. Rebuilding the containers does not rerun that SQL file against an existing database.

## 6. Verify the local MySQL database

Open PowerShell:

```
docker exec -it ced-mysql mysql -u root -p ced_preenrollment
```

Enter the `MYSQL_ROOT_PASSWORD` from your friend's `.env`.

At the `mysql>` prompt:

```
SHOW FULL TABLES;
```

Then:

```
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_users FROM users;
```

The current Docker export you supplied contains 18 base tables, one view, 10 students, and 13 users. A sanitized starter database may have different counts.

Exit:

```
exit;
```

### If the local database is empty or missing tables

First inspect the logs:

```
docker compose logs mysql --tail 100
```

The usual causes are an invalid `database.sql`, a failed initialization query, or a previously initialized MySQL volume.

For a new disposable local setup only, if your friend confirms that no data needs preserving, reset and initialize from the SQL seed:

```
docker compose down -v
docker compose up --build -d
```

`down -v` permanently deletes the local MySQL volume. Never run it on a database containing records you want to keep.

## 7. Test the application locally

Test the main features before deploying:

Local testing checklist

0/9

Login page loads

Admin login works

Admin dashboard retrieves records

Student login and dashboard work

Teacher login and dashboard work

Business office dashboard works

Student registration creates the expected records

Enrollment, advising, and grading actions work

Changes remain after refreshing the page

To see application errors:

```
docker compose logs app --tail 100
```

To follow logs continuously:

```
docker compose logs -f app
```

Press Ctrl+C to stop following logs; this does not stop the container.

To stop the application without deleting data:

```
docker compose down
```

To start it again:

```
docker compose up -d
```

## 8. Create a GitHub repository

Sign in to [GitHub](https://github.com) and create a new private repository, for example `ced-pre-enrollment`.

Before committing, verify that your `.env` and database backups are excluded:

```
git status
```

For a clean project that isn't already a Git repository:

```
git init
git branch -M main
git add .
git status
git commit -m "Initial CED pre-enrollment setup"
```

Connect it to your friend's new repository:

```
git remote add origin https://github.com/USERNAME/ced-pre-enrollment.git
git push -u origin main
```

Replace `USERNAME` with the GitHub account name.

If the project was cloned from your existing repository, don't run `git init` again. Instead, check the current remote with:

```
git remote -v
```

Your friend can either collaborate on your repository or push a clean copy to their own repository.

Before pushing, make sure `.env`, student data, database dumps, and passwords aren't tracked. `.gitignore` does not remove files already committed to Git history.

## 9. Create a Railway project

Open [Railway](https://railway.com/) and sign in with GitHub.

Create a new project, choose deployment from a GitHub repository, and select the cleaned CED pre-enrollment repository.

Railway should detect your `dockerfile` and build the Node.js application.

In the application service settings, select Dockerfile as the builder if necessary. Your file is named lowercase `dockerfile`, so if Railway doesn't detect it automatically, set the Dockerfile path explicitly to `dockerfile`, or rename it to `Dockerfile` and commit the change.

The container starts the app using:

```
CMD ["node", "server.js"]
```

Your `server.js` already listens on `process.env.PORT || 5000`, which is appropriate for Railway.

## 10. Add Railway MySQL

Inside the Railway project, add a MySQL database service.

Railway will provision the database and expose connection variables. You should see values corresponding to:

- `MYSQLHOST`
- `MYSQLPORT`
- `MYSQLUSER`
- `MYSQLPASSWORD`
- `MYSQLDATABASE`

The exact public proxy hostname and port are specific to each database. Your friend's database will not necessarily use the same address or port as yours.

## 11. Connect the Railway application to MySQL

Open the application service, not the MySQL service, and go to Variables.

Your current `config/db.js` supports both `MYSQL*` and `DB_*` variable names.

Set the following variables using Railway references to the MySQL service:

| Application variable | Railway value              |
| -------------------- | -------------------------- |
| `MYSQLHOST`          | `${{MySQL.MYSQLHOST}}`     |
| `MYSQLPORT`          | `${{MySQL.MYSQLPORT}}`     |
| `MYSQLUSER`          | `${{MySQL.MYSQLUSER}}`     |
| `MYSQLPASSWORD`      | `${{MySQL.MYSQLPASSWORD}}` |
| `MYSQLDATABASE`      | `${{MySQL.MYSQLDATABASE}}` |
| `JWT_SECRET`         | A new strong secret        |

These references assume the database service is named `MySQL`. Adjust the service name if different.

Your application uses this configuration:

```
const dbConfig = {
  host: process.env.MYSQLHOST || process.env.DB_HOST || 'localhost',
  user: process.env.MYSQLUSER || process.env.DB_USER || 'root',
  password: process.env.MYSQLPASSWORD || process.env.DB_PASSWORD || '',
  database: process.env.MYSQLDATABASE || process.env.DB_NAME || 'ced_preenrollment',
  port: process.env.MYSQLPORT || process.env.DB_PORT || 3306,
};
```

This is already compatible with Railway's MySQL variables.

Do not set `MYSQLHOST` to `localhost`, your Windows IP address, or your local Docker service name on Railway.

## 12. Generate a public website address

In the Railway application service, open the Networking or Settings section and generate a public domain.

Your website will have an address similar to:

```
https://your-project.up.railway.app
```

Visit that address and confirm the login page loads.

Your current frontend dashboards use:

```
const API = window.location.origin;
```

That is the correct approach for a frontend served by the same Express application, because it works both locally and on Railway.

Your `server.js` also contains a CORS allowlist with your original Railway domain. If your friend receives a different domain, update that allowlist if cross-origin access is needed. For same-origin requests, CORS permission is normally unnecessary.

At this stage, the website may load while login still fails. That's expected until the Railway database has been initialized.

## 13. Install the MySQL command-line client on Windows

Your friend needs the `mysql` and `mysqldump` commands to transfer databases from Docker to Railway.

Install MySQL using [MySQL Installer for Windows](https://dev.mysql.com/downloads/installer/) or the standalone [MySQL distribution](https://dev.mysql.com/downloads/mysql/).

The MySQL command-line tools are sufficient; a second local MySQL server is not necessary because Docker already runs MySQL.

Restart PowerShell and verify:

```
mysql --version
mysqldump --version
```

If Windows cannot find these commands, add the installed MySQL `bin` directory to the Windows PATH.

## 14. Export the local Docker database

Open PowerShell in the project directory.

Create a backup folder:

```
New-Item -ItemType Directory -Force .\db-backups
```

Export the Docker database:

```
docker exec ced-mysql sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --single-transaction --routines --triggers ced_preenrollment > /tmp/database.sql'
```

The password warning is expected. However, any other error should be investigated before continuing.

Verify the file:

```
docker exec ced-mysql ls -lh /tmp/database.sql
```

Copy it to Windows:

```
docker cp ced-mysql:/tmp/database.sql .\db-backups\docker_latest.sql
```

Verify:

```
Get-Item .\db-backups\docker_latest.sql
```

Check its table definitions:

```
(Select-String .\db-backups\docker_latest.sql -Pattern '^CREATE TABLE').Count
```

For your current project, this should return `18`.

Check for statements that could change the destination database or cause import problems:

```
Select-String .\db-backups\docker_latest.sql -Pattern 'CREATE DATABASE|^USE |DEFINER='
```

If `DEFINER=` appears, inspect the view or routine definition and confirm that the referenced MySQL account exists or adapt the definition for the target environment. Don't blindly remove SQL clauses without checking their effect.

## 15. Import into a new Railway database

For a newly provisioned, empty Railway database, this is much easier than replacing an existing database.

In Railway, open the MySQL service's connection settings and enable or locate its public TCP connection.

You'll receive a hostname and port specific to your friend's Railway project.

Connect from PowerShell:

```
mysql -h YOUR_PROXY_HOST -P YOUR_PROXY_PORT -u root -p --protocol=TCP railway
```

Replace the host and port with the actual Railway connection details. Use the provided database username if it isn't `root`.

Enter the password when prompted.

Verify:

```
SELECT DATABASE();
SHOW FULL TABLES;
```

If this is a fresh empty database, `SHOW FULL TABLES` should show no tables or views.

Exit:

```
exit;
```

Now import:

```
cmd /c 'mysql -h YOUR_PROXY_HOST -P YOUR_PROXY_PORT -u root -p --protocol=TCP railway < db-backups\docker_latest.sql'
```

Enter the Railway password.

If the command completes without SQL errors, reconnect and verify:

```
SHOW FULL TABLES;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_users FROM users;
```

For the current full Docker export, the expected counts are 10 students and 13 users. A sanitized demo database may have different counts.

Do not use this fresh-database procedure on an existing populated Railway database. Your dump contains table-drop statements, so importing it could destroy existing records.

## 16. Updating Railway after local database changes

This was one of the most important lessons from your earlier setup: Docker MySQL and Railway MySQL do not automatically synchronize.

There are two separate update workflows:

| Change                                         | Required action                                         |
| ---------------------------------------------- | ------------------------------------------------------- |
| Edit HTML, JavaScript, or Express routes       | Commit and push to GitHub                               |
| Add students, teachers, or enrollments locally | Export and transfer database records                    |
| Change table structures                        | Apply a reviewed SQL migration                          |
| Change Railway environment variables           | Update Railway service variables and redeploy if needed |

For a future complete database replacement, use this safer procedure:

1. Stop writes to the Railway application.
2. Export a fresh Docker SQL dump.
3. Back up Railway with `mysqldump`.
4. Confirm the backup is readable and includes all existing tables and views.
5. Inspect the source dump for database-switching statements, views, definers, and table dependencies.
6. Confirm that all Railway-only records may be discarded.
7. Replace the existing schema using a reviewed cleanup or migration script.
8. Import the Docker dump once, without ignoring errors.
9. Compare table names, row counts, and key records.
10. Test all application roles before reopening the website.

For example, back up Railway with:

```
mysqldump -h YOUR_PROXY_HOST -P YOUR_PROXY_PORT -u root -p --protocol=TCP --single-transaction --routines --triggers --set-gtid-purged=OFF railway --result-file=.\db-backups\railway_before_replace.sql
```

If the export fails, do not proceed with a replacement.

I would avoid treating a full database replacement as a normal daily workflow. Once real users begin using Railway, overwriting it with local data can erase their changes. SQL migrations and controlled record synchronization are better long-term approaches.

## 17. Deploy code changes from your friend's computer

Once GitHub and Railway are connected, the usual workflow is straightforward.

Edit the application locally, test it, then run:

```
git status
git add .
git commit -m "Describe the changes"
git push origin main
```

If automatic deployments are enabled, Railway will build and deploy the new code.

Check the deployment logs and verify the website.

Remember: `git push` deploys code. It does not transfer the Docker MySQL volume.

## 18. Troubleshooting reference

| Problem                                   | Likely cause                                        | First thing to check           |
| ----------------------------------------- | --------------------------------------------------- | ------------------------------ |
| Docker won't start                        | WSL 2 or virtualization issue                       | Docker Desktop status          |
| Website won't open locally                | App container stopped or port conflict              | `docker compose ps`            |
| `ER_NO_SUCH_TABLE`                        | Database schema not imported                        | `SHOW TABLES;`                 |
| Login works but dashboard is empty        | Missing data, failed query, or frontend error       | Browser Network tab            |
| `ERROR 1045`                              | Wrong password or username                          | Connection credentials         |
| `ERROR 1050`                              | Table already exists                                | Stop importing; inspect target |
| Railway website fails to connect to MySQL | Incorrect variables or database service unavailable | Application deployment logs    |
| Docker records differ from Railway        | Databases are independent                           | Compare SQL row counts         |
| `mysql` is not recognized                 | Client missing from PATH                            | `mysql --version`              |
| IT synchronization fails                  | Secondary IT database not configured                | `IT_DB_*` variables            |

For local application logs:

```
docker compose logs app --tail 100
```

For MySQL logs:

```
docker compose logs mysql --tail 100
```

For Railway, use the relevant service's deployment logs.

## 19. Security and production-readiness checks

Your latest project is deployable, but it should be treated as a development or test deployment until its authorization, registration, grading, and database-write logic have been fully tested.

Before using real student information, make sure that passwords aren't logged, teacher actions are authorized server-side, registration uses transactions, predictable default passwords are removed, and all users have appropriately limited permissions.

Your uploaded project also contains real-looking student records, password hashes, environment secrets, and Git history. Prepare a sanitized version before sharing it with your friend.

## Final setup checklist

## Installation progress

0%

Docker Desktop installed and running

Git, VS Code, and Node.js installed

Clean project copied or cloned

Private .env configured

Docker containers running

Local database initialized

Local login and dashboards tested

GitHub repository created and code pushed

Railway application deployed

Railway MySQL service created

Railway environment variables configured

Public Railway domain generated

MySQL client installed

Docker SQL export verified

Railway database imported

Railway record counts verified

All four user roles tested online

Secrets and SQL backups excluded from GitHub

Reset checklist Copy progress

Once all checks pass, your friend will have an independent local Docker development environment and a Railway-hosted copy of the CED Pre-Enrollment System.

One final recommendation: If you and your friend will work on the same system, use one shared GitHub repository with separate branches or pull requests, and agree on which database is the source of truth. This will prevent the code conflicts and database mismatches you encountered during your first deployment.