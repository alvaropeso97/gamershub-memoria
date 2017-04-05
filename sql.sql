create table analisis
(
	id int not null auto_increment
		primary key,
	articulo int null,
	juego int null,
	jugabilidad int null,
	graficos int null,
	sonidos int null,
	innovacion int null
)
;

create index articulo
	on analisis (articulo)
;

create table articulos
(
	id int not null auto_increment
		primary key,
	titulo varchar(200) not null,
	descripcion varchar(200) not null,
	cont text not null,
	img varchar(500) null,
	tipo varchar(30) not null,
	fecha datetime null,
	juego_rel int not null,
	id_autor int(10) null,
	lnombre varchar(300) null
)
;

create index id_autor
	on articulos (id_autor)
;

create index juego_rel
	on articulos (juego_rel)
;

alter table analisis
	add constraint analisis_ibfk_1
		foreign key (articulo) references articulos (id)
			on update cascade on delete cascade
;

create table categorias
(
	id int not null auto_increment
		primary key,
	nombre varchar(30) null,
	alias varchar(50) null,
	esplataforma int default '0' null,
	color varchar(30) null,
	img_header varchar(200) null
)
;

create table categorias_articulos
(
	id_cat int null,
	cod_art int null,
	constraint categorias_articulos_ibfk_1
		foreign key (id_cat) references categorias (id)
			on update cascade on delete cascade,
	constraint categorias_articulos_ibfk_2
		foreign key (cod_art) references articulos (id)
			on update cascade on delete cascade
)
;

create index cod_art
	on categorias_articulos (cod_art)
;

create index id_cat
	on categorias_articulos (id_cat)
;

create table comentarios
(
	id int not null auto_increment
		primary key,
	id_articulo int null,
	id_usuario int(10) null,
	comentario varchar(1300) null,
	created_at datetime null,
	updated_at datetime null,
	constraint comentarios_ibfk_1
		foreign key (id_articulo) references articulos (id)
			on update cascade on delete cascade
)
;

create index id_articulo
	on comentarios (id_articulo)
;

create index id_usuario
	on comentarios (id_usuario)
;

create table configuracion_general
(
	id int not null auto_increment
		primary key,
	titulo_inicio varchar(255) null,
	imagen_fondo varchar(255) null,
	noticias_dest tinyint(1) null,
	num_articulos_inicio int null,
	copyright varchar(255) null,
	nombre_aplicacion varchar(255) null
)
;

create table confirmacion_email
(
	user_id int not null,
	token varchar(255) not null
)
;

create index user_id
	on confirmacion_email (user_id)
;

create table desarrolladores
(
	id int not null auto_increment
		primary key,
	nombre varchar(350) null
)
;

create table distribuidores
(
	id int not null auto_increment
		primary key,
	nombre varchar(350) null
)
;

create table etiquetas
(
	cod_art int not null,
	nombre varchar(30) not null,
	constraint etiquetas_ibfk_1
		foreign key (cod_art) references articulos (id)
			on update cascade on delete cascade
)
;

create index cod_art
	on etiquetas (cod_art)
;

create table foros
(
	id int not null auto_increment
		primary key,
	titulo varchar(255) not null,
	plataforma_id int null,
	juego_id int null,
	color varchar(7) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	estado int default '0' not null,
	constraint foros_id_uindex
		unique (id),
	constraint foros_categorias_id_fk
		foreign key (plataforma_id) references categorias (id)
			on update cascade on delete cascade
)
;

create index foros_categorias_id_fk
	on foros (plataforma_id)
;

create index foros_juegos_id_fk
	on foros (juego_id)
;

create table foros_respuestas
(
	id int not null auto_increment
		primary key,
	user_id int not null,
	foro_tema_id int not null,
	titulo varchar(255) not null,
	contenido text not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	estado int default '0' not null,
	constraint foros_respuestas_id_uindex
		unique (id)
)
;

create index foros_respuestas_foros_temas_id_fk
	on foros_respuestas (foro_tema_id)
;

create index foros_respuestas_users_id_fk
	on foros_respuestas (user_id)
;

