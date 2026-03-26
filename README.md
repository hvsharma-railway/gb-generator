# GB Generator (Docker)

Dockerized setup for `gb-generator` with PHP 7.4, MySQL, and phpMyAdmin.

## 🔧 Requirements
- Docker
- Docker Compose

## 🚀 Start
1. Copy `.env.example` or set env vars:
   - `APP_PORT` (default: `8081`)
   - `PHPMYADMIN_PORT` (default: `8082`)

2. Start services:

```bash
docker compose up --build -d
```

3. Confirm ports:

```bash
docker compose ps
```

4. Open in browser:
- App: `http://localhost:${APP_PORT:-8081}`
- phpMyAdmin: `http://localhost:${PHPMYADMIN_PORT:-8082}`

## 🗄️ DB creds
- Host: `db` (from container network)
- Port: `3306`
- DB: `gb_generator`
- User: `gb_user`
- Password: `gb_pass`
- Root: `rootpassword`

## 🔗 App DB integration
`src/conn.php` uses env variables:
- `DB_HOST`
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`

Docker-compose sets these automatically for the app container.

## 🛑 Stop and clean

```bash
docker compose down -v
```
