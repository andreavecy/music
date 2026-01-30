# Music API Documentation

API REST para una aplicación de música construida con Ruby on Rails 8.0.2

## Base URL
```
https://music.fly.dev
```

## Autenticación
La API utiliza JWT (JSON Web Tokens) para autenticación mediante Devise.

## Endpoints

### 🎤 Artists (Artistas)

#### GET /artists
Obtiene la lista de todos los artistas.

**Respuesta:**
```json
[
  {
    "id": 1,
    "followers": 670,
    "genres": ["pop", "electronica"],
    "image": "https://example.com/image.jpg",
    "name": "Dua Lipa",
    "popularity": 90,
    "created_at": "2024-07-24T15:47:22.324Z",
    "updated_at": "2024-07-24T15:47:22.324Z"
  }
]
```

#### GET /artists/:id
Obtiene un artista específico por ID.

**Parámetros:**
- `id` (required): ID del artista

#### POST /artists
Crea un nuevo artista.

**Body (JSON):**
```json
{
  "artist": {
    "name": "Nombre del artista",
    "followers": 1000,
    "genres": ["pop", "rock"],
    "image": "URL de la imagen",
    "popularity": 85
  }
}
```

#### PUT/PATCH /artists/:id
Actualiza un artista existente.

**Parámetros:**
- `id` (required): ID del artista

**Body (JSON):** Mismo formato que POST

#### DELETE /artists/:id
Elimina un artista.

**Parámetros:**
- `id` (required): ID del artista

---

### 💿 Albums (Álbumes)

#### GET /albums
Obtiene la lista de todos los álbumes.

**Respuesta:**
```json
[
  {
    "id": 1,
    "image": "https://example.com/album.jpg",
    "name": "Radical Optimism",
    "popularity": 69,
    "release_date": "2024-03-05",
    "total_tracks": 10,
    "genres": ["pop"],
    "label": "Radical Optimism",
    "created_at": "2024-07-24T23:38:42.676Z",
    "updated_at": "2024-07-24T23:38:42.676Z",
    "artist_id": 1
  }
]
```

#### GET /albums/:id
Obtiene un álbum específico.

#### POST /albums
Crea un nuevo álbum.

#### PUT/PATCH /albums/:id
Actualiza un álbum.

#### DELETE /albums/:id
Elimina un álbum.

#### GET /albums/artist/:artist_id
Obtiene todos los álbumes de un artista específico.

**Parámetros:**
- `artist_id` (required): ID del artista

---

### 🎵 Tracks (Canciones)

#### GET /tracks
Obtiene la lista de todas las canciones.

#### GET /tracks/:id
Obtiene una canción específica.

#### POST /tracks
Crea una nueva canción.

**Body (JSON):**
```json
{
  "track": {
    "name": "Nombre de la canción",
    "album_id": 1,
    "artist_id": 1,
    "disc_number": 1,
    "duration_ms": 180000,
    "preview_url": "https://example.com/preview.mp3",
    "track_number": 1
  }
}
```

#### PUT/PATCH /tracks/:id
Actualiza una canción.

#### DELETE /tracks/:id
Elimina una canción.

#### GET /tracks/artist/:artist_id
Obtiene todas las canciones de un artista específico.

#### GET /tracks/album/:album_id
Obtiene todas las canciones de un álbum específico.

#### POST /search_track
Busca canciones por nombre.

**Body (JSON):**
```json
{
  "q": "nombre a buscar"
}
```

---

### 👤 Users & Authentication (Usuarios y Autenticación)

#### POST /signup
Registra un nuevo usuario.

**Body (JSON):**
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "name": "Nombre Usuario",
    "username": "username"
  }
}
```

#### POST /login
Inicia sesión de usuario.

**Body (JSON):**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Respuesta:**
```json
{
  "msg": "Usuario Logeado",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "Nombre Usuario"
  },
  "status": "OK"
}
```

#### DELETE /logout
Cierra sesión del usuario.

#### GET /current_user/:id
Obtiene información del usuario actual incluyendo seguidores y seguidos.

#### GET /list_users
Obtiene lista paginada de usuarios.

**Query Parameters:**
- `page` (optional): Número de página
- `per_page` (optional): Elementos por página (default: 10)
- `query` (optional): Filtro de búsqueda por nombre

#### POST /find_user
Busca usuarios por nombre.

**Body (JSON):**
```json
{
  "q": "nombre a buscar"
}
```

---

### 👥 Follows (Seguimientos)

#### GET /follows
Obtiene la lista de seguimientos.

#### POST /follows
Crea un seguimiento.

#### GET /follows/:id
Obtiene un seguimiento específico.

#### PUT/PATCH /follows/:id
Actualiza un seguimiento.

#### DELETE /follows/:id
Elimina un seguimiento.

#### POST /follow/:id
Sigue a un usuario.

**Parámetros:**
- `id` (required): ID del usuario a seguir

#### POST /unfollow/:id
Deja de seguir a un usuario.

**Parámetros:**
- `id` (required): ID del usuario a dejar de seguir

---

### ❤️ Favorite Tracks (Canciones Favoritas)

#### GET /favorite_tracks
Obtiene la lista de canciones favoritas.

#### POST /favorite_tracks
Marca una canción como favorita.

#### GET /favorite_tracks/:id
Obtiene un favorito específico.

#### PUT/PATCH /favorite_tracks/:id
Actualiza un favorito.

#### DELETE /favorite_tracks/:id
Elimina una canción de favoritos usando el ID del favorito.

**Parámetros:**
- `id` (required): ID del registro de favorito

#### DELETE /remove_favorite
Elimina una canción de favoritos usando el user_id y track_id.

**Body (JSON):**
```json
{
  "user_id": 1,
  "track_id": 5
}
```

**Respuesta exitosa:**
```json
{
  "message": "Favorito eliminado exitosamente"
}
```

**Respuesta error (404):**
```json
{
  "error": "Favorito no encontrado"
}
```

#### GET /user_favorites/:user_id
Obtiene las canciones favoritas de un usuario específico.

#### GET /track_user_favorites/:track_id
Obtiene los usuarios que han marcado una canción como favorita.

---

### 📝 Posts (Publicaciones)

#### GET /posts
Obtiene la lista paginada de publicaciones.

**Query Parameters:**
- `page` (optional): Número de página
- `per_page` (optional): Elementos por página (default: 10)

**Respuesta:**
```json
{
  "posts": [
    {
      "id": 1,
      "content": "Contenido del post",
      "user": {
        "id": 1,
        "name": "Usuario",
        "image": "avatar.jpg"
      },
      "comments": []
    }
  ],
  "meta": {
    "total_pages": 5,
    "current_page": 1,
    "total_count": 50
  }
}
```

#### GET /posts/:id
Obtiene una publicación específica con comentarios.

#### POST /posts
Crea una nueva publicación.

**Body (JSON):**
```json
{
  "post": {
    "content": "Contenido de la publicación",
    "user_id": 1
  }
}
```

#### PUT/PATCH /posts/:id
Actualiza una publicación.

#### DELETE /posts/:id
Elimina una publicación.

#### POST /posts/:id/like
Da "like" a una publicación.

---

### 💬 Comments (Comentarios)

#### GET /posts/:post_id/comments
Obtiene los comentarios de una publicación.

#### POST /posts/:post_id/comments
Crea un comentario en una publicación.

**Body (JSON):**
```json
{
  "comment": {
    "content": "Contenido del comentario",
    "user_id": 1
  }
}
```

#### DELETE /posts/:post_id/comments/:id
Elimina un comentario.

---

## Códigos de Estado HTTP

- `200 OK` - Solicitud exitosa
- `201 Created` - Recurso creado exitosamente
- `204 No Content` - Solicitud exitosa sin contenido de respuesta
- `401 Unauthorized` - No autorizado
- `404 Not Found` - Recurso no encontrado
- `422 Unprocessable Entity` - Error de validación
- `500 Internal Server Error` - Error del servidor

## Ejemplos de Uso con cURL

### Obtener todos los artistas
```bash
curl -X GET "https://music.fly.dev/artists" \
  -H "Content-Type: application/json"
```

### Crear un artista
```bash
curl -X POST "https://music.fly.dev/artists" \
  -H "Content-Type: application/json" \
  -d '{
    "artist": {
      "name": "Nuevo Artista",
      "followers": 1000,
      "genres": ["pop", "rock"],
      "popularity": 85
    }
  }'
```

### Buscar canciones
```bash
curl -X POST "https://music.fly.dev/search_track" \
  -H "Content-Type: application/json" \
  -d '{"q": "love"}'
```

### Iniciar sesión
```bash
curl -X POST "https://music.fly.dev/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

## Notas Adicionales

- La API utiliza paginación en algunos endpoints (posts, users)
- Las búsquedas son case-insensitive
- Los géneros musicales se almacenan como arrays en PostgreSQL
- Las imágenes se almacenan como URLs externas
- La autenticación JWT es requerida para operaciones de usuario
