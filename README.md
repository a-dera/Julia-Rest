# Julia-Rest
> Un API JSON et MySQL, codé en Julia 

## Installation 

* Vous devez [installer Julia](https://julialang.org/downloads/) sur votre machine au préalable pour tester l'API.
* Installez ensuite les dependences en éxécutant les commandes suivantes
    ```bash
    julia
    julia> Pkg.add("HttpServer")
    julia> Pkg.add("MySQL")
    julia> Pkg.add("HttpCommon")
    julia> Pkg.add("JSON")
    ```
* Run the content of **database.sql** in your MySQL manager.
## Demarrez le serveur
* Exécuter la commande suivante au sein du dossier principal:
    ```bash
    julia main.jl
    ```
<br>
Consulter à l'adresse **localhost:8000**  sur votre navigateur.
