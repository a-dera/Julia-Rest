# Julia-Rest
> Un API JSON et MySQL, codé en Julia 

## Installation 

* Vous devez  [https://julialang.org/downloads/](installer Julia) sur votre machine au préalable pour tester l'API.
* Installez ensite les dependences en éxécutant les commandes suivantes
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
