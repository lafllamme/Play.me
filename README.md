<h1 align="center">🎵 Play.me: Dockerized Koel with MariaDB</h1>

<p align="center">
  A custom Docker setup for running <a href="https://koel.dev/">Koel</a>, the simple and elegant personal music streaming service, with MariaDB as the database backend.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-Enabled-blue" alt="Docker">
  <img src="https://img.shields.io/badge/MariaDB-10.11-blueviolet" alt="MariaDB">
  <a href="https://github.com/lafllamme/Play.me/commits/main"><img src="https://img.shields.io/github/last-commit/lafllamme/Play.me" alt="Last Commit"></a>
  <a href="https://github.com/lafllamme/Play.me/issues"><img src="https://img.shields.io/github/issues/lafllamme/Play.me" alt="Open Issues"></a>
</p>

---

## 🚀 Features

- **Customized Docker Configuration**: A tailored setup specifically for Koel with MariaDB support.
- **Seamless Initialization**: Includes steps for setting up app keys and database connections with ease.
- **Improved Scalability**: Docker Compose for managing services efficiently.

---

## 🛠 Prerequisites

Ensure the following are installed:

- [Docker](https://www.docker.com/get-started) (latest version)
- [Docker Compose](https://docs.docker.com/compose/install/) (latest version)

---

## ⚙️ Setup & Installation
### 🔑 Credentials

> After a successful setup, the default admin credentials are:  
> Email: `admin@koel.dev`  
> Password: `KoelIsCool`
>
> These can be changed later for security purposes.

### 1. Clone the Repository

```bash
git clone https://github.com/lafllamme/Play.me.git
cd Play.me
```

### 2. Start the Services

Run the custom Docker Compose file designed for MariaDB:

```bash
docker-compose -f ./docker-compose.mysql.yml up -d
```

>admin@koel.dev

---

### 3. First Run Setup

On the first run, follow these steps:

#### Generate the `APP_KEY`
Run the following command to generate the app key:
```bash
docker exec --user www-data -it koeldev php artisan key:generate
```

#### Set Up the Database
Initialize the database connection and setup:
```bash
docker exec --user www-data -it koeldev php artisan koel:init --no-assets
```

This will use the environment variables set in `docker-compose.mysql.yml` to configure the database connection.

#### Verify Database Login
You can verify the database connection using the credentials specified in the `docker-compose.mysql.yml` file:

For the **Koel user**:
```bash
docker exec -it docker-database-1 mysql -u koel -p koel
```
For the **Root user**:
```bash
docker exec -it docker-database-1 mysql -u root
```

You will be prompted to enter the passwords (`koel` and `root` respectively, as per your environment variables).

---

### 4. Connecting to Your Database

If you'd like to connect the Koel application to the database manually or troubleshoot the connection, ensure the following environment variables in `docker-compose.mysql.yml` are correct:
```yaml
environment:
  - DB_CONNECTION=mysql
  - DB_HOST=database
  - DB_DATABASE=koel
  - DB_USERNAME=koel
  - DB_PASSWORD=koel
```

You can edit these directly in the `docker-compose.mysql.yml` file and restart the services:
```bash
docker-compose -f ./docker-compose.mysql.yml down
docker-compose -f ./docker-compose.mysql.yml up -d
```

---

## 📖 Usage

### Running the Services

| Command                                         | Description                                  |
|------------------------------------------------|----------------------------------------------|
| `docker-compose -f docker-compose.mysql.yml up`   | Start all services                           |
| `docker-compose -f docker-compose.mysql.yml down` | Stop all services                            |
| `docker-compose -f docker-compose.mysql.yml logs` | View logs for all containers                 |
| `docker exec -it <container_name> bash`         | Access a running container                   |


<img src="https://i.imgur.com/fku5s1z.png">
---

## 🗂 Project Structure

```plaintext
/Play.me
│
├── docker-compose.mysql.yml
├── Dockerfile
├── .env.example
└── ...
```

---

## 🌟 Why This Fork?

This repository is a fork of the original [Koel Docker repository](https://github.com/koel/docker) with customized changes for personal usage. It adds:

1. **MariaDB Support**: A ready-to-use `docker-compose.mysql.yml` file.
2. **Simplified Setup**: Adjustments for easier initialization and app configuration.


---

## 🎶 Managing Your Music Library

To ensure that new music added to the `/music` folder is available in Koel, you need to manually scan the library. Similarly, if you're using a version of Koel prior to v5.0.2, you'll need to populate the search indexes for efficient search functionality.

---

### Scanning Music Folders

Run the following command to scan your music library:

```bash
docker exec --user www-data -it koeldev php artisan koel:sync
```

This command synchronizes the music files in the `/music` volume with the database. You can also use the `Makefile` for convenience:

```bash
make sync-music
```

---

### Populating Search Indexes
Search indexes for new songs are automatically updated when you run 
`php artisan koel:sync`. You only need to manually run the 
`koel:search:import` command once for existing songs.

---

### Summary of Makefile Commands

| Command           | Description                                         |
|-------------------|-----------------------------------------------------|
| `make sync-music` | Sync the `/music` folder with the database.          |
| `make koel-init`  | Initialize the application with an `APP_KEY`.        |
| `make clear-cache`| Clear cached data to resolve potential errors.       |

By using the `Makefile`, you can streamline recurring tasks for managing your Koel setup.

---

## 📚 Resources

- [Koel Documentation](https://koel.pages.dev/)
- [MariaDB Documentation](https://mariadb.org/documentation/)

---
## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

<p align="center">Made with ❤️ by <a href="https://github.com/lafllamme">lafllamme</a></p>
