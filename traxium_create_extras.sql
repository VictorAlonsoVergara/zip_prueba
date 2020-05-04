create or replace function buscar_hijos_arbol_fisico (id INTEGER)
	RETURNS TABLE (
		id_hijo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "ARB_FISICO" where fis_id_padre = id) LOOP
		SELECT array_append(array_padres,padre_rec.fis_id_padre) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.fis_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			id_padre := array_padres[index];
			id_hijo := array_hijos[index];
			FOR padre_rec IN (select * from "ARB_FISICO" where fis_id_padre = array_hijos[index]) LOOP
				SELECT array_append(array_padres,padre_rec.fis_id_padre) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.fis_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
			RETURN NEXT;
		END LOOP;
	END IF;
END $$
LANGUAGE plpgsql;

create or replace function buscar_padres_arbol_fisico (id INTEGER)
	RETURNS TABLE (
		id_nodo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	salir INTEGER := 1;
	padre INTEGER;
	hijo INTEGER;
BEGIN
	salir := 1;
	hijo := id;
	WHILE salir > 0 LOOP
		padre := (select fis_id_padre from "ARB_FISICO" where fis_id = hijo limit 1);
		id_nodo := hijo;
		id_padre := padre;
		IF id_padre IS NULL THEN
			salir := 0;
		END IF;
		hijo := padre;
		RETURN NEXT;
	END LOOP;
END $$
LANGUAGE plpgsql;

create or replace function buscar_hijos_arbol_logico (id INTEGER)
	RETURNS TABLE (
		id_hijo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "ARB_LOGICO" where log_id_padre = id) LOOP
		SELECT array_append(array_padres,padre_rec.log_id_padre) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.log_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			id_padre := array_padres[index];
			id_hijo := array_hijos[index];
			FOR padre_rec IN (select * from "ARB_LOGICO" where log_id_padre = array_hijos[index]) LOOP
				SELECT array_append(array_padres,padre_rec.log_id_padre) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.log_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
			RETURN NEXT;
		END LOOP;
	END IF;
END $$
LANGUAGE plpgsql;

create or replace function buscar_padres_arbol_logico (id INTEGER)
	RETURNS TABLE (
		id_nodo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	salir INTEGER := 1;
	padre INTEGER;
	hijo INTEGER;
BEGIN
	salir := 1;
	hijo := id;
	WHILE salir > 0 LOOP
		padre := (select log_id_padre from "ARB_LOGICO" where log_id = hijo limit 1);
		id_nodo := hijo;
		id_padre := padre;
		IF id_padre IS NULL THEN
			salir := 0;
		END IF;
		hijo := padre;
		RETURN NEXT;
	END LOOP;
END $$
LANGUAGE plpgsql;

create or replace function buscar_hijos_tipo_objeto (id INTEGER)
	RETURNS TABLE (
		id_hijo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "MAT_TIPO_OBJ" where tobj_padre_id = id and tobj_estado = 'A') LOOP
		SELECT array_append(array_padres,padre_rec.tobj_padre_id) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.tobj_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			id_padre := array_padres[index];
			id_hijo := array_hijos[index];
			FOR padre_rec IN (select * from "MAT_TIPO_OBJ" where tobj_padre_id = array_hijos[index] and tobj_estado = 'A') LOOP
				SELECT array_append(array_padres,padre_rec.tobj_padre_id) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.tobj_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
			RETURN NEXT;
		END LOOP;
	END IF;
END $$
LANGUAGE plpgsql;

create or replace function buscar_padres_tipo_objeto (id INTEGER)
	RETURNS TABLE (
		id_nodo INTEGER,
		id_padre INTEGER
)
AS $$
DECLARE
	salir INTEGER := 1;
	padre INTEGER;
	hijo INTEGER;
BEGIN
	salir := 1;
	hijo := id;
	WHILE salir > 0 LOOP
		padre := (select tobj_padre_id from "MAT_TIPO_OBJ" where tobj_id = hijo limit 1);
		id_nodo := hijo;
		id_padre := padre;
		IF id_padre IS NULL THEN
			salir := 0;
		END IF;
		hijo := padre;
		RETURN NEXT;
	END LOOP;
END $$
LANGUAGE plpgsql;

create or replace procedure borrar_rama_arbol_fisico (id IN INTEGER , borrados INOUT INTEGER[])
LANGUAGE plpgsql
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "ARB_FISICO" where fis_id_padre = id) LOOP
		SELECT array_append(array_padres,padre_rec.fis_id_padre) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.fis_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			FOR padre_rec IN (select * from "ARB_FISICO" where fis_id_padre = array_hijos[index]) LOOP
				SELECT array_append(array_padres,padre_rec.fis_id_padre) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.fis_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
		END LOOP;

		SELECT array_prepend(id,array_hijos) INTO array_hijos;
		borrados := array_hijos;
		index := array_len+1;
		WHILE index > 0 LOOP
			DELETE FROM "ARB_FISICO" WHERE fis_id = array_hijos[index];
			index := index - 1;
		END LOOP;
	ELSE
		borrados := ARRAY [id];
		DELETE FROM "ARB_FISICO" WHERE fis_id = id;
	END IF;
END $$;

create or replace procedure borrar_rama_arbol_logico (id IN INTEGER , borrados INOUT INTEGER[])
LANGUAGE plpgsql
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "ARB_LOGICO" where log_id_padre = id) LOOP
		SELECT array_append(array_padres,padre_rec.log_id_padre) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.log_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			FOR padre_rec IN (select * from "ARB_LOGICO" where log_id_padre = array_hijos[index]) LOOP
				SELECT array_append(array_padres,padre_rec.log_id_padre) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.log_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
		END LOOP;

		SELECT array_prepend(id,array_hijos) INTO array_hijos;
		borrados := array_hijos;
		index := array_len+1;
		WHILE index > 0 LOOP
			DELETE FROM "ARB_LOGICO" WHERE log_id = array_hijos[index];
			index := index - 1;
		END LOOP;
	ELSE
		borrados := ARRAY [id];
		DELETE FROM "ARB_LOGICO" WHERE log_id = id;
	END IF;
