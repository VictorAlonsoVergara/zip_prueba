import sys ,os

sys.path.insert(0, "/home/sistema/clases")
#sys.path.insert(1, "/home/sistema/repor_input")
#sys.path += ["/home/sistema/clases","/home/sistema/repor_input"]
#sys.path += ['/home/sistema/clases','/home/sistema/repor_input']
#sys.path.append("/home/sistema/clases")
#sys.path.append("/home/sistema/repor_input")
import json
from MAE_USUARIOS import MAE_USUARIOS
from genera_reporte import genera_reporte
from LOG_ACCIONES_USUARIO import LOG_ACCIONES_USUARIO
from clsSession import Session
import validations
import generico

def application(environ, start_response):
    try: 
        coo = ""
        jsdato = ""
        response_content_type = "application/json"
        extra = {}
        status = "200 OK"  # se crea la respuesta de estado
        if environ['REQUEST_METHOD'] != 'POST':
            raise validations.HttpException(405)
        lendata = int(environ.get("CONTENT_LENGTH", 0))  # se guarda los datos enviados
        bydata = environ["wsgi.input"].read(lendata)
        jsdata = json.loads(bydata.decode("utf-8"))  # se convierte los datos y json
        try:
            dataIP = environ["HTTP_X_FORWARDED_FOR"].split(",")[-1].strip()
        except KeyError:
            dataIP = environ["REMOTE_ADDR"]
        s = Session()
        cookie = environ.get("HTTP_COOKIE", 0)  # se obtiene la informacion del cookie
        tk = s.getCookie(cookie, "token")  
        if (s.valToken(tk) and s.valIp(tk, str(dataIP))):  
            jsdato = s.get_Datos_Usu(str(tk))  
            try:
                #se valida que los datos recibidos por el json sean correctos
                diccionario_respu = {}
                pass_flag = True
                usu_id = s.get_id_Usu(str(tk))
                diccionario_respu['filtro'] = validations.validate_varchar(jsdata["filtro"],100)
                diccionario_respu['reporte'] = validations.validate_varchar(jsdata["reporte"],100)
                diccionario_respu['tipo'] = validations.validate_varchar(jsdata["tipo"], 100)
                diccionario_respu['tabla'] = validations.validate_varchar(jsdata["tabla"], 100)


                #se escribe los mensajes de error 
                for key,value in jsdata.items():
                    value_empty = validations.validate_empty(value)
                    if value_empty[0] is True:
                        diccionario_respu[key] = value_empty
                        diccionario_respu[key][0] = False

                #se verifica que las respuestas sean correctas
                for _,value in diccionario_respu.items():
                    if value[0] is False:
                        pass_flag = False
                        break
                #en caso las respuestas sean correctas se realiza la accion correspondiente 
                if pass_flag is True:
                    usu_id = s.get_id_Usu(str(tk))
                    obj2 = MAE_USUARIOS(usu_id = usu_id)
                    dato = obj2.buscar_dato()

                    obj = genera_reporte(usuario_creador=obj2.usu_nombre,filtro=jsdata["filtro"],reporte=jsdata["reporte"],tipo=jsdata["tipo"],tabla=jsdata["tabla"])
                    obj.compiling()
                    obj.processing()
                    obj.parametros()
                    ruta = obj.cambio_nombre()
                    resp=["ok",ruta]
                else:
                    resp = ["error", ""]
                    num = 0
                    for key,respu in diccionario_respu.items():
                        if respu[0] == False:
                            
                            extra[key] = respu[1]
                        num = num + 1
                linea = {}
                if resp[0] == "ok":
                    linea['result'] = "ok"
                    #f = open(resp[1],'rb')
                    #variable = f.read()
                    #f.close()
                    variable = {}
                    variable['result'] = 'ok'
                    variable['nombre'] = resp[1]
                    #Como la respuesta es correcta se guarda en el log de acciones
                    usu_id = s.get_id_Usu(str(tk))
                    filename = os.path.basename(__file__).split('.')[0]
                    obj_log = LOG_ACCIONES_USUARIO(log_usu_id=usu_id,log_desc ='S ',log_acc_id = 395)
                    resp_log = obj_log.guardar_dato()
                    if resp_log[0] == 'error':
                        linea['result'] = "failed"
                        linea['error'] = "Sucedio un error"
                        linea['error_cod'] = 411
                        status = "400 Bad Request"

                        linea['val_errors'] = "No se pudo guardar en el log"
                else:
                    linea["result"] = "failed"
                    linea["error"] = "Sucedio un error"
                    linea["error_cod"] = 412
                    status = "400 Bad Request"

                    if bool(extra):
                        linea["val_errors"] = extra
                        #linea["tipo"] = "extra"
                    else:
                        linea["val_errors"] = resp[1]
            #en caso de error se entra al exception del programa
            except Exception as e:
                linea = {}
                exc_type, exc_obj, exc_tb = sys.exc_info()
                fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]                
                resp = ["error", str(e)+' '+str(exc_type)+" "+str(fname)+" "+str(exc_tb.tb_lineno)]
                linea["result"] = "failed"
                linea["error"] = "Sucedio un error"
                linea["error_cod"] = 412
                linea["val_errors"] = resp[1]
                status = "500 Internal Server Error"
        else:
            resp = ["error", "Token no validado"]#+str(tk)+" "+str(dataIP)]
            raise validations.HttpException(401,"Token no validado")
            status = "401 Unauthorized"

    except validations.HttpException as e:
        linea = {}
        linea.update(e.get_error_dict())
        status = e.status_code

    except Exception as e:
        linea = {}
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        resp = ["error", str(e)+' '+str(exc_type)+" "+str(fname)+" "+str(exc_tb.tb_lineno)]
        linea["result"] = "failed"
        linea["error"] = "Sucedio un error"
        linea["error_cod"] = 412
        linea["val_errors"] = resp[1]
        status = "500 Internal Server Error"
    cook = 'dato="' + str(jsdato) + '" ;path=/'
    if linea['result'] == 'ok' :
        headers = [
            ('Content-Type', 'application/json'),
            ("Access-Control-Allow-Origin", "http://localhost:4200"),
            ("Access-Control-Allow-Credentials", "true"),
            ("set-cookie", cook),
        ]
        preoutput = json.dumps(variable)
        output = bytes(preoutput, "utf-8")
    else :
        preoutput = json.dumps(linea)
        output = bytes(preoutput, "utf-8")
        # se coloca la configuracion de las cabeceras y los datos a devolver en los cookies
        headers = [
            ('Content-Type', 'application/json'),
            ("Access-Control-Allow-Origin", "http://localhost:4200"),
            ("Access-Control-Allow-Credentials", "true"),
            ("set-cookie", cook),
        ]
    start_response(status, headers)
    return [output]