# Django Docker PostGIS

A base project for setting up a Dockerized Django application with PostGIS support. This repository provides a minimal setup to get started with Django and PostGIS, including support for testing and linting within a containerized environment.

## Features

- Dockerized Django application.
- PostGIS support for advanced geospatial data handling.
- Pre-configured for local development and testing.
- Linting and testing commands for clean and robust code.

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Clone the Repository

```bash
git clone https://github.com/marioalejandrom/django-docker-postgis.git
cd django-docker-postgis
```

### Build and Start the Containers

```bash
docker compose up --build
```

This will:
- Build the Docker images for the Django app and PostGIS database.
- Start the containers defined in the `docker-compose.yml` file.

### Run Migrations

Run the migrations to set up the database schema:

```bash
docker compose run --rm web python manage.py migrate
```

### Create a Superuser

To access the Django admin, create a superuser:

```bash
docker compose run --rm web python manage.py createsuperuser
```

### Access the Application

The Django application will be available at:

- **Web**: [http://localhost:8000](http://localhost:8000)
- **Admin Panel**: [http://localhost:8000/admin](http://localhost:8000/admin)

### Shut Down the Containers

To stop and remove all containers:

```bash
docker compose down
```

## Testing and Linting

### Run Linting with Flake8

To ensure code quality, run Flake8:

```bash
docker compose run --rm web flake8
```

### Run Tests

Run the Django test suite:

```bash
docker compose run --rm web python manage.py test
```

### Combined Linting and Testing

Run linting and tests together:

```bash
docker compose run --rm web sh -c "flake8 && python manage.py test"
```

## Environment Variables

This project uses environment variables for configuration. You can define these variables in a `.env` file for local development. Example:

```env
DEBUG=True
SECRET_KEY=your-secret-key
DATABASE_URL=postgis://user:password@db:5432/dbname
```

## Adding New Dependencies

If you need to add Python packages, update the `requirements.txt` or `requirements.dev.txt` file, then rebuild the Docker image:

```bash
docker compose build
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to customize this repository to suit your project's needs!

