# Elixir Phoenix & Docker
This project helps you to start a new phoenix project with Docker
ecosystem. Following the next steps your project should be created
and will be ready to start coding

###### Create app folder
```
mkdir app
```
###### Create a fresh phoenix project
```
docker-compose run --rm phoenix mix phx.new . --app your_app_name
```

###### Say Y to docker prompt question to override app folder
```
The directory /app already exists. Are you sure you want to continue? [Yn] Y
```

###### Setting your config and env variables
Set env vars from .env file according to your needs
```
PG_USER="postgres"
PG_PASSWORD="postgres"
PG_DATABASE="your-db-name"
PG_PORT=5432
PG_HOST="db"
APP_PORT=4000
....
```

Update your config.dev file. Keep in mind the your_app_name placeholders.
```
# Configure your database
config :your_app_name, YourApp.Repo,
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: System.get_env("PG_DATABASE"),
  hostname: System.get_env("PG_HOST"),
  port: System.get_env("PG_PORT"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

###### Build and run docker as usual
```
docker-compose build
docker-compose up
```

###### Run any command inside phoenix app with run.sh helper script
```
#For instance:
sh run.sh mix ecto.create
```

Enjoy :)