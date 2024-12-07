
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

### 3. First Run Setup

You will need to:

1. **Generate the Application Key**:
   ```bash
   docker exec --user www-data -it koeldev php artisan key:generate
   ```

2. **Configure the Database**:
   Run the following command to complete the setup:
   ```bash
   docker exec --user www-data -it koeldev php artisan koel:init --no-assets
   ```

   This will initialize the database and set up Koel.

---

## 📖 Usage

### Running the Services

| Command                                         | Description                                  |
|------------------------------------------------|----------------------------------------------|
| `docker-compose -f docker-compose.mysql.yml up`   | Start all services                           |
| `docker-compose -f docker-compose.mysql.yml down` | Stop all services                            |
| `docker-compose -f docker-compose.mysql.yml logs` | View logs for all containers                 |
| `docker exec -it <container_name> bash`         | Access a running container                   |

---

## 🔧 Configuration

### Default Admin Credentials

Koel automatically creates an admin account with the following credentials:

- **Email**: `admin@koel.dev`
- **Password**: `KoelIsCool`

You should update this password for security purposes. Run the following command to change the admin password:

```bash
docker exec -it koeldev php artisan koel:admin:change-password
```

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

## 📚 Resources

- [Koel Documentation](https://koel.pages.dev/)
- [MariaDB Documentation](https://mariadb.org/documentation/)

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

<p align="center">Made with ❤️ by <a href="https://github.com/lafllamme">lafllamme</a></p>

---
