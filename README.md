### Elixir Phoenix Docker
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

###### Build and run docker as usual
```
docker-compose build
docker-compose up
```

###### Run any command inside phoenix app with run.sh script
```
#For instance:
sh run.sh mix ecto.create
```

Enjoy :)
