# Importations
using HttpServer
using MySQL
import HttpCommon
import JSON

# Structure de type post 
struct Post
    id::Int32
    titre::String
    description::String
    date_publication::DateTime
end

#connexion à la base de données
conn = mysql_connect("localhost", "root", "", "julia_rest")

#Handler 
handler = HttpHandler() do req::Request, res::Response
    responseHeaders = HttpCommon.headers()
    responseHeaders["Access-Control-Allow-Origin"] = "*"
    responseHeaders["Content-Type"] = "application/json"
    responseStatus = 200
    if length(req.data) > 0
        requestData = JSON.parse(String(req.data))
    end
    if req.resource == "/posts"
        # methode GET, retourne tous les posts disponibles
        if req.method == "GET"
            posts = Post[]
            for row in MySQLRowIterator(conn, "SELECT * FROM posts")
                push!(posts, Post(row[1], row[2], row[3]))
            end
            responseData = posts
        end
        # méthode POST, ajout un post à la base de donnée
        if req.method == "POST"
            # TODO #1 Récuperer automatiquement la date
            mysql_execute(conn, "INSERT INTO posts (titre, description, date_publication) VALUES ('$(requestData["titre"])', '$(requestData["description"])', '$(requestData["date_publication"])')")
            result = mysql_execute(conn, "SELECT * FROM posts WHERE id=$(mysql_insert_id(conn))", opformat=MYSQL_TUPLES)
            responseData = Post(result[1][1], result[1][2], result[1][3])
        end
    end
    if ismatch(r"^/posts/[0-9]{1,}$", req.resource)
        id = split(req.resource, '/')[3]
        if req.method == "GET"
            result = mysql_execute(conn, "SELECT * FROM posts WHERE id=$id", opformat=MYSQL_TUPLES)
            if length(result) == 1
                responseData = Post(result[1][1], result[1][2], result[1][3])
            else
                responseData = "Post non trouvé"
                responseStatus = 404
            end
        end
        if req.method == "PUT"
            rowsAffected = mysql_execute(conn, "UPDATE posts SET titre='$(requestData["titre"])', description='$(requestData["description"])', date_publication='$(requestData["date_publication"])' WHERE id=$id")
            if rowsAffected == 1
                result = mysql_execute(conn, "SELECT * FROM posts WHERE id=$id", opformat=MYSQL_TUPLES)
                responseData = Post(result[1][1], result[1][2], result[1][3])
            else
                responseData = "Post non trouvé"
                responseStatus = 404
            end
        end
        if req.method == "DELETE"
            rowsAffected = mysql_execute(conn, "DELETE FROM posts WHERE id=$id")
            if rowsAffected == 1
                posts = Post[]
                for row in MySQLRowIterator(conn, "SELECT * FROM posts")
                    push!(posts, Post(row[1], row[2], row[3]))
                end
                responseData = posts
            else
                responseData = "Post non trouvé"
                responseStatus = 404
            end
        end
    end
    try
        responseData
    catch
        responseData = "Non trouvé"
        responseStatus = 404
    end
    Response(responseStatus, responseHeaders, JSON.json(responseData))
end

run(Server(handler), 8000)
