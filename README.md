# julia-rest-api
> A JSON and MySQL API made in Julia
## Purpose
I'm just trying to learn something new. Julia seemed like an awesome language, and I decided to make this.
## Installing Julia
You need to install Julia on your machine to test the API. You can find the binary equivalent to your OS in [https://julialang.org/downloads/](https://julialang.org/downloads/).
## Installing dependencies
While I don't know if Julia have a simplest way to install all the dependencies, you'll need to install all the packages manually. To do this, run this on your terminal:
```bash
julia
julia> Pkg.add("HttpServer")
julia> Pkg.add("MySQL")
julia> Pkg.add("HttpCommon")
julia> Pkg.add("JSON")
```
# Setting up the database
Run the content of **database.sql** in your MySQL manager.
# Starting the server
Inside the API folder, just run:
```bash
julia main.jl
```
And then, the server will be running at **localhost:8000**.