create table foros_temas
(
	id int not null auto_increment
		primary key,
	foro_id int not null,
	user_id int not null,
	titulo varchar(255) not null,
	contenido text not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	estado int default '0' not null,
	constraint foros_temas_id_uindex
		unique (id),
	constraint foros_temas_foros_id_fk
		foreign key (foro_id) references foros (id)
			on update cascade on delete cascade
)
;

create index foros_temas_foros_id_fk
	on foros_temas (foro_id)
;

create index foros_temas_users_id_fk
	on foros_temas (user_id)
;

alter table foros_respuestas
	add constraint foros_respuestas_foros_temas_id_fk
		foreign key (foro_tema_id) references foros_temas (id)
			on update cascade on delete cascade
;

create table generos
(
	id int not null auto_increment
		primary key,
	nombre varchar(50) not null
)
;

create table grupos
(
	id int not null auto_increment
		primary key,
	nombre varchar(255) not null,
	descripcion varchar(255) null,
	privacidad int default '0' not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	juego_id int null,
	info text null,
	constraint grupos_id_uindex
		unique (id)
)
;

create index grupos_juegos_id_fk
	on grupos (juego_id)
;

create table grupos_anuncios
(
	id int not null auto_increment
		primary key,
	user_id int not null,
	grupo_id int not null,
	titulo varchar(255) not null,
	contenido varchar(255) not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	respuesta int default '0' not null,
	constraint grupos_anuncios_id_uindex
		unique (id),
	constraint grupos_anuncios_grupos_id_fk
		foreign key (grupo_id) references grupos (id)
			on update cascade on delete cascade
)
;

create index grupos_anuncios_grupos_id_fk
	on grupos_anuncios (grupo_id)
;

create index grupos_anuncios_users_id_fk
	on grupos_anuncios (user_id)
;

create table grupos_usuarios
(
	user_id int not null,
	grupos_id int not null,
	acceso int default '0' not null,
	fecha_entrada datetime not null,
	constraint grupos_usuarios_grupos_id_fk
		foreign key (grupos_id) references grupos (id)
)
;

create index grupos_usuarios_grupos_id_fk
	on grupos_usuarios (grupos_id)
;

create index grupos_usuarios_users_id_fk
	on grupos_usuarios (user_id)
;

create table imagenes
(
	id int not null auto_increment
		primary key,
	nombre varchar(255) not null,
	ancho mediumtext not null,
	alto mediumtext not null,
	juego_id int null,
	fecha_subida datetime not null,
	carpeta varchar(50) not null,
	constraint imagenes_id_uindex
		unique (id)
)
;

create index juego_id
	on imagenes (juego_id)
;

create table juegos
(
	id int not null auto_increment
		primary key,
	titulo varchar(50) null,
	descripcion varchar(10000) null,
	dispo_en varchar(200) null,
	desarrollador int null,
	distribuidor int null,
	jugadores varchar(200) null,
	duracion varchar(200) null,
	idioma varchar(200) null,
	fecha_lanzamiento date null,
	img_header varchar(200) null,
	img_box varchar(200) null,
	lnombre varchar(100) null,
	constraint juegos_ibfk_1
		foreign key (desarrollador) references desarrolladores (id)
			on update set null on delete set null,
	constraint juegos_ibfk_2
		foreign key (distribuidor) references distribuidores (id)
			on update set null on delete set null
)
;

create index desarrollador
	on juegos (desarrollador)
;

create index distribuidor
	on juegos (distribuidor)
;

alter table articulos
	add constraint articulos_ibfk_1
		foreign key (juego_rel) references juegos (id)
;

alter table foros
	add constraint foros_juegos_id_fk
		foreign key (juego_id) references juegos (id)
			on update cascade on delete cascade
;

alter table grupos
	add constraint grupos_juegos_id_fk
		foreign key (juego_id) references juegos (id)
			on update set null on delete set null
;

alter table imagenes
	add constraint imagenes_ibfk_1
		foreign key (juego_id) references juegos (id)
			on update cascade on delete cascade
;

create table juegos_categorias
(
	id_juego int null,
	id_categoria int null,
	constraint juegos_categorias_ibfk_1
		foreign key (id_juego) references juegos (id)
			on update cascade on delete cascade,
	constraint juegos_categorias_ibfk_2
		foreign key (id_categoria) references categorias (id)
			on update cascade on delete cascade
)
;

create index id_categoria
	on juegos_categorias (id_categoria)
;

create index id_juego
	on juegos_categorias (id_juego)
;

create table juegos_desarrolladores
(
	id_juego int null,
	id_desarrollador int null,
	constraint juegos_desarrolladores_ibfk_1
		foreign key (id_juego) references juegos (id)
			on update cascade on delete cascade,
	constraint juegos_desarrolladores_ibfk_2
		foreign key (id_desarrollador) references desarrolladores (id)
			on update cascade on delete cascade
)
;

create index id_desarrollador
	on juegos_desarrolladores (id_desarrollador)
;

create index id_juego
	on juegos_desarrolladores (id_juego)
;

create table juegos_generos
(
	id_juego int null,
	id_genero int null,
	constraint juegos_generos_ibfk_1
		foreign key (id_juego) references juegos (id)
			on update cascade on delete cascade,
	constraint juegos_generos_ibfk_2
		foreign key (id_genero) references generos (id)
			on update cascade on delete cascade
)
;

create index id_genero
	on juegos_generos (id_genero)
;

create index id_juego
	on juegos_generos (id_juego)
;

create table paises
(
	cod_pais varchar(2) not null
		primary key,
	pais varchar(150) not null
)
;

create table permisos
(
	id int not null auto_increment
		primary key,
	nombre varchar(255) not null,
	descripcion varchar(255) null,
	constraint permisos_id_uindex
		unique (id)
)
;

create table privacidad_usuarios
(
	id_usuario int not null,
	mostrar_perfil int default '0' not null,
	mostrar_ciudad int default '0' not null,
	mostrar_edad int default '0' not null,
	mostrar_sexo int default '0' not null,
	mostrar_cuentas_jue int default '0' not null,
	mostrar_cuentas_con int default '0' not null
)
;

create index id_usuario
	on privacidad_usuarios (id_usuario)
;

create table roles
(
	id int not null auto_increment
		primary key,
	nombre varchar(255) not null,
	descripcion varchar(255) null,
	constraint roles_id_uindex
		unique (id)
)
;

create table roles_permisos
(
	rol_id int not null,
	permiso_id int not null,
	constraint roles_permisos_ibfk_1
		foreign key (rol_id) references roles (id)
			on update cascade on delete cascade,
	constraint roles_permisos_ibfk_2
		foreign key (permiso_id) references permisos (id)
			on update cascade on delete cascade
)
;

create index permiso_id
	on roles_permisos (permiso_id)
;

create index rol_id
	on roles_permisos (rol_id)
;

create table users
(
	id int(10) not null auto_increment
		primary key,
	name varchar(255) not null,
	email varchar(255) not null,
	password varchar(255) not null,
	remember_token varchar(100) null,
	nombre varchar(30) not null,
	apellidos varchar(30) not null,
	fecha_nacimiento date not null,
	pais varchar(2) not null,
	ciudad varchar(30) null,
	sexo varchar(1) null,
	img_perfil varchar(200) default 'http://img.gamershub.es/base/usuario-default.png' null,
	genero_preferido int null,
	firma_personal varchar(500) null,
	xbox_gamertag varchar(100) null,
	ps_id varchar(50) null,
	nintendo_network varchar(50) null,
	codigo_amigo_wii varchar(50) null,
	codigo_amigo_3ds varchar(50) null,
	codigo_amigo_ds varchar(50) null,
	microsoft_gamertag varchar(100) null,
	steam_id varchar(100) null,
	twitter varchar(50) null,
	facebook varchar(200) null,
	google varchar(200) null,
	web_blog varchar(250) null,
	updated_at timestamp null,
	created_at timestamp null,
	rol_id int default '0' not null,
	constraint name
		unique (name),
	constraint email
		unique (email),
	constraint users_roles_id_fk
		foreign key (rol_id) references roles (id),
	constraint users_ibfk_1
		foreign key (pais) references paises (cod_pais)
)
;

create index pais
	on users (pais)
;

create index users_roles_id_fk
	on users (rol_id)
;

alter table articulos
	add constraint articulos_ibfk_2
		foreign key (id_autor) references users (id)
;

alter table comentarios
	add constraint comentarios_ibfk_2
		foreign key (id_usuario) references users (id)
			on update cascade on delete cascade
;

alter table confirmacion_email
	add constraint confirmacion_email_ibfk_1
		foreign key (user_id) references users (id)
			on update cascade on delete cascade
;

alter table foros_respuestas
	add constraint foros_respuestas_users_id_fk
		foreign key (user_id) references users (id)
			on update cascade on delete cascade
;

alter table foros_temas
	add constraint foros_temas_users_id_fk
		foreign key (user_id) references users (id)
			on update cascade on delete cascade
;

alter table grupos_anuncios
	add constraint grupos_anuncios_users_id_fk
		foreign key (user_id) references users (id)
			on update cascade on delete cascade
;

alter table grupos_usuarios
	add constraint grupos_usuarios_users_id_fk
		foreign key (user_id) references users (id)
;

alter table privacidad_usuarios
	add constraint privacidad_usuarios_ibfk_1
		foreign key (id_usuario) references users (id)
			on update cascade on delete cascade
;

create table usuarios_amigos
(
	id int not null auto_increment
		primary key,
	user_re_id int not null,
	estado_em int not null,
	estado_re int not null,
	user_em_id int not null,
	constraint usuarios_amigos_id_uindex
		unique (id),
	constraint usuarios_amigos_users_id_fk_2
		foreign key (user_re_id) references users (id)
			on update cascade on delete cascade,
	constraint usuarios_amigos_users_id_fk
		foreign key (user_em_id) references users (id)
			on update cascade on delete cascade
)
;

create index usuarios_amigos_users_id_fk
	on usuarios_amigos (user_em_id)
;

create index usuarios_amigos_users_id_fk_2
	on usuarios_amigos (user_re_id)
;

create table usuarios_mensajes
(
	id int not null auto_increment
		primary key,
	user_em_id int not null,
	user_re_id int not null,
	titulo varchar(255) not null,
	mensaje text not null,
	fecha_envio datetime null,
	estado int default '0' not null,
	constraint usuarios_mensajes_id_uindex
		unique (id),
	constraint usuarios_mensajes_users_id_fk
		foreign key (user_em_id) references users (id)
			on update cascade on delete cascade,
	constraint usuarios_mensajes_users__fk_2
		foreign key (user_re_id) references users (id)
			on update cascade on delete cascade
)
;

create index usuarios_mensajes_users_id_fk
	on usuarios_mensajes (user_em_id)
;

create index usuarios_mensajes_users__fk_2
	on usuarios_mensajes (user_re_id)
;

create table usuarios_plataformas
(
	id_usuario int not null,
	id_plataforma int not null,
	constraint usuarios_plataformas_ibfk_1
		foreign key (id_usuario) references users (id)
			on update cascade on delete cascade,
	constraint usuarios_plataformas_ibfk_2
		foreign key (id_plataforma) references categorias (id)
			on update cascade on delete cascade
)
;

create index id_plataforma
	on usuarios_plataformas (id_plataforma)
;

create index id_usuario
	on usuarios_plataformas (id_usuario)
;

create table usuarios_tablon_mensajes
(
	id int not null auto_increment
		primary key,
	user_id int not null,
	titulo varchar(255) not null,
	mensaje text not null,
	fecha_creacion datetime not null,
	fecha_modificacion datetime not null,
	constraint usuarios_tablon_mensajes_id_uindex
		unique (id),
	constraint usuarios_tablon_mensajes_users_id_fk
		foreign key (user_id) references users (id)
			on update cascade on delete cascade
)
;

create index usuarios_tablon_mensajes_users_id_fk
	on usuarios_tablon_mensajes (user_id)
;

create table videos
(
	id int not null auto_increment
		primary key,
	id_art int not null,
	cod_yt varchar(30) not null,
	dur varchar(30) not null,
	visitas int default '0' not null,
	constraint videos_ibfk_1
		foreign key (id_art) references articulos (id)
			on update cascade on delete cascade
)
;

create index id_art
	on videos (id_art)
;


