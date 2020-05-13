	# -- coding: utf-8 --
'''
===========================================================================
--  PROJECT NAME  : Traxium 
--  SOURCE FILE   : lista_arb_fis.py
--  REVISION      : 1.1
--  AUTHOR        : 
--  LAST UPDATE   : Mayo 6, 2020
--===========================================================================
--  DESCRIPTION   : Metodo que lista todos los arboles fisicos existentes
--===========================================================================
'''
import sys, os
import datetime, logging
sys.path.insert(0, "/home/sistema/clases")

from clsSession import Session
import json
from ARB_FISICO import ARB_FISICO
from ARB_LOGICO import ARB_LOGICO
import validations
rutalog="/home/sistema/log/Traxium"

def application(environ, start_response):

	try:
		coo = ""
		jsdato = ""
		status = "200 OK"
		

		try:
			dataIP = environ["HTTP_X_FORWARDED_FOR"].split(",")[-1].strip()
		except KeyError:
			dataIP = environ["REMOTE_ADDR"]
		s = Session()
		cookie = environ.get("HTTP_COOKIE", 0)
		tk = s.getCookie(cookie, "token")
		s.setToken(tk)
		datosB = s.getCookie(cookie, "dato")
		len_datosB = len(datosB)
		datosC = json.loads(datosB[1:(len_datosB-1)])
		if environ['REQUEST_METHOD'] != 'GET':
			#status = "405 Method Not Allowed"
			raise validations.HttpException(405)
		if s.valToken(tk) and s.valIp(tk, str(dataIP)):
			jsdato = s.get_Datos_Usu(str(tk))
			diccionario = ARB_FISICO.consultar_lista()
			for elem in diccionario:
				new_key = "arb_id"
				old_key = "fis_id"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_id_padre"
				old_key = "fis_id_padre"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_desc"
				old_key = "fis_desc"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_orden"
				old_key = "fis_orden"
				elem[new_key] = elem.pop(old_key)
				elem.update({'tipo':'fisico'})

			diccionario = ARB_LOGICO.consultar_lista()
			for elem in diccionario:
				new_key = "arb_id"
				old_key = "log_id"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_id_padre"
				old_key = "log_id_padre"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_desc"
				old_key = "log_desc"
				elem[new_key] = elem.pop(old_key)
				new_key = "arb_orden"
				old_key = "log_orden"
				elem[new_key] = elem.pop(old_key)
				elem.update({'tipo':'logico'})


			if 'error' in diccionario :
				status = "400 Bad Request"
			# else:
			# 	usu_id = s.get_id_Usu(str(tk))
			# 	filename = os.path.basename(__file__).split('.')[0]
			# 	obj_log = LOG_ACCIONES_USUARIO(log_usu_id=usu_id,log_desc ='Se obtiene la lista de arb_fisico',log_acc_id = 460)
			# 	resp_log = obj_log.guardar_dato()
			# 	if resp_log[0] == 'error':
			# 		mensaje = s.mensaje_error(datosC['idioma'],103)
			# 		diccionario['result'] = "failed"
			# 		diccionario['error'] = "Sucedio un error"
			# 		diccionario['error_cod'] = 103
			# 		status = "400 Bad Request"
			# 		diccionario['val_errors'] = str(mensaje[1][0][0])
		else:
			if s.valToken(tk) :
				cod_error = 100
			else :
				cod_error = 101
			mensaje = s.mensaje_error(datosC['idioma'],cod_error)
			status = "401 Unauthorized"
			diccionario = {}
			diccionario["result"] = "failed"
			diccionario["error"] = "Sucedio un error cookie" 
			diccionario["error_cod"] = cod_error
			diccionario["val_errors"] = str(mensaje[1][0][0])
	except validations.HttpException as e:
		diccionario = {}
		mensaje = s.mensaje_error(datosC['idioma'],51)
		diccionario["result"] = "failed"
		diccionario["error_cod"] = 51
		diccionario["error"] = "Sucedio un error"
		diccionario["val_errors"] = str(mensaje[1][0][0])
		status = e.status_code


	except Exception as e:
		exc_type, exc_obj, exc_tb = sys.exc_info()
		fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
		diccionario = {}
		diccionario["result"] = "failed"
		diccionario["error"] = "Sucedio un error"
		diccionario["error_cod"] = 50
		try :
			mensaje = s.mensaje_error(datosC['idioma'],50)
			diccionario["val_errors"] = str(mensaje[1][0][0])
		except:
			diccionario["val_errors"] = 'error de python' 
		status = "500 Internal Server Error"              
		datoError = str(e)+' - '+str(exc_type)+' - '+str(fname)+' - '+str(exc_tb.tb_lineno)
		now = datetime.datetime.now()
		fecha= datetime.date.today()
		current_time = now.strftime("%Y-%m-%d %H:%M:%S")
		logger = logging.getLogger('__name__')
		logger.setLevel(logging.ERROR)
		nombre_log= rutalog+'_'+str(fecha)+'.log'
		fh = logging.FileHandler(nombre_log)
		fh.setLevel(logging.ERROR)
		logger.addHandler(fh)
		logger.error("Error: "+str(current_time) + datoError)

	preoutput = json.dumps(diccionario)
	output = bytes(preoutput, "utf-8")
	cook = 'dato="' + str(jsdato) + '" ;path=/'
	headers = [
		('Content-Type', 'application/json'),
		("Access-Control-Allow-Origin", "http://localhost:4200"),
		("Access-Control-Allow-Credentials", "true"),
		("set-cookie", cook),
	]
	start_response(status, headers)
	return [output]
