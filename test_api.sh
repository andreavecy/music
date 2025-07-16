#!/bin/bash

# Script de pruebas para la API de Music
# Uso: ./test_api.sh [BASE_URL]
# Ejemplo: ./test_api.sh https://music.fly.dev

BASE_URL=${1:-"https://music.fly.dev"}

echo "🎵 Testing Music API at: $BASE_URL"
echo "========================================"

# Función para hacer peticiones con manejo de errores
make_request() {
    local method=$1
    local endpoint=$2
    local data=$3
    local description=$4
    
    echo ""
    echo "📡 Testing: $description"
    echo "Endpoint: $method $endpoint"
    
    if [ -z "$data" ]; then
        response=$(curl -s -w "\n%{http_code}" -X "$method" "$BASE_URL$endpoint" \
                   -H "Content-Type: application/json" \
                   --connect-timeout 10 \
                   --max-time 30)
    else
        echo "Data: $data"
        response=$(curl -s -w "\n%{http_code}" -X "$method" "$BASE_URL$endpoint" \
                   -H "Content-Type: application/json" \
                   -d "$data" \
                   --connect-timeout 10 \
                   --max-time 30)
    fi
    
    # Separar respuesta y código HTTP
    body=$(echo "$response" | head -n -1)
    status_code=$(echo "$response" | tail -n 1)
    
    echo "Status: $status_code"
    if [ "$status_code" -eq 200 ] || [ "$status_code" -eq 201 ]; then
        echo "✅ SUCCESS"
        echo "Response: $(echo "$body" | head -c 200)..."
    else
        echo "❌ FAILED"
        echo "Response: $body"
    fi
    echo "----------------------------------------"
}

# Test 1: Obtener artistas
make_request "GET" "/artists" "" "Get all artists"

# Test 2: Obtener álbumes
make_request "GET" "/albums" "" "Get all albums"

# Test 3: Obtener canciones
make_request "GET" "/tracks" "" "Get all tracks"

# Test 4: Buscar canciones
make_request "POST" "/search_track" '{"q": "love"}' "Search tracks with 'love'"

# Test 5: Obtener usuarios
make_request "GET" "/list_users" "" "Get users list"

# Test 6: Buscar usuarios
make_request "POST" "/find_user" '{"q": "admin"}' "Search users with 'admin'"

# Test 7: Obtener posts
make_request "GET" "/posts" "" "Get all posts"

# Test 8: Obtener canciones favoritas
make_request "GET" "/favorite_tracks" "" "Get favorite tracks"

# Test 9: Obtener álbumes de un artista específico
make_request "GET" "/albums/artist/1" "" "Get albums from artist ID 1"

# Test 10: Obtener canciones de un artista específico
make_request "GET" "/tracks/artist/1" "" "Get tracks from artist ID 1"

echo ""
echo "🎵 API Testing completed!"
echo "========================================"

# Test de creación (comentado porque necesita autenticación)
echo ""
echo "📝 Additional tests (require authentication):"
echo "- POST /signup - Create new user"
echo "- POST /login - User login"
echo "- POST /artists - Create artist"
echo "- POST /albums - Create album"
echo "- POST /tracks - Create track"
echo "- POST /posts - Create post"
echo ""
echo "💡 Use the full documentation in API_DOCUMENTATION.md for complete examples"
