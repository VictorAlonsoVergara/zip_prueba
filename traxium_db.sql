-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public."MAE_OBJETOS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_OBJETOS" CASCADE;
TRUNCATE TABLE public."MAE_OBJETOS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_OBJETOS"(
	obj_id serial NOT NULL,
	obj_desc varchar(200),
	tobj_id integer NOT NULL,
	obj_estado char(1),
	obj_ldesc text,
	obj_latitud numeric(11,8),
	obj_longitud numeric(11,8),
	obj_ip_address character varying(16),
	marca_id smallint,
	prot_id integer,
	obj_firmware varchar(100),
	obj_hardware varchar(100),
	fch_creacion timestamp,
	fch_actualizacion timestamp,
	fch_inscripcion timestamp,
	obj_usuario varchar(50),
	obj_password varchar(50),
	mod_id integer,
	obj_respuesta varchar(500),
	obj_respuesta_flag boolean,
	CONSTRAINT "MAE_OBJETOS_pk" PRIMARY KEY (obj_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_OBJETOS" IS 'La tabla guarda todos los objetos registrados de la red';
-- ddl-end --
COMMENT ON COLUMN public."MAE_OBJETOS".obj_estado IS 'A - activo
D - desactivado
R - retirado de la red
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."MAE_OBJETOS".obj_ldesc IS 'Descripción larga del objeto';
-- ddl-end --
ALTER TABLE public."MAE_OBJETOS" OWNER TO postgres;
-- ddl-end --

-- object: public."ARB_LOGICO" | type: TABLE --
DROP TABLE IF EXISTS public."ARB_LOGICO" CASCADE;
TRUNCATE TABLE public."ARB_LOGICO" RESTART IDENTITY CASCADE;
CREATE TABLE public."ARB_LOGICO"(
	log_id integer NOT NULL,
	log_id_padre integer,
	log_desc varchar(200),
	log_orden varchar(30),
	CONSTRAINT "PK_ARB_LOGICO" PRIMARY KEY (log_id)

);
-- ddl-end --
COMMENT ON TABLE public."ARB_LOGICO" IS 'La tabla guarda los nodos del árbol lógico de la red indicando cuál es el padre y el nombre de cada nodo';
-- ddl-end --
COMMENT ON COLUMN public."ARB_LOGICO".log_desc IS 'Nombre del objeto logico';
-- ddl-end --
ALTER TABLE public."ARB_LOGICO" OWNER TO postgres;
-- ddl-end --

-- object: public."ARB_FISICO" | type: TABLE --
DROP TABLE IF EXISTS public."ARB_FISICO" CASCADE;
TRUNCATE TABLE public."ARB_FISICO" RESTART IDENTITY CASCADE;
CREATE TABLE public."ARB_FISICO"(
	fis_id integer NOT NULL,
	fis_id_padre integer,
	fis_desc varchar(200),
	fis_orden varchar(30),
	CONSTRAINT "PK_ARB_FISICO" PRIMARY KEY (fis_id)

);
-- ddl-end --
COMMENT ON TABLE public."ARB_FISICO" IS 'La tabla guarda los nodos del árbol físico de la red indicando quién es el padre y el nombre del nodo';
-- ddl-end --
COMMENT ON COLUMN public."ARB_FISICO".fis_desc IS 'Nombre de la ubicación física';
-- ddl-end --
ALTER TABLE public."ARB_FISICO" OWNER TO postgres;
-- ddl-end --

-- object: public."MAT_TIPO_OBJ" | type: TABLE --
DROP TABLE IF EXISTS public."MAT_TIPO_OBJ" CASCADE;
TRUNCATE TABLE public."MAT_TIPO_OBJ" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAT_TIPO_OBJ"(
	tobj_id serial NOT NULL,
	tobj_desc varchar(200),
	tobj_estado char(1),
	tobj_consulta char(1),
	tobj_ldesc text,
	tobj_padre_id integer,
	tobj_arb_fisico boolean,
	tobj_arb_logico boolean,
	tobj_pasivo boolean,
	tobj_key varchar(10),
	CONSTRAINT "MAT_TIPO_OBJ_pk" PRIMARY KEY (tobj_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAT_TIPO_OBJ" IS 'La tabla guarda todos los tipos posibles de objetos indicando quien es el padre del tipo de objeto de acuerdo con lo que define la red';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_consulta IS 'Si es que requiere que se ejecute consulta de su estatus (olt y ont principalmente)

S - si
N -no';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_ldesc IS 'Descripción larga del tipo de objeto';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_arb_fisico IS 'Flag si responde a un arbol fisico';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_arb_logico IS 'Flag si responde a un arbol logico';
-- ddl-end --
COMMENT ON COLUMN public."MAT_TIPO_OBJ".tobj_pasivo IS 'Flag si el tipo de objeto es pasivo o no';
-- ddl-end --
ALTER TABLE public."MAT_TIPO_OBJ" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_CRON" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_CRON" CASCADE;
TRUNCATE TABLE public."MAE_CRON" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_CRON"(
	cron_id serial NOT NULL,
	cron_tipo char(1),
	cron_periodo varchar(20),
	cron_estado char(1),
	cron_desc varchar(200),
	CONSTRAINT "MAE_CRON_pk" PRIMARY KEY (cron_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_CRON" IS 'La tabla guarda todas las tareas CRON registradas en el sistema';
-- ddl-end --
COMMENT ON COLUMN public."MAE_CRON".cron_tipo IS 'D - cada cuantos dias
H - cada cuantas horas
M - cada cuantos minutos
F - fecha exacta';
-- ddl-end --
COMMENT ON COLUMN public."MAE_CRON".cron_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."MAE_CRON".cron_desc IS 'Nombre del Cron';
-- ddl-end --
ALTER TABLE public."MAE_CRON" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_EJECUCIONES" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_EJECUCIONES" CASCADE;
TRUNCATE TABLE public."TAB_EJECUCIONES" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_EJECUCIONES"(
	eje_id serial NOT NULL,
	eje_fecha char(8),
	cron_id integer,
	eje_fecha_ini timestamp with time zone,
	eje_fecha_fin timestamp with time zone,
	eje_log varchar(50),
	eje_fecha_transferencia timestamp with time zone,
	eje_fecha_parseo timestamp with time zone,
	CONSTRAINT "TAB_EJECUCIONES_pk" PRIMARY KEY (eje_id)

);
-- ddl-end --
COMMENT ON TABLE public."TAB_EJECUCIONES" IS 'la tabla guarda un registro de cada ejecución de las tareas cron';
-- ddl-end --
COMMENT ON COLUMN public."TAB_EJECUCIONES".eje_log IS 'nombre del archivo de log de la ejecución';
-- ddl-end --
ALTER TABLE public."TAB_EJECUCIONES" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_USUARIOS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_USUARIOS" CASCADE;
TRUNCATE TABLE public."MAE_USUARIOS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_USUARIOS"(
	usu_id serial NOT NULL,
	usu_nombre varchar(300),
	tusu_id integer,
	usu_estado char(1),
	usu_correo varchar(100),
	usu_usuario varchar(50),
	usu_password varchar(2048),
	idi_id integer,
	area_id integer,
	usu_usuario_creador integer,
	usu_fecha_creacion timestamp,
	usu_usuario_modificacion varchar(100),
	usu_fecha_modificacion timestamp,
	CONSTRAINT "MAE_USUARIOS_pk" PRIMARY KEY (usu_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_USUARIOS" IS 'La tabla guarda todos los usuarios del sistema y sus datos correspondientes';
-- ddl-end --
COMMENT ON COLUMN public."MAE_USUARIOS".usu_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."MAE_USUARIOS".usu_usuario IS 'esto es el nombre del usuario, el nombre del login
';
-- ddl-end --
ALTER TABLE public."MAE_USUARIOS" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_TIPO_USU" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_TIPO_USU" CASCADE;
TRUNCATE TABLE public."MAE_TIPO_USU" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_TIPO_USU"(
	tusu_id serial NOT NULL,
	tusu_desc varchar(200),
	tusu_estado char(1),
	CONSTRAINT "MAE_TIPO_USU_pk" PRIMARY KEY (tusu_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_TIPO_USU" IS 'La tabla guarda los tipos de usuarios que cree el administrador (el único tipo de usuario fijo es Administrador)';
-- ddl-end --
COMMENT ON COLUMN public."MAE_TIPO_USU".tusu_estado IS 'A - activado
D - desactivado
E - eliminado
';
-- ddl-end --
ALTER TABLE public."MAE_TIPO_USU" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_USU_ACCESOS_REPORTES" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_USU_ACCESOS_REPORTES" CASCADE;
TRUNCATE TABLE public."MAE_USU_ACCESOS_REPORTES" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_USU_ACCESOS_REPORTES"(
	urep_id serial NOT NULL,
	rep_id integer,
	usu_id integer,
	urep_estado bool,
	CONSTRAINT "MAE_USU_ACCESOS_INDICADORES_pk" PRIMARY KEY (urep_id)

);
-- ddl-end --
ALTER TABLE public."MAE_USU_ACCESOS_REPORTES" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_REPORTES" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_REPORTES" CASCADE;
TRUNCATE TABLE public."TAB_REPORTES" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_REPORTES"(
	rep_id serial NOT NULL,
	rep_desc varchar(200),
	rep_estado char(1),
	rep_ldesc varchar(200),
	rep_alerta char(1),
	rep_trap char(1),
	rep_trap_definicion text,
	CONSTRAINT "MAE_INDICADORES_pk" PRIMARY KEY (rep_id)

);
-- ddl-end --
COMMENT ON TABLE public."TAB_REPORTES" IS 'La tabla guarda todos los reportes disponibles para los usuarios';
-- ddl-end --
COMMENT ON COLUMN public."TAB_REPORTES".rep_estado IS 'A - activado
D - desactivado
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."TAB_REPORTES".rep_ldesc IS 'Descripción larga del indicador.';
-- ddl-end --
COMMENT ON COLUMN public."TAB_REPORTES".rep_alerta IS 'Debe desplegar alerta en caso de que el umbral se supere

S - si
N - no';
-- ddl-end --
COMMENT ON COLUMN public."TAB_REPORTES".rep_trap IS 'es un indicador que debe entregar data por un TRAP

S - si
N - no';
-- ddl-end --
COMMENT ON COLUMN public."TAB_REPORTES".rep_trap_definicion IS 'como se va a estructgurar la trama de trap';
-- ddl-end --
ALTER TABLE public."TAB_REPORTES" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_USU_ACCESOS_ARBOLES" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_USU_ACCESOS_ARBOLES" CASCADE;
TRUNCATE TABLE public."MAE_USU_ACCESOS_ARBOLES" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_USU_ACCESOS_ARBOLES"(
	uarb_id serial NOT NULL,
	urep_id integer,
	uarb_tipo char(1),
	arb_id integer,
	uarb_estado bool,
	CONSTRAINT "MAE_USU_ACCESOS_ARBOLES_pk" PRIMARY KEY (uarb_id)

);
-- ddl-end --
COMMENT ON COLUMN public."MAE_USU_ACCESOS_ARBOLES".uarb_tipo IS 'F - Físico
L -Lógico';
-- ddl-end --
COMMENT ON COLUMN public."MAE_USU_ACCESOS_ARBOLES".arb_id IS 'viene del ID del objeto hijo del árbol que corresponda, de este código hacia abajo el usuario tendrá acceso a toda la data.';
-- ddl-end --
ALTER TABLE public."MAE_USU_ACCESOS_ARBOLES" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_CONSULTAS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_CONSULTAS" CASCADE;
TRUNCATE TABLE public."MAE_CONSULTAS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_CONSULTAS"(
	con_id serial NOT NULL,
	con_desc varchar(100),
	con_estado char(1),
	prot_id integer,
	con_trama_pregunta varchar(500),
	marca_id integer,
	mod_id integer,
	con_respuesta varchar(500),
	tobj_id integer,
	cron_id integer,
	CONSTRAINT "MAE_CONSULTAS_pk" PRIMARY KEY (con_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_CONSULTAS" IS 'estas son los tipos de consultas que se pueden realizar a los dispositivos, ya sean por TL1, SNMP ó TR069 de acuerdo a su marca y modelo';
-- ddl-end --
COMMENT ON COLUMN public."MAE_CONSULTAS".con_estado IS 'A - activado
D - desactivado
E - eliminado';
-- ddl-end --
COMMENT ON COLUMN public."MAE_CONSULTAS".con_trama_pregunta IS 'cual es la cadena de consulta

puede variar en el objeto';
-- ddl-end --
ALTER TABLE public."MAE_CONSULTAS" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_USUARIOS_ALERTAS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_USUARIOS_ALERTAS" CASCADE;
TRUNCATE TABLE public."MAE_USUARIOS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_USUARIOS_ALERTAS"(
	rep_id integer NOT NULL,
	usu_id integer NOT NULL,
	CONSTRAINT "MAE_USUARIOS_ALERTAS_pk" PRIMARY KEY (rep_id,usu_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_USUARIOS_ALERTAS" IS 'usuarios que deben ser notificados en caso de emitirse una alerta';
-- ddl-end --
ALTER TABLE public."MAE_USUARIOS_ALERTAS" OWNER TO postgres;
-- ddl-end --

-- object: public."PARAM" | type: TABLE --
DROP TABLE IF EXISTS public."PARAM" CASCADE;
TRUNCATE TABLE public."PARAM" RESTART IDENTITY CASCADE;
CREATE TABLE public."PARAM"(
	obj_id serial NOT NULL,
	param_grupo varchar(30) NOT NULL,
	param_id varchar(30) NOT NULL,
	param_valor varchar(255) NOT NULL,
	param_extra varchar(255),
	CONSTRAINT "PK_PARAM" PRIMARY KEY (obj_id)

);
-- ddl-end --
ALTER TABLE public."PARAM" OWNER TO postgres;
-- ddl-end --

-- object: unique_param_val | type: INDEX --
-- DROP INDEX IF EXISTS public.unique_param_val CASCADE;
CREATE UNIQUE INDEX unique_param_val ON public."PARAM"
	USING btree
	(
	  param_grupo,
	  param_id ASC NULLS LAST
	);
-- ddl-end --

-- object: public."PARAM_GRUPO" | type: TABLE --
DROP TABLE IF EXISTS public."PARAM_GRUPO" CASCADE;
TRUNCATE TABLE public."PARAM_GRUPO" RESTART IDENTITY CASCADE;
CREATE TABLE public."PARAM_GRUPO"(
	grupo_codigo varchar(30) NOT NULL,
	grupo_nombre varchar(100) NOT NULL,
	CONSTRAINT "PK" PRIMARY KEY (grupo_codigo)

);
-- ddl-end --
ALTER TABLE public."PARAM_GRUPO" OWNER TO postgres;
-- ddl-end --

-- object: public."LOG_SESIONES" | type: TABLE --
DROP TABLE IF EXISTS public."LOG_SESIONES" CASCADE;
TRUNCATE TABLE public."LOG_SESIONES" RESTART IDENTITY CASCADE;
CREATE TABLE public."LOG_SESIONES"(
	ses_id serial,
	ses_token varchar(200),
	ses_logeado char(1),
	ses_data json,
	ses_activacion timestamp DEFAULT now(),
	ses_expirado char(1) DEFAULT 'N',
	ses_fexpirado timestamp,
	usu_id integer,
	client_ip character varying(30)
);
-- ddl-end --
COMMENT ON TABLE public."LOG_SESIONES" IS 'La tabla guarda el historial de sesiones de los usuarios
S - si
N - no';
-- ddl-end --
ALTER TABLE public."LOG_SESIONES" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_MENU" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_MENU" CASCADE;
TRUNCATE TABLE public."TAB_MENU" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_MENU"(
	menu_id serial NOT NULL,
	menu_desc varchar(500),
	menu_name varchar(50),
	menu_key varchar(50),
	menu_padre integer,
	menu_ruta varchar(40),
	menu_cssclass varchar(40),
	menu_ord integer,
	CONSTRAINT "TAB_MENU_pk" PRIMARY KEY (menu_id)

);
-- ddl-end --
COMMENT ON TABLE public."TAB_MENU" IS 'esta es una tabla estática de las opciones del menú del sistema';
-- ddl-end --
COMMENT ON COLUMN public."TAB_MENU".menu_desc IS 'descripción de la opción del menu';
-- ddl-end --
COMMENT ON COLUMN public."TAB_MENU".menu_name IS 'Nombre que aparecerá en el menú';
-- ddl-end --
ALTER TABLE public."TAB_MENU" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_USUARIOS_MENU" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_USUARIOS_MENU" CASCADE;
TRUNCATE TABLE public."MAE_USUARIOS_MENU" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_USUARIOS_MENU"(
	umenu_id serial NOT NULL,
	usu_id integer,
	menu_id integer,
	estado_umenu boolean,
	CONSTRAINT "MAE_USUARIO_MENU_pk" PRIMARY KEY (umenu_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_USUARIOS_MENU" IS 'talba que especifica a que opciones del menú se puede ingresar';
-- ddl-end --
ALTER TABLE public."MAE_USUARIOS_MENU" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_OBJETO_FISICO" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_OBJETO_FISICO" CASCADE;
TRUNCATE TABLE public."MAE_OBJETO_FISICO" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_OBJETO_FISICO"(
	obj_id integer NOT NULL,
	fid_id integer NOT NULL,
	CONSTRAINT "MAE_OBJETO_FISICO_pk" PRIMARY KEY (obj_id,fid_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_OBJETO_FISICO" IS 'La tabla guarda a qué nodo del árbol físico pertenece cada objeto (un objeto puede pertencer a más de un nodo)';
-- ddl-end --
ALTER TABLE public."MAE_OBJETO_FISICO" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_OBJETO_LOGICO" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_OBJETO_LOGICO" CASCADE;
TRUNCATE TABLE public."MAE_OBJETO_LOGICO" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_OBJETO_LOGICO"(
	obj_id integer NOT NULL,
	log_id integer NOT NULL,
	CONSTRAINT "MAE_OBJ_LOGICO_pk" PRIMARY KEY (obj_id,log_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_OBJETO_LOGICO" IS 'La tabla guarda a qué nodo en el árbol lógico pertenece cada objeto (un objeto puede estar en más de un nodo)';
-- ddl-end --
ALTER TABLE public."MAE_OBJETO_LOGICO" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_IDIOMAS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_IDIOMAS" CASCADE;
TRUNCATE TABLE public."MAE_IDIOMAS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_IDIOMAS"(
	idi_id serial NOT NULL,
	idi_desc varchar(100),
	idi_estado char(1),
	idi_key varchar(5),
	CONSTRAINT "MAE_IDIOMAS_pk" PRIMARY KEY (idi_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_IDIOMAS" IS 'La tabla guarda todos los idiomas que un usuario puede decidir usar para manejar el sistema';
-- ddl-end --
COMMENT ON COLUMN public."MAE_IDIOMAS".idi_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
ALTER TABLE public."MAE_IDIOMAS" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_AREA" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_AREA" CASCADE;
TRUNCATE TABLE public."MAE_AREA" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_AREA"(
	area_id serial NOT NULL,
	area_desc varchar(100),
	area_ldesc varchar(200),
	area_estado char(1),
	CONSTRAINT "MAE_AREA_pk" PRIMARY KEY (area_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_AREA" IS 'La tabla guarda todas las areas de la organización';
-- ddl-end --
COMMENT ON COLUMN public."MAE_AREA".area_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
ALTER TABLE public."MAE_AREA" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_PROTOCOLO" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_PROTOCOLO" CASCADE;
TRUNCATE TABLE public."TAB_PROTOCOLO" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_PROTOCOLO"(
	prot_id serial NOT NULL,
	prot_desc varchar(10),
	prot_abreviacion char(1),
	CONSTRAINT "TAB_PROTOCOLO_pk" PRIMARY KEY (prot_id)

);
-- ddl-end --
COMMENT ON TABLE public."TAB_PROTOCOLO" IS 'La tabla guarda todos los protocolos que se utilizarán en el sistema para la comunicación con los objetos';
-- ddl-end --
COMMENT ON COLUMN public."TAB_PROTOCOLO".prot_abreviacion IS 'S - snmp
T - tl1
0 - tr069

esto es referencial porque en el objeto puede cambiar';
-- ddl-end --
ALTER TABLE public."TAB_PROTOCOLO" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_MARCAS" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_MARCAS" CASCADE;
TRUNCATE TABLE public."MAE_MARCAS" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_MARCAS"(
	marca_id serial NOT NULL,
	marca_desc varchar(100),
	marca_estado char(1),
	CONSTRAINT "TAB_MARCA_pk" PRIMARY KEY (marca_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_MARCAS" IS 'La tabla guarda las marcas de los objetos de la red';
-- ddl-end --
COMMENT ON COLUMN public."MAE_MARCAS".marca_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
ALTER TABLE public."MAE_MARCAS" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_MODELO" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_MODELO" CASCADE;
TRUNCATE TABLE public."MAE_MODELO" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_MODELO"(
	mod_id serial NOT NULL,
	mod_descripcion varchar(100),
	marca_id integer,
	tobj_id integer,
	mod_estado char(1),
	CONSTRAINT "MAE_MODELO_pk" PRIMARY KEY (mod_id)

);
-- ddl-end --
COMMENT ON TABLE public."MAE_MODELO" IS 'La tabla guarda los modelos de los objetos de la red';
-- ddl-end --
COMMENT ON COLUMN public."MAE_MODELO".mod_estado IS 'A - activo
D - desactivado
E - eliminado';
-- ddl-end --
ALTER TABLE public."MAE_MODELO" OWNER TO postgres;
-- ddl-end --

-- object: public."LOG_ACCIONES_USUARIO" | type: TABLE --
DROP TABLE IF EXISTS public."LOG_ACCIONES_USUARIO" CASCADE;
TRUNCATE TABLE public."LOG_ACCIONES_USUARIO" RESTART IDENTITY CASCADE;
CREATE TABLE public."LOG_ACCIONES_USUARIO"(
	log_id serial NOT NULL,
	log_usu_id integer,
	log_fecha_hora timestamp DEFAULT now(),
	log_desc varchar(100),
	log_acc_id integer,
	CONSTRAINT "LOG_ACCIONES_USUARIO_PK" PRIMARY KEY (log_id)

);
-- ddl-end --
COMMENT ON TABLE public."LOG_ACCIONES_USUARIO" IS 'La tabla guarda un registro de todas las acciones realizadas por cada usuario';
-- ddl-end --
ALTER TABLE public."LOG_ACCIONES_USUARIO" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_ACCIONES" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_ACCIONES" CASCADE;
TRUNCATE TABLE public."TAB_ACCIONES" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_ACCIONES"(
	acc_id serial NOT NULL,
	acc_desc varchar(50),
	CONSTRAINT "TAB_ACCIONES_PK" PRIMARY KEY (acc_id)

);
-- ddl-end --
COMMENT ON TABLE public."TAB_ACCIONES" IS 'La tabla guarda todas las posibles acciones que puede hacer un usuario en el sistema';
-- ddl-end --
ALTER TABLE public."TAB_ACCIONES" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_EJECUCIONES_OBJETO" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_EJECUCIONES_OBJETO" CASCADE;
TRUNCATE TABLE public."TAB_EJECUCIONES_OBJETO" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_EJECUCIONES_OBJETO"(
	eobj_id serial NOT NULL,
	eobj_cod varchar(100),
	eobj_fch_inicio timestamp with time zone,
	eobj_fch_fin timestamp with time zone,
	eobj_subido bool,
	eje_id integer,
	obj_id integer,
	CONSTRAINT "TAB_EJECUCIONES_OBJETO_pk" PRIMARY KEY (eobj_id)

);
-- ddl-end --
ALTER TABLE public."TAB_EJECUCIONES_OBJETO" OWNER TO postgres;
-- ddl-end --

-- object: public."MAE_SERVERS_PULL" | type: TABLE --
DROP TABLE IF EXISTS public."MAE_SERVERS_PULL" CASCADE;
TRUNCATE TABLE public."MAE_SERVERS_PULL" RESTART IDENTITY CASCADE;
CREATE TABLE public."MAE_SERVERS_PULL"(
	serv_id serial,
	serv_ip varchar(20),
	serv_hostname varchar(50),
	log_id integer
);
-- ddl-end --
COMMENT ON TABLE public."MAE_SERVERS_PULL" IS 'Tabla que detalla los servidores que harán pull a la data de los objetos';
-- ddl-end --
ALTER TABLE public."MAE_SERVERS_PULL" OWNER TO postgres;
-- ddl-end --

-- object: public."TAB_ERROR" | type: TABLE --
DROP TABLE IF EXISTS public."TAB_ERROR" CASCADE;
TRUNCATE TABLE public."TAB_ERROR" RESTART IDENTITY CASCADE;
CREATE TABLE public."TAB_ERROR"(
	cod_error integer NOT NULL,
	idi_id integer NOT NULL,
	mensaje varchar(100),
	CONSTRAINT "TAB_ERROR_pk" PRIMARY KEY (cod_error,idi_id)

);
-- ddl-end --
ALTER TABLE public."TAB_ERROR" OWNER TO postgres;
-- ddl-end --

-- object: "FK_MAE_TIPO_OBJ" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETOS" DROP CONSTRAINT IF EXISTS "FK_MAE_TIPO_OBJ" CASCADE;
ALTER TABLE public."MAE_OBJETOS" ADD CONSTRAINT "FK_MAE_TIPO_OBJ" FOREIGN KEY (tobj_id)
REFERENCES public."MAT_TIPO_OBJ" (tobj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_OBJETOS_TAB_MARCA" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETOS" DROP CONSTRAINT IF EXISTS "FK_MAE_OBJETOS_TAB_MARCA" CASCADE;
ALTER TABLE public."MAE_OBJETOS" ADD CONSTRAINT "FK_MAE_OBJETOS_TAB_MARCA" FOREIGN KEY (marca_id)
REFERENCES public."MAE_MARCAS" (marca_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_OBJETOS_TAB_PROTOCOLO" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETOS" DROP CONSTRAINT IF EXISTS "FK_MAE_OBJETOS_TAB_PROTOCOLO" CASCADE;
ALTER TABLE public."MAE_OBJETOS" ADD CONSTRAINT "FK_MAE_OBJETOS_TAB_PROTOCOLO" FOREIGN KEY (prot_id)
REFERENCES public."TAB_PROTOCOLO" (prot_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_OBJETOS_MAE_MODELO" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETOS" DROP CONSTRAINT IF EXISTS "FK_MAE_OBJETOS_MAE_MODELO" CASCADE;
ALTER TABLE public."MAE_OBJETOS" ADD CONSTRAINT "FK_MAE_OBJETOS_MAE_MODELO" FOREIGN KEY (mod_id)
REFERENCES public."MAE_MODELO" (mod_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_ARB_LOGICO_RECURSIVO" | type: CONSTRAINT --
-- ALTER TABLE public."ARB_LOGICO" DROP CONSTRAINT IF EXISTS "FK_ARB_LOGICO_RECURSIVO" CASCADE;
ALTER TABLE public."ARB_LOGICO" ADD CONSTRAINT "FK_ARB_LOGICO_RECURSIVO" FOREIGN KEY (log_id_padre)
REFERENCES public."ARB_LOGICO" (log_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_ARB_FISICO" | type: CONSTRAINT --
-- ALTER TABLE public."ARB_FISICO" DROP CONSTRAINT IF EXISTS "FK_ARB_FISICO" CASCADE;
ALTER TABLE public."ARB_FISICO" ADD CONSTRAINT "FK_ARB_FISICO" FOREIGN KEY (fis_id_padre)
REFERENCES public."ARB_FISICO" (fis_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAT_TIPO_OBJ" | type: CONSTRAINT --
-- ALTER TABLE public."MAT_TIPO_OBJ" DROP CONSTRAINT IF EXISTS "FK_MAT_TIPO_OBJ" CASCADE;
ALTER TABLE public."MAT_TIPO_OBJ" ADD CONSTRAINT "FK_MAT_TIPO_OBJ" FOREIGN KEY (tobj_padre_id)
REFERENCES public."MAT_TIPO_OBJ" (tobj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_TAB_EJECUCIONES_MAE_CRON" | type: CONSTRAINT --
-- ALTER TABLE public."TAB_EJECUCIONES" DROP CONSTRAINT IF EXISTS "FK_TAB_EJECUCIONES_MAE_CRON" CASCADE;
ALTER TABLE public."TAB_EJECUCIONES" ADD CONSTRAINT "FK_TAB_EJECUCIONES_MAE_CRON" FOREIGN KEY (cron_id)
REFERENCES public."MAE_CRON" (cron_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIOS_MAE_TIPO_USU" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIOS_MAE_TIPO_USU" CASCADE;
ALTER TABLE public."MAE_USUARIOS" ADD CONSTRAINT "FK_MAE_USUARIOS_MAE_TIPO_USU" FOREIGN KEY (tusu_id)
REFERENCES public."MAE_TIPO_USU" (tusu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIOS_MAE_IDIOMAS" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIOS_MAE_IDIOMAS" CASCADE;
ALTER TABLE public."MAE_USUARIOS" ADD CONSTRAINT "FK_MAE_USUARIOS_MAE_IDIOMAS" FOREIGN KEY (idi_id)
REFERENCES public."MAE_IDIOMAS" (idi_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIOS_MAE_AREA" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIOS_MAE_AREA" CASCADE;
ALTER TABLE public."MAE_USUARIOS" ADD CONSTRAINT "FK_MAE_USUARIOS_MAE_AREA" FOREIGN KEY (area_id)
REFERENCES public."MAE_AREA" (area_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_USU_ACCESOS_INDICADORES__MAE_USUARIOS" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USU_ACCESOS_REPORTES" DROP CONSTRAINT IF EXISTS "FK_USU_ACCESOS_INDICADORES__MAE_USUARIOS" CASCADE;
ALTER TABLE public."MAE_USU_ACCESOS_REPORTES" ADD CONSTRAINT "FK_USU_ACCESOS_INDICADORES__MAE_USUARIOS" FOREIGN KEY (usu_id)
REFERENCES public."MAE_USUARIOS" (usu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USU_ACCESOS_INDICADORES__MAE_INDICADORES" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USU_ACCESOS_REPORTES" DROP CONSTRAINT IF EXISTS "FK_MAE_USU_ACCESOS_INDICADORES__MAE_INDICADORES" CASCADE;
ALTER TABLE public."MAE_USU_ACCESOS_REPORTES" ADD CONSTRAINT "FK_MAE_USU_ACCESOS_INDICADORES__MAE_INDICADORES" FOREIGN KEY (rep_id)
REFERENCES public."TAB_REPORTES" (rep_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USU_ACCESOS_ARBOLES_1" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USU_ACCESOS_ARBOLES" DROP CONSTRAINT IF EXISTS "FK_MAE_USU_ACCESOS_ARBOLES_1" CASCADE;
ALTER TABLE public."MAE_USU_ACCESOS_ARBOLES" ADD CONSTRAINT "FK_MAE_USU_ACCESOS_ARBOLES_1" FOREIGN KEY (urep_id)
REFERENCES public."MAE_USU_ACCESOS_REPORTES" (urep_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_CONSULTAS_TAB_PROTOCOLO" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_CONSULTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_CONSULTAS_TAB_PROTOCOLO" CASCADE;
ALTER TABLE public."MAE_CONSULTAS" ADD CONSTRAINT "FK_MAE_CONSULTAS_TAB_PROTOCOLO" FOREIGN KEY (prot_id)
REFERENCES public."TAB_PROTOCOLO" (prot_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_CONSULTAS_TAB_MARCA" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_CONSULTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_CONSULTAS_TAB_MARCA" CASCADE;
ALTER TABLE public."MAE_CONSULTAS" ADD CONSTRAINT "FK_MAE_CONSULTAS_TAB_MARCA" FOREIGN KEY (marca_id)
REFERENCES public."MAE_MARCAS" (marca_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_CONSULTAS_MAE_MODELO" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_CONSULTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_CONSULTAS_MAE_MODELO" CASCADE;
ALTER TABLE public."MAE_CONSULTAS" ADD CONSTRAINT "FK_MAE_CONSULTAS_MAE_MODELO" FOREIGN KEY (mod_id)
REFERENCES public."MAE_MODELO" (mod_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_CONSULTAS_MAT_TIPO_OBJ" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_CONSULTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_CONSULTAS_MAT_TIPO_OBJ" CASCADE;
ALTER TABLE public."MAE_CONSULTAS" ADD CONSTRAINT "FK_MAE_CONSULTAS_MAT_TIPO_OBJ" FOREIGN KEY (tobj_id)
REFERENCES public."MAT_TIPO_OBJ" (tobj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_CONSULTAS_MAE_CRON" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_CONSULTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_CONSULTAS_MAE_CRON" CASCADE;
ALTER TABLE public."MAE_CONSULTAS" ADD CONSTRAINT "FK_MAE_CONSULTAS_MAE_CRON" FOREIGN KEY (cron_id)
REFERENCES public."MAE_CRON" (cron_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIOS_ALERTAS_1" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS_ALERTAS" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIOS_ALERTAS_1" CASCADE;
ALTER TABLE public."MAE_USUARIOS_ALERTAS" ADD CONSTRAINT "FK_MAE_USUARIOS_ALERTAS_1" FOREIGN KEY (rep_id)
REFERENCES public."TAB_REPORTES" (rep_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "MAE_USUARIOS_ALERTAS_2" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS_ALERTAS" DROP CONSTRAINT IF EXISTS "MAE_USUARIOS_ALERTAS_2" CASCADE;
ALTER TABLE public."MAE_USUARIOS_ALERTAS" ADD CONSTRAINT "MAE_USUARIOS_ALERTAS_2" FOREIGN KEY (usu_id)
REFERENCES public."MAE_USUARIOS" (usu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_GRUPO" | type: CONSTRAINT --
-- ALTER TABLE public."PARAM" DROP CONSTRAINT IF EXISTS "FK_GRUPO" CASCADE;
ALTER TABLE public."PARAM" ADD CONSTRAINT "FK_GRUPO" FOREIGN KEY (param_grupo)
REFERENCES public."PARAM_GRUPO" (grupo_codigo) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_LOG_SESIONES_MAE_USUARIOS" | type: CONSTRAINT --
-- ALTER TABLE public."LOG_SESIONES" DROP CONSTRAINT IF EXISTS "FK_LOG_SESIONES_MAE_USUARIOS" CASCADE;
ALTER TABLE public."LOG_SESIONES" ADD CONSTRAINT "FK_LOG_SESIONES_MAE_USUARIOS" FOREIGN KEY (usu_id)
REFERENCES public."MAE_USUARIOS" (usu_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIO_MENU1" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS_MENU" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIO_MENU1" CASCADE;
ALTER TABLE public."MAE_USUARIOS_MENU" ADD CONSTRAINT "FK_MAE_USUARIO_MENU1" FOREIGN KEY (usu_id)
REFERENCES public."MAE_USUARIOS" (usu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_USUARIO_MENU2" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_USUARIOS_MENU" DROP CONSTRAINT IF EXISTS "FK_MAE_USUARIO_MENU2" CASCADE;
ALTER TABLE public."MAE_USUARIOS_MENU" ADD CONSTRAINT "FK_MAE_USUARIO_MENU2" FOREIGN KEY (menu_id)
REFERENCES public."TAB_MENU" (menu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_OBJETO_FISICO1" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETO_FISICO" DROP CONSTRAINT IF EXISTS "FK_MAE_OBJETO_FISICO1" CASCADE;
ALTER TABLE public."MAE_OBJETO_FISICO" ADD CONSTRAINT "FK_MAE_OBJETO_FISICO1" FOREIGN KEY (obj_id)
REFERENCES public."MAE_OBJETOS" (obj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_OBJETO_FISICO2" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETO_FISICO" DROP CONSTRAINT IF EXISTS "FK_MAE_OBJETO_FISICO2" CASCADE;
ALTER TABLE public."MAE_OBJETO_FISICO" ADD CONSTRAINT "FK_MAE_OBJETO_FISICO2" FOREIGN KEY (fid_id)
REFERENCES public."ARB_FISICO" (fis_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "MAE_OBJ_LOGICO1" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETO_LOGICO" DROP CONSTRAINT IF EXISTS "MAE_OBJ_LOGICO1" CASCADE;
ALTER TABLE public."MAE_OBJETO_LOGICO" ADD CONSTRAINT "MAE_OBJ_LOGICO1" FOREIGN KEY (obj_id)
REFERENCES public."MAE_OBJETOS" (obj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "MAE_OBJ_LOGICO2" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_OBJETO_LOGICO" DROP CONSTRAINT IF EXISTS "MAE_OBJ_LOGICO2" CASCADE;
ALTER TABLE public."MAE_OBJETO_LOGICO" ADD CONSTRAINT "MAE_OBJ_LOGICO2" FOREIGN KEY (log_id)
REFERENCES public."ARB_LOGICO" (log_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_MODELO_MAE_MARCAS" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_MODELO" DROP CONSTRAINT IF EXISTS "FK_MAE_MODELO_MAE_MARCAS" CASCADE;
ALTER TABLE public."MAE_MODELO" ADD CONSTRAINT "FK_MAE_MODELO_MAE_MARCAS" FOREIGN KEY (marca_id)
REFERENCES public."MAE_MARCAS" (marca_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MAE_MODELO_MAR_TIPO_OBJ" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_MODELO" DROP CONSTRAINT IF EXISTS "FK_MAE_MODELO_MAR_TIPO_OBJ" CASCADE;
ALTER TABLE public."MAE_MODELO" ADD CONSTRAINT "FK_MAE_MODELO_MAR_TIPO_OBJ" FOREIGN KEY (tobj_id)
REFERENCES public."MAT_TIPO_OBJ" (tobj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_LOG_ACCIONES_USUARIO_TAB_ACCION" | type: CONSTRAINT --
-- ALTER TABLE public."LOG_ACCIONES_USUARIO" DROP CONSTRAINT IF EXISTS "FK_LOG_ACCIONES_USUARIO_TAB_ACCION" CASCADE;
ALTER TABLE public."LOG_ACCIONES_USUARIO" ADD CONSTRAINT "FK_LOG_ACCIONES_USUARIO_TAB_ACCION" FOREIGN KEY (log_acc_id)
REFERENCES public."TAB_ACCIONES" (acc_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_LOG_ACCIONES_USUARIO_MAE_USUARIO" | type: CONSTRAINT --
-- ALTER TABLE public."LOG_ACCIONES_USUARIO" DROP CONSTRAINT IF EXISTS "FK_LOG_ACCIONES_USUARIO_MAE_USUARIO" CASCADE;
ALTER TABLE public."LOG_ACCIONES_USUARIO" ADD CONSTRAINT "FK_LOG_ACCIONES_USUARIO_MAE_USUARIO" FOREIGN KEY (log_usu_id)
REFERENCES public."MAE_USUARIOS" (usu_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_EJECUCIONES_OBJETO_EJECUCIONES" | type: CONSTRAINT --
-- ALTER TABLE public."TAB_EJECUCIONES_OBJETO" DROP CONSTRAINT IF EXISTS "FK_EJECUCIONES_OBJETO_EJECUCIONES" CASCADE;
ALTER TABLE public."TAB_EJECUCIONES_OBJETO" ADD CONSTRAINT "FK_EJECUCIONES_OBJETO_EJECUCIONES" FOREIGN KEY (eje_id)
REFERENCES public."TAB_EJECUCIONES" (eje_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_EJECUCIONES_OBJETO_OBJETO" | type: CONSTRAINT --
-- ALTER TABLE public."TAB_EJECUCIONES_OBJETO" DROP CONSTRAINT IF EXISTS "FK_EJECUCIONES_OBJETO_OBJETO" CASCADE;
ALTER TABLE public."TAB_EJECUCIONES_OBJETO" ADD CONSTRAINT "FK_EJECUCIONES_OBJETO_OBJETO" FOREIGN KEY (obj_id)
REFERENCES public."MAE_OBJETOS" (obj_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FLK_MAE_SERVERS_PULL_ARB_LOGICO" | type: CONSTRAINT --
-- ALTER TABLE public."MAE_SERVERS_PULL" DROP CONSTRAINT IF EXISTS "FLK_MAE_SERVERS_PULL_ARB_LOGICO" CASCADE;
ALTER TABLE public."MAE_SERVERS_PULL" ADD CONSTRAINT "FLK_MAE_SERVERS_PULL_ARB_LOGICO" FOREIGN KEY (log_id)
REFERENCES public."ARB_LOGICO" (log_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_TAB_ERROR_MAE_IDIOMAS" | type: CONSTRAINT --
-- ALTER TABLE public."TAB_ERROR" DROP CONSTRAINT IF EXISTS "FK_TAB_ERROR_MAE_IDIOMAS" CASCADE;
ALTER TABLE public."TAB_ERROR" ADD CONSTRAINT "FK_TAB_ERROR_MAE_IDIOMAS" FOREIGN KEY (idi_id)
REFERENCES public."MAE_IDIOMAS" (idi_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