END $$;

create or replace procedure borrar_rama_tipo_objeto (id IN INTEGER , borrados INOUT INTEGER[])
LANGUAGE plpgsql
AS $$
DECLARE
	array_len INTEGER;
	padre_rec record;
	index INTEGER := 1;
	array_padres INTEGER[];
	array_hijos INTEGER[];
BEGIN
	FOR padre_rec IN (select * from "MAT_TIPO_OBJ" where tobj_padre_id = id) LOOP
		SELECT array_append(array_padres,padre_rec.tobj_padre_id) INTO array_padres;
		SELECT array_append(array_hijos,padre_rec.tobj_id) INTO array_hijos;
	END LOOP;
	IF array_length(array_padres,1) > 0 THEN
		array_len := array_upper(array_padres,1);
		WHILE index <= array_len LOOP
			FOR padre_rec IN (select * from "MAT_TIPO_OBJ" where tobj_padre_id = array_hijos[index]) LOOP
				SELECT array_append(array_padres,padre_rec.tobj_padre_id) INTO array_padres;
				SELECT array_append(array_hijos,padre_rec.tobj_id) INTO array_hijos;
				array_len := array_upper(array_padres,1);
			END LOOP;
			index := index + 1;
		END LOOP;

		SELECT array_prepend(id,array_hijos) INTO array_hijos;
		borrados := array_hijos;
		index := array_len+1;
		WHILE index > 0 LOOP
			DELETE FROM "MAT_TIPO_OBJ" WHERE tobj_id = array_hijos[index];
			index := index - 1;
		END LOOP;
	ELSE
		borrados := ARRAY [id];
		DELETE FROM "MAT_TIPO_OBJ" WHERE tobj_id = id;
	END IF;
END $$;

--create or replace view view_crons_consultas_objetos as
--select cron.cron_id,cons.con_trama_pregunta,
--		prot.prot_abreviacion,obj.obj_id,obj.obj_ip_address,obj.obj_usuario,obj.obj_password
--from "MAE_CRON" as cron 
--join "MAE_OBJETOS" as obj on obj.tobj_id = cron.tobj_id and obj.prot_id = cron.prot_id
--join "MAE_CONSULTAS" as cons on cons.prot_id = cron.prot_id and cons.mod_id = obj.mod_id
--join "TAB_PROTOCOLO" as prot on prot.prot_id = cron.prot_id
--where cron.cron_estado = 'A' and obj.obj_estado = 'A'
--order by cron.cron_id,cons.con_id,obj.obj_id;