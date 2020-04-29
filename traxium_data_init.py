import psycopg2
from hashlib import blake2b

con = psycopg2.connect(database='traxium',user='traxium',password='traxium')
cur = con.cursor()

tup = [(1,"Español","es","A"), (2,"English","en","A")]
sql_stuff = 'INSERT INTO "MAE_IDIOMAS" (idi_id,idi_desc,idi_key,idi_estado) VALUES (%s,%s,%s,%s)'
cur.executemany(sql_stuff,tup)
con.commit()

tup = [	(1, "Administrador","A"), (2,"Usuario","A")]
sql_stuff = 'INSERT INTO "MAE_TIPO_USU" (tusu_id,tusu_desc,tusu_estado) VALUES (%s,%s,%s)'
cur.executemany(sql_stuff,tup)
con.commit()

tup = [	(1, "mantenimiento_soft","Mantenimiento de software","A"),]
sql_stuff = 'INSERT INTO "MAE_AREA" VALUES (%s,%s,%s,%s)'
cur.executemany(sql_stuff,tup)
con.commit()

hToken = blake2b(digest_size=32)
clave = "password"
hToken.update(clave.encode())
password = hToken.hexdigest()
tup = (1, "Usuario Administrador",1,"A","correoAdministrador@mail.com","usu_administrador",password,1,1,1)
sql_stuff = 'INSERT INTO "MAE_USUARIOS" VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
cur.execute(sql_stuff,tup)
con.commit()

tup = [	("estado_usuario", "Estados de usuario del sistema"),("estado_documento", "Estados de documento"),("estado_password_mayus", "Estado del flag de mayuscula para el password"),("estado_password_num", "Estado del flag de numero para el password"),("estado_password_carac", "Estado del flag de caracteres especiales para el password"),("longitud_pass", "longitud minima del password"), ("estado_token", "duracion maxima del token")]
sql_stuff = 'INSERT INTO "PARAM_GRUPO" (grupo_codigo,grupo_nombre) VALUES (%s,%s)'
cur.executemany(sql_stuff,tup)
con.commit()

tup = [	("estado_usuario", "A", "Activo"),("estado_usuario", "D", "Desactivado"),("estado_usuario", "E", "Eliminado"),("estado_password_mayus", "A+1", "EA Activo / D Desactivado + numero minimo"),("estado_password_num", "A+1", "A Activo / D Desactivado + numero minimo"),("estado_password_carac", "A+1", "A Activo / D Desactivado + numero minimo"),("longitud_pass", "12", "Longitud de la cadena"), ("estado_token", "51", "Los minutos que el token se mantiene activo")]
sql_stuff = 'INSERT INTO "PARAM" (param_grupo,param_id,param_valor) VALUES (%s,%s,%s)'
cur.executemany(sql_stuff,tup)
con.commit()

insert_menu = ('INSERT INTO "TAB_MENU" (menu_desc,menu_name,menu_ord) VALUES (%s,%s,%s)')
data_menu = [
('Permiso para tipo de usuario','Tipo Usuario',2),
('Permiso para crons','Cron',14),
('Permiso para Tipo de objetos','Tipo Objeto',11),
('Permiso para ejecuciones','Ejecuciones',22),
('Permiso para consultas','Consultas',17),
('Permiso para reportes','Reportes',20),
('Permiso para objetos','Objetos',12),
('Permiso para accesos a reportes','Usuario Acceso Reportes',6),
('Permiso para alertas de usuario','Usuario Alertas',5),
('Permiso para acceso de arboles','Usuario Acceso ArboLes',7),
('Permiso para arboles fisicos','Arboles Fisicos',18),
('Permiso para arboles logicos','Arboles Logicos',19),
('Permiso para objetos fisicos','Objetos Fisicos',23),
('Permiso para objetos logicos','Objetos Logicos',24),
('Permiso para marcas','Marcas',13),
('Permiso para area','Areas',10),
('Permiso para idiomas','Idiomas',8),
('Permios para modelos','Modelos',15),
('Permiso para menu de usuarios','Usuarios Menu',3),
('Permiso para menus','Menu',9),
('Permiso para protocolos','Protocolos',16),
('Permiso para acciones','Acciones',21),
('Permiso para acciones de usuarios','Acciones usuario', 4),
('Permiso para usuarios','Usuarios',1)]

cur.executemany(insert_menu,data_menu)
con.commit()

insert_reportes = ('INSERT INTO "TAB_REPORTES" (rep_desc,rep_estado,rep_ldesc) VALUES (%s,%s,%s)')
data_reportes = ('Reporte Ejemplo','A','Reporte de ejemplo al inicar el servidor')
cur.execute(insert_reportes,data_reportes)
con.commit()

insert_reportes = ('INSERT INTO "MAE_USU_ACCESOS_REPORTES" (rep_id,usu_id,urep_estado) VALUES (%s,%s,%s)')
data_reportes = (1,1,True)
cur.execute(insert_reportes,data_reportes)
con.commit()

insert_prot = ('INSERT INTO "TAB_PROTOCOLO" (prot_desc,prot_abreviacion) VALUES (%s,%s)')
data_prot = [('SNMP','S'),('SSH','H'),('Telnet','T'),('TR01','0')]
cur.executemany(insert_prot,data_prot)
con.commit()

tup = [	("Ver usuario",),("Listar usuario",),("Crear usuario",),("Modificar usuario",),("Borrar usuario",),("Autenticar usuario",),("Cerrar usuario",),("Desactivar usuario",),("Activar usuario",),("Eliminar usuario",),
		("Ver tipo usuario",),("Listar tipo usuario",),("Crear tipo usuario",),("Modificar tipo usuario",),("Borrar tipo usuario",),
		("Ver cron",),("Listar cron",),("Crear cron",),("Modificar cron",),("Borrar cron",),
		("Ver tipo objeto",),("Listar tipo objeto",),("Crear tipo objeto",),("Modificar tipo objeto",),("Borrar tipo objeto",),("Borrar todo tipo objeto",),("Buscar hijos tipo objeto",),("Buscar padres tipo objeto",),("Buscar hermanos tipo objeto",),
		("Ver ejecuciones",),("Listar ejecuciones",),
		("Ver consultas",),("Listar consultas",),("Crear consultas",),("Modificar consultas",),("Borrar consultas",),
		("Ver reportes",),("Listar reportes",),("Crear reportes",),("Modificar reportes",),("Borrar reportes",),
		("Ver objeto",),("Listar objeto",),("Crear objeto",),("Modificar objeto",),("Borrar objeto",),
		("Ver usuario acceso indicadores",),("Listar usuario acceso indicadores",),("Crear usuario acceso indicadores",),("Modificar usuario acceso indicadores",),("Borrar usuario acceso indicadores",),
		("Ver usuario acceso reportes",),("Listar usuario acceso reportes",),("Crear usuario acceso reportes",),("Modificar usuario acceso reportes",),("Borrar usuario acceso reportes",),
		("Ver usuario alertas",),("Listar usuario alertas",),("Crear usuario alertas",),("Modificar usuario alertas",),("Borrar usuario alertas",),
		("Ver usuario accesos arboles",),("Listar usuario accesos arboles",),("Crear usuario accesos arboles",),("Modificar usuario accesos arboles",),("Borrar usuario accesos arboles",),
		("Ver arboles fisicos",),("Listar arboles fisicos",),("Crear arboles fisicos",),("Modificar arboles fisicos",),("Borrar arboles fisicos",),("Borrar todo arboles fisicos",),("Buscar hijos arboles fisicos",),("Buscar padres arboles fisicos",),("Buscar hermanos arboles fisicos",),
		("Ver arboles logicos",),("Listar arboles logicos",),("Crear arboles logicos",),("Modificar arboles logicos",),("Borrar arboles logicos",),("Borrar todo arboles logicos",),("Buscar hijos arboles logicos",),("Buscar padres arboles logicos",),("Buscar hermanos arboles logicos",),
		("Ver objeto fisico",),("Listar objeto fisico",),("Crear objeto fisico",),("Modificar objeto fisico",),("Borrar objeto fisico",),
		("Ver objeto logico",),("Listar objeto logico",),("Crear objeto logico",),("Modificar objeto logico",),("Borrar objeto logico",),
		("Ver marcas",),("Listar marcas",),("Crear marcas",),("Modificar marcas",),("Borrar marcas",),
		("Ver area",),("Listar area",),("Crear area",),("Modificar area",),("Borrar area",),
		("Ver idiomas",),("Listar idiomas",),("Crear idiomas",),("Modificar idiomas",),("Borrar idiomas",),
		("Ver modelo",),("Listar modelo",),("Crear modelo",),("Modificar modelo",),("Borrar modelo",),
		("Ver usuario menu",),("Listar usuario menu",),("Crear usuario menu",),("Modificar usuario menu",),("Borrar usuario menu",),("Menus usuario menu",),("Editar usuario menu",),
		("Ver tab menu",),("Listar tab menu",),
		("Ver tab acciones",),("Listar tab acciones",),
		("Ver tab protocolo",),("Listar tab protocolo",),
		("Ver tab param",),("Ver tab param grupo",),
		("Check token",)]

sql_stuff = 'INSERT INTO "TAB_ACCIONES" (acc_desc,acc_id) VALUES (%s,%s)'
conteo = 393
for i in tup :
	#print(i)
	cur.execute(sql_stuff,(i[0],conteo))
	con.commit()
	conteo = conteo + 1


insert_usuarios_menu = ('INSERT INTO "MAE_USUARIOS_MENU" (usu_id,menu_id,estado_umenu) VALUES (%s,%s,%s)')
data_usuarios_menu = []
for ind in range(len(data_menu)):
	data_usuarios_menu.append((1,ind+1,True))
cur.executemany(insert_usuarios_menu,data_usuarios_menu)
con.commit()
con.close()