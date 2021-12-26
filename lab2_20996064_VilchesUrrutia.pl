% Representación de la plataforma/paradigmadocs
% Representación: [NombrePlataforma FechaCreación [TDAusuarios] [TDAdocumentos]]
%                 [ string, date, [ [date, string, string, integer], [...] ], [ [integer, string, string, date [ [integer, date, string], [...] ], [ [string, access], [...] ] [...] ] ]
% TDA usuarios: [date, string, string, integer]
% TDA documentos: [integer, string, string, date, [ [TDA versiones], [...] ], [ [string access], [...] ]
% TDA versiones: [integer, date, string]
%
%
% TDA Fecha
% Representación: [DD, MM, YYYY]
%                 [integer, integer, integer]
%                 date(Dia, Mes, Anio, Fecha).
% Dominio: Se emplean tres valores enteros y una variable (contenedor Fecha)
% Meta: date
% Descripción: La regla permite realizar operaciones (constructor, pertenencia y selección) sobre un tipo de ...
%              ...dato fecha u date como se sugiere implementar en el enunciado del proyecto

date(DD, MM, YYYY, [DD, MM, YYYY]):-
    YYYY >= 0,
    MM >= 1,
    MM =< 12,
    DD >= 1,
    DD =< 31.

% Como constructor
% date(13, 12, 2021, Fecha).
% Como pertenencia
% date(_, _, _, [13, 12, 2021]).
% Como selector
% date(_, _, YYYY, [13, 12, 2021]).

% Dominio: Se emplea el tipo de dato fecha y una variable (contenedor del string Fecha)
% Predicado: date(Dia, Mes, Anio, Fecha).
% Meta primaria: fechaToString
% Meta secundaria (no nativa): date
% Descripción: La regla permite la transformación de un dato tipo fecha a string

fechaToString([], "").
fechaToString(Fecha, FechaString):-
    date(DD, MM, YYYY, Fecha),
    number_string(DD, DiaString),
    number_string(MM, MesString),
    number_string(YYYY, AnioString),
    atomics_to_string([DiaString, "-", MesString,"-", AnioString], FechaString).

% Ejemplo:
% fechaToString([3, 12, 2021], FechaString).

% TDA paradigmadocs
% Representación: [NombrePlataforma FechaCreación [TDAusuarios] [TDAdocumentos]]
%                 [ string, date, [ [date, string, string, integer], [...] ], [ [integer, string, date [ [integer, date, string], [...] ], [ [string, access], [...]]]]]
%                 paradigmaDocs(NombrePlataforma, [Dia, Mes, Anio], ListaUsuarios, ListaDocumentos).
% Dominio: Se emplea un string, tipo de dato fecha, dos listas inicialmente vacias y una variable (contenedor ParadigmaDocs)
% Predicado: date(Dia, Mes, Anio, Fecha).
% Meta primaria: paradigmaDocs
% Meta secundaria (no nativa): date
% Descripción: La regla permite realizar operaciones (constructor, pertenencia y selección) sobre un tipo de ...
%              ...dato paradigmaDocs u plataforma

paradigmaDocs(NombrePlataforma, [DD, MM, YYYY], ListaUsuarios, ListaDocumentos, [NombrePlataforma, [DD, MM, YYYY], ListaUsuarios, ListaDocumentos]):-
    string(NombrePlataforma),
    date(_, _, _, [DD, MM, YYYY]).

% Como constructor
% paradigmaDocs("paradigmaDocs", [12, 10, 2002], [], [], ParadigmaDocs).
% Como pertenencia
% paradigmaDocs(_, _, _, _, ["paradigmaDocs", [12, 10, 2002], [], []]).
% Como selector
% paradigmaDocs(_, _, ListaUsuarios, _, ["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 0]], []]).

% TDA usuarios
% Representación: [[DD, MM, YYYY], Usuario, Contrasenia, Sesión]
%                 [date, string, string, integer]
% Dominio: Se emplea un tipo de dato fecha, dos strings, un entero (inicialmente 0) y una variable (contenedor Usuario)
% Predicado: date(Dia, Mes, Anio, Fecha).
% Meta primaria: usuario
% Meta secundaria (no nativa): date
% Descripción: La regla permite realizar operaciones (constructor, pertenencia y selección) sobre un tipo de ...
%              ...dato usuario

usuario([DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, Sesion, [[DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, Sesion]):-
    date(_, _, _, [DD, MM, YYYY]),
    string(NombreUsuario),
    string(ContraseniaUsuario),
    integer(Sesion).

% Como constructor
% usuario([14, 12, 2021], "USER1", "PASS1", 0, USUARIO1).
% Como pertenencia
% usuario(_, _, _, _, [[14, 12, 2021], "USER1", "PASS1", 0]).
% Como selector
% usuario(_, Usuario, _, _, [[14, 12, 2021], "USER1", "PASS1", 0]).

% Dominio: Se emplea el tipo de dato usuario y una variable (contenedor del string Usuario)
% Predicado: fechaToString(Fecha, FechaString).
% Meta primaria: usuarioToString
% Meta secundaria (no nativa): fechaToString
% Descripción: La regla permite la transformación de un dato tipo usuario a string

usuarioToString([], "").
usuarioToString([[DD, MM, YYYY], NombreUsuario, _, _], UsuarioString):-
    string_concat("Nombre de usuario: ", NombreUsuario, NombreUsuarioString),
    fechaToString([DD, MM, YYYY], FechaString),
    string_concat("Fecha de creacion: ", FechaString, FechaCreacionString),
    atomics_to_string([NombreUsuarioString, " - ", FechaCreacionString, "\n"],
                      UsuarioString).
    
% Ejemplo:
% usuarioToString(["Jaime", [3, 12, 2021]], UsuarioString).

% Dominio: Se emplea una lista contenedora de datos del tipo usuario, un acumulador ("") y una variable (contenedor del string de todos los Usuarios)
% Predicado: usuarioToString(Usuario, UsuarioString).
% Meta primaria: usuariosToString
% Meta secundaria (no nativa): usuarioToString
% Descripción: La regla permite la transformación de todos los datos tipos usuario a string

usuariosToString([], Acum, Acum).
usuariosToString([Cabeza|Resto], Acum, UsuariosString):-
    usuarioToString(Cabeza, UsuarioString),
    string_concat(UsuarioString, Acum, Aux),
    usuariosToString(Resto, Aux, UsuariosString).

% TDA documento
% Representación: [integer, string, string, date [ [TDA versiones] [...] ] [ [string access] [...] ]
%                 [IDdocumento, NombreDocumento, Autor, FechaCreación, ListaVersiones, ListaAccesos]
% Dominio: Se emplea un valor entero, dos strings, dato tipo fecha, dos listas inicialmente vacias y una variable (contenedor Documento)
% Predicado: date(Dia, Mes, Anio, Fecha).
% Meta primaria: documento
% Meta secundaria (no nativa): date
% Descripción: La regla permite realizar operaciones (constructor, pertenencia y selección) sobre un tipo de ...
%              ...dato documento
% 
% Constructor documento
documento(IDdocumento, NombreDocumento, Autor, [DD, MM, YYYY], ListaVersiones, ListaAccesos, [IDdocumento, NombreDocumento, Autor, [DD, MM, YYYY], ListaVersiones, ListaAccesos]):-
    integer(IDdocumento),
    string(NombreDocumento),
    string(Autor),
    date(_, _, _, [DD, MM, YYYY]).

% Como constructor
% documento(0, "Doc1", "USER1", [14, 12, 2021], [], [], Documento1).
% Como pertenencia
% documento(_, _, _, _, _, _, [0, "Doc1", "USER1", [14, 12, 2021], [[0, [14, 12, 2021], "PRIMER CONTENIDO DOC1"]], []]).
% Como selector
% documento(_, NombreDocumento, _, _, _, _, [0, "Doc1", "USER1", [14, 12, 2021], [[0, [14, 12, 2021], "PRIMER CONTENIDO DOC1"]], []]).

% Dominio: Se emplea el tipo de dato documento y una variable (contenedor del string Documento)
% Predicado: fechaToString(Fecha, FechaString).
%            versionesToString(ListaVersiones, "", VersionesString).
%            accesosToString(ListaAccesos, "", AccesosString).
% Meta primaria: documentoToString
% Meta secundaria (no nativa): fechaToString
%                              versionesToString
%                              accesosToString
% Descripción: La regla permite la transformación de un dato tipo documento a string

documentoToString([], "").
documentoToString([IDdocumento, NombreDocumento, Autor, [DD, MM, YYYY], ListaVersiones, ListaAccesos], DocumentoString):-
	number_string(IDdocumento, IDdocumentoString),
	fechaToString([DD, MM, YYYY], FechaString),
  	versionesToString(ListaVersiones, "", VersionesString),
    accesosToString(ListaAccesos, "", AccesosString),
    atomics_to_string(["ID documento: ", IDdocumentoString, '\n',
                       "Nombre documento: ", NombreDocumento, '\n',
                       "Autor: ", Autor, '\n',
                       "Fecha creacion documento: ", FechaString, '\n',
                       VersionesString, '\n',
                       AccesosString, '\n'], DocumentoString).
    
% Ejemplo:
% documentoToString([0, "archivo 1", "vflores", [1, 12, 2021], [[0, [1, 12, 2021], "hola mundo, este es el contenido de un archivo"], [1, [19, 12, 2021], "Este es el tercer texto y/o contenido"], [2, [19, 12, 2021], "Este es el segundo texto y/o contenido"]], []], DocumentoString).

% Dominio: Se emplea una lista contenedora de datos del tipo documento, un acumulador ("") y una variable (contenedor del string de todos los Documentos)
% Predicado: documentoToString(Documento, DocumentoString).
% Meta primaria: documentosToString
% Meta secundaria (no nativa): documentoToString
% Descripción: La regla permite la transformación de todos los datos tipos documento a string

documentosToString([], Acum, Acum).
documentosToString([Cabeza|Resto], Acum, DocumentosString):-
    documentoToString(Cabeza, DocumentoString),
    string_concat(DocumentoString, Acum, Aux),
    documentosToString(Resto, Aux, DocumentosString).

% Dominio: Se emplea una lista contenedora de datos del tipo documento, un stringm un acumulador ("") y una variable (contenedor del string de todos los Documentos especificos)
% Predicado: extraer(Elemento, ListaDeElementos, Contenedor).
%            usuarioOcompartido(NombreUsuario, IDdocumento, ListaDeDocumentos, ListaDeAccesos).
%            documentoToString(Documento, DocumentoString).
% Meta primaria: documentosEspecificosToString
% Meta secundaria (no nativa): extraer
%                              usuarioOcompartido
%                              documentoToString
% Descripción: La regla permite la transformación de todos los datos tipos documento con usuario propietario o compartido a string

documentosEspecificosToString([], _, Acum, Acum).
documentosEspecificosToString([Cabeza|Resto], NombreUsuario, Acum, DocumentosString):-
    extraer([IDdocumento, _, _, _, _, ListaAccesos], [Cabeza], _), 
    usuarioOcompartido(NombreUsuario, IDdocumento, [Cabeza], ListaAccesos),
    documentoToString(Cabeza, DocumentoString),
	string_concat(DocumentoString, Acum, Aux),
    documentosEspecificosToString(Resto, NombreUsuario, Aux, DocumentosString);
    documentosEspecificosToString(Resto, NombreUsuario, Acum, DocumentosString).

% TDA versiones
% Representación: [integer, date, string]
%                 [IDversion, FechaCreacion, Contenido]
% Dominio: Se emplea un valor entero, dato tipo fecha, un string y una variable (contenedor Version)
% Predicado: date(Dia, Mes, Anio, Fecha).
% Meta primaria: version
% Meta secundaria (no nativa): date
% Descripción: La regla permite realizar operaciones (constructor, pertenencia y selección) sobre un tipo de ...
%              ...dato version            

version(IDversion, [DD, MM, YYYY], Contenido, [IDversion, [DD, MM, YYYY], Contenido]):-
    integer(IDversion),
    date(_, _, _, [DD, MM, YYYY]),
    string(Contenido).

% Como constructor
% version(0, [14, 12, 2021], "Primer contenido del Doc", PrimeraVersionDoc).
% Como pertenencia
% version(_, _, _, [0, [14, 12, 2021], "Primer contenido del Doc"]).
% Como selector
% version(_, _, Contenido, [0, [14, 12, 2021], "Primer contenido del Doc"]).

% Dominio: Se emplea un dato del tipo version (a cambiar), un enterio (ID) y una variable (contenedor del nuevo dato tipo Version)
% Predicado: version(Version, NuevaVersion).
% Meta primaria: modificarIDversion
% Meta secundaria (no nativa): version
% Descripción: La regla permite la modificación del ID de un datos tipos Version

modificarIDversion(VersionAntigua, IDnuevo, VersionNueva):-
    version(_, Fecha, Contenido, VersionAntigua),
    version(IDnuevo, Fecha, Contenido, VersionNueva).

% Como modificador
% modificarIDversion([3, [14, 12, 2021], "Primer contenido del Doc"], 0, NuevaVersion).

% Dominio: Se emplea el tipo de dato version y una variable (contenedor del string Version)
% Predicado: fechaToString(Fecha, FechaString).
% Meta primaria: versionToString
% Meta secundaria (no nativa): fechaToString
% Descripción: La regla permite la transformación de un dato tipo version a string

versionToString([], "").
versionToString([IDversion, [DD, MM, YYYY], Contenido], VersionString):-
    number_string(IDversion, IDversionString),
    fechaToString([DD, MM, YYYY], FechaString),
    atomics_to_string(["Nro. Version: ", IDversionString, '\n',
                      "Fecha de creacion: ", FechaString, '\n',
                      "Contenido: ", Contenido, '\n'], VersionString).

% Ejemplo:
% version(0, [14, 12, 2021], "Primer contenido del Doc", PrimeraVersionDoc), versionToString(PrimeraVersionDoc, VersionString).

% Dominio: Se emplea una lista contenedora de datos del tipo version, un acumulador ("") y una variable (contenedor del string de todas las Versiones)
% Predicado: versionToString(Version, VersionString).
% Meta primaria: versionesToString
% Meta secundaria (no nativa): versionToString
% Descripción: La regla permite la transformación de todos los datos tipos version a string

versionesToString([], Acum, Acum).
versionesToString([Cabeza|Resto], Acum, VersionesString):-
    versionToString(Cabeza, VersionString),
    string_concat(VersionString, Acum, Aux),
    versionesToString(Resto, Aux, VersionesString).
    
% Ejemplo:
% versionesToString([[0, [19, 12, 2021], "Este es el tercer texto y/o contenido"], [1, [19, 12, 2021], "Este es el segundo texto y/o contenido"], [2, [1, 12, 2021], "hola mundo, este es el contenido de un archivo"]], "", VersionesString).




% Requerimientos Funcionales




% paradigmaDocsRegister
% Dominio: Se emplea un tipo de dato paradigmaDocs, tipo de dato fecha, dos strings y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            usuario(Usuario, NuevoUsuario).
%            exist(Elemento, ListaDeElementos).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
% Meta primaria: paradigmaDocsRegister
% Meta secundaria (no nativa): paradigmaDocs
%                              usuario
%                              exist
%                              insertarAlPrincipio
% Descripción: La regla permite registrar a un usuario nuevo a la plataforma por medio de una inserción de dicho usuario a la lista u espacio...
%              ... destinado para este tipo de datos (ListaUsuarios), verificando la no existencia del nombre de usuario a registrar validando...
%              ... así su correcto registro en la plataforma. Es importante comentar que en caso de que el nombre de usuario del usuario a...
%              ... registrar ya exista, se retornará false

paradigmaDocsRegister(ParadigmaDocs, [DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, ActParadigmaDocs):-
    paradigmaDocs(_, _, ListaUsuarios, _, ParadigmaDocs),
    usuario([DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, 0, USUARIO),
    not(exist([_, NombreUsuario, _, _], ListaUsuarios)),
    insertarAlPrincipio(USUARIO, ListaUsuarios, ActListaUsuarios),
    paradigmaDocs(NombrePlataforma, FechaCreacion, _, ListaDocumentos, ParadigmaDocs),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ActListaUsuarios, ListaDocumentos, ActParadigmaDocs).

% Ejemplo 1:
/* 
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6).
*/
% Ejemplo 2 (registrar un usuario con nombre de usuario ya registrado -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6),
paradigmaDocsRegister(PD6, D2, "Jaime Loyola", "Ya existe el este nombre de usuario", PD7).
*/
% Ejemplo 3 (La salida de paradigmaDocs corresponde a la salida correcta, es decir, existe y es validada en el proceso):
/*
paradigmaDocsRegister(["Google docs", [25, 12, 2021], [[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Benjamin Navarro", "naarro", 0],
[[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]], []], [23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio",
["Google docs", [25, 12, 2021], [[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0],
[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0], [[23, 12, 2021], "Catalina Vergara", "cale", 0],
[[24, 12, 2021], "Benjamin Navarro", "naarro", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]], []]).
*/












% paradigmaDocsLogin
% Dominio: Se emplea un tipo de dato paradigmaDocs, dos strings y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            exist(Elemento, ListaDeElementos).
%            extraer(Elemento, ListaDeElementos, Contenedor).
%            usuario(Usuario, NuevoUsuario).
%            borrarElemento(Elemento, ListaDeElementos, ListaAct).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
% Meta primaria: paradigmaDocsRegister
% Meta secundaria (no nativa): paradigmaDocs
%                              exist
%                              extraer
%                              usuario
%                              borrarElemento
%                              insertarAlPrincipio
% Descripción: La regla permite autenticar a un usuario ya registrado en la plataforma verificando su...
%              ... existencia en la plataforma y la correcta entrega de credenciales de acceso retornando...
%              ... la plataforma actualizada en caso de ser válida la autenticación y false como caso contrario

paradigmaDocsLogin(ParadigmaDocs, NombreUsuario, ContraseniaUsuario, ActParadigmaDocs):-
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, NombreUsuario, ContraseniaUsuario, _], ListaUsuarios),
	extraer([_, NombreUsuario, ContraseniaUsuario, _], ListaUsuarios, USUARIO),
    usuario(FechaUsuario, _, _, _, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
	usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 1, ACTUSUARIO),
    insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentos, ActParadigmaDocs).

% Ejemplo 1:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7).
*/
% Ejemplo 2 (contraseña incorrecta -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6),
paradigmaDocsLogin(PD6, "Benjamin Navarro", "contrasenia incorrecta", PD7).
*/
% Ejemplo 3 (La salida de paradigmaDocs corresponde a la salida correcta, es decir, existe y es validada en el proceso):
/*
paradigmaDocsLogin(["Google docs", [25, 12, 2021], [[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0],
[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0], [[23, 12, 2021], "Catalina Vergara", "cale", 0],
[[24, 12, 2021], "Benjamin Navarro", "naarro", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]], []],
"Benjamin Navarro", "naarro",
["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 1],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]], []]).
*/






% paradigmaDocsCreate
% Dominio: Se emplea un tipo de dato paradigmaDocs, tipo de dato fecha, dos strings y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            exist(Elemento, ListaDeElementos).
%            extraer(Elemento, ListaDeElementos, Contenedor).
%            borrarElemento(Elemento, ListaDeElementos, ListaAct).
%            usuario(Usuario, NuevoUsuario).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
%            largoLista(Lista, Largo).
%            documento(Documento, ContenedorDocumento).
%            version(Version, ContenedorVersion).
%            insertarAlFinal(Elemento, ListaDeElementos, ListaFinal).
% Meta primaria: paradigmaDocsCreate
% Meta secundaria (no nativa): paradigmaDocs
%                              exist
%                              extraer
%                              borrarElemento
%                              usuario
%                              insertarAlPrincipio
%                              largoLista
%                              documento
%                              version
%                              insertarAlFinal
% Descripción: La regla permite a un usuario autenticado en la plataforma crear un documento el cual refleja...
%              ... y/o registra su identificador unico, nombre de documento, autor, fecha de creación, lista...
%              ... o zona de versiones con la primera ya creada de acuerdo al contenido inicial ingresado....
%              ... En este sentido, de autenticarse correctamente el usuario y recibir los argumentos correctos...
%              ... se retornará la actualización de la plataforma, caso contrario retornará false

paradigmaDocsCreate(ParadigmaDocs, FechaCreacionDocumento, NombreDocumento, ContenidoDocumento, ActParadigmaDocs):-
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, _, _, 1], ListaUsuarios),
    extraer([FechaUsuario, NombreUsuario, ContraseniaUsuario, 1], ListaUsuarios, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
    usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 0, ACTUSUARIO),
    insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    largoLista(ListaDocumentos, IDdocumento),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, [], [], Documento),
    documento(_, _, _, _, ListaVersiones, _, Documento),
    version(0, FechaCreacionDocumento, ContenidoDocumento, PrimeraVersion),
    insertarAlFinal(PrimeraVersion, ListaVersiones, NuevaListaVersiones),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, NuevaListaVersiones, [], DocumentoFinal),
    insertarAlPrincipio(DocumentoFinal, ListaDocumentos, ListaDocumentosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentosFinal, ActParadigmaDocs).


% Ejemplo 1:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12).
*/
% Ejemplo 2 (no hay sesión activa -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8).
*/
% Ejemplo 3 (La salida de paradigmaDocs corresponde a la salida correcta, es decir, existe y es validada en el proceso):
/*
paradigmaDocsCreate(["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 1],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]], []],
[23, 12, 2021], "Documento 0", "Primer contenido del Documento con ID 0",
["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 0],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"]], []]]]).
*/













% paradigmaDocsShare
% Dominio: Se emplea un tipo de dato paradigmaDocs, un entero, dos listas y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            exist(Elemento, ListaDeElementos).
%            extraer(Elemento, ListaDeElementos, Contenedor).
%            borrarElemento(Elemento, ListaDeElementos, ListaAct).
%            usuario(Usuario, NuevoUsuario).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
%            productoLista(ListaDeListas, ContenedorProducto).
%            concatenar(Lista1, Lista2, ListaConcatenada).
%            documento(Documento, ContenedorDocumento).
% Meta primaria: paradigmaDocsShare
% Meta secundaria (no nativa): paradigmaDocs
%                              exist
%                              extraer
%                              borrarElemento
%                              usuario
%                              insertarAlPrincipio
%                              productoLista
%                              concatenar
%                              documento
% Descripción: La regla permite a un usuario autenticado en la plataforma compartir un documento especifico...
%              ... a cualquier usuario con determinados accesos al mismo ("W", "L" y "C" como escritura, ...
%              ... lectura y comentar respectivamente) siempre y cuando el documento a compartir sea de la...
%              ... propiedad del usuario autenticado. Es importante comentar que si bien el usuario puede...
%              ... ingresar nombres de usuario a compartir no registrados en la plataforma, para cualquier...
%              ... validación dichos nombres serán evaluados para determinar si se encuentran en calidad...
%              ... de ejecutar operaciones de acuerdo a su autentificación, del mismo modo sucede con los...
%              ... accesos y/o permisos los cuales son evaluados de acuerdo con determinadas operaciones

paradigmaDocsShare(ParadigmaDocs, IDdocumento, ListaPermisos, ListaUsuariosCompartidos, ActParadigmaDocs):-
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, _, _, 1], ListaUsuarios),
    extraer([FechaUsuario, NombreUsuario, ContraseniaUsuario, 1], ListaUsuarios, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
	usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 0, ACTUSUARIO),
	insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    exist([IDdocumento, _, NombreUsuario, _, _, _], ListaDocumentos),
    extraer([IDdocumento, NombreDocumento, _, FechaCreacionDocumento, ListaVersiones, ListaAccesos], ListaDocumentos, Documento),
    productoLista([ListaUsuariosCompartidos, ListaPermisos], ListaCompartidos),
    concatenar(ListaCompartidos, ListaAccesos, ListaAccesosFinal),
    borrarElemento(Documento, ListaDocumentos, ActListaDocumentos),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, ListaVersiones, ListaAccesosFinal, DocumentoFinal),
    insertarAlPrincipio(DocumentoFinal, ActListaDocumentos, ListaDocumentosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentosFinal, ActParadigmaDocs).

% Ejemplo 1:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16).
*/
% Ejemplo 2 (no hay sesión activa -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsShare(PD12, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD13).
*/
% Ejemplo 3 (La salida de paradigmaDocs corresponde a la salida correcta, es decir, existe y es validada en el proceso):
/*
paradigmaDocsShare( ["Google docs", [25, 12, 2021], [[[23, 12, 2021], "Catalina Vergara", "cale", 0],
[[24, 12, 2021], "Benjamin Navarro", "naarro", 1], [[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0],
[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"]], []]]],
0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], 
["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 0],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0],
[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"]],
[["Aranzazu Huerta", "R"], ["Aranzazu Huerta", "W"], ["Aranzazu Huerta", "C"], ["Gonzalo Marambio", "R"],
["Gonzalo Marambio", "W"], ["Gonzalo Marambio", "C"]]]]]).
*/











% paradigmaDocsAdd
% Dominio: Se emplea un tipo de dato paradigmaDocs, un entero, un tipo de dato fecha, un string y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            exist(Elemento, ListaDeElementos).
%            extraer(Elemento, ListaDeElementos, Contenedor).
%            borrarElemento(Elemento, ListaDeElementos, ListaAct).
%            usuario(Usuario, NuevoUsuario).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
%            usuarioOcompartidoEditar(NombreUsuario, IDdocumento, ListaDocumentos, ListaAccesos).
%            largoLista(Lista, Largo).
%            version(Version, ContenedorVersion).
%            insertarAlFinal(Elemento, ListaDeElementos, ListaFinal).
%            documento(Documento, ContenedorDocumento).
% Meta primaria: paradigmaDocsAdd
% Meta secundaria (no nativa): paradigmaDocs
%                              exist
%                              extraer
%                              borrarElemento
%                              usuario
%                              insertarAlPrincipio
%                              usuarioOcompartidoEditar
%                              largoLista
%                              version
%                              insertarAlFinal
%                              documento
% Descripción: La regla permite a un usuario autenticado en la plataforma agregar un contenido al final...
%              ... de la ultima version activa de un documento en el cual figure dicho usuario como autor...
%              ... o este posea permisos de escritura sobre el documento seleccionado

paradigmaDocsAdd(ParadigmaDocs, IDdocumento, Fecha, ContenidoTexto, ActParadigmaDocs):-
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, _, _, 1], ListaUsuarios),
    extraer([FechaUsuario, NombreUsuario, ContraseniaUsuario, 1], ListaUsuarios, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
	usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 0, ACTUSUARIO),
	insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    extraer([IDdocumento, NombreDocumento, _, FechaCreacionDocumento, ListaVersiones, ListaAccesos], ListaDocumentos, Documento),
    usuarioOcompartidoEditar(NombreUsuario, IDdocumento, ListaDocumentos, ListaAccesos),
    largoLista(ListaVersiones, IDversion),
    IDversionAnterior is IDversion - 1,
    extraer([IDversionAnterior, _, ContenidoAnterior], ListaVersiones, _),
    string_concat(ContenidoAnterior, ContenidoTexto, ContenidoActual),
    version(IDversion, Fecha, ContenidoActual, NuevaVersion),
    insertarAlFinal(NuevaVersion, ListaVersiones, NuevaListaVersiones),
    borrarElemento(Documento, ListaDocumentos, ActListaDocumentos),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, NuevaListaVersiones, ListaAccesos, DocumentoFinal),
    insertarAlPrincipio(DocumentoFinal, ActListaDocumentos, ListaDocumentosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentosFinal, ActParadigmaDocs).

% Ejemplo 1:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), 
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16),
paradigmaDocsLogin(PD16, "Benjamin Navarro", "naarro", PD17),
paradigmaDocsAdd(PD17, 0, [25, 12, 2021], ". Segundo contenido del Documento con ID 0.", PD18),
paradigmaDocsLogin(PD18, "Catalina Vergara", "cale", PD19),
paradigmaDocsAdd(PD19, 1, [25, 12, 2021], ". Segundo contenido del Documento con ID 1.", PD20),
paradigmaDocsLogin(PD20, "Benjamin Navarro", "naarro", PD21),
paradigmaDocsAdd(PD21, 0, [25, 12, 2021], " Tercer contenido del Documento con ID 0.", PD22).
*/
% Ejemplo 2 (usuario no autorizado (ni autor ni compartido) quiere realizar un cambio sobre un documento -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3),
paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2),
paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4),
paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6),
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16),
paradigmaDocsLogin(PD16, "Jaime Loyola", "pinturaseca123", PD17),
paradigmaDocsAdd(PD17, 0, [25, 12, 2021], ". Segundo contenido del Documento con ID 0.", PD18).
*/
% Ejemplo 3 (La salida de paradigmaDocs corresponde a la salida correcta, es decir, existe y es validada en el proceso):
/*
paradigmaDocsAdd(["Google docs", [25, 12, 2021], [[[23, 12, 2021], "Catalina Vergara", "cale", 0],
[[24, 12, 2021], "Benjamin Navarro", "naarro", 1], [[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0],
[[23, 12, 2021], "Aranzazu Huerta", "SUS", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"]], []]]],
0, [23, 12, 2021], ". Segundo contenido del Documento con ID 0.",
["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 0], [[23, 12, 2021], "Catalina Vergara", "cale", 0],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0],
[[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"],
[1, [23, 12, 2021], "Primer contenido del Documento con ID 0. Segundo contenido del Documento con ID 0."]], []]]]).
*/














% paradigmaDocsRestoreVersion
% Dominio: Se emplea un tipo de dato paradigmaDocs, dos enteros y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            exist(Elemento, ListaDeElementos).
%            extraer(Elemento, ListaDeElementos, Contenedor).
%            borrarElemento(Elemento, ListaDeElementos, ListaAct).
%            usuario(Usuario, NuevoUsuario).
%            insertarAlPrincipio(Elemento, ListaDeElementos, ListaFinal).
%            insertarAlFinal(Elemento, ListaDeElementos, ListaFinal).
%            correlativo(ListaVersiones, Acumulador, ContenedorListaVersionesCorrelativa).
%            documento(Documento, ContenedorDocumento).
% Meta primaria: paradigmaDocsRestoreVersion
% Meta secundaria (no nativa): paradigmaDocs
%                              exist
%                              extraer
%                              borrarElemento
%                              usuario
%                              insertarAlPrincipio
%                              insertarAlFinal
%                              correlativo
%                              documento
% Descripción: La regla permite a un usuario autenticado en la plataforma restaurar una versión existente de...
%              ... un determinado documento siempre y cuando este figure como su autor

paradigmaDocsRestoreVersion(ParadigmaDocs, IDdocumento, IDversion, ActParadigmaDocs):-
	paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, _, _, 1], ListaUsuarios),
    extraer([FechaUsuario, NombreUsuario, ContraseniaUsuario, 1], ListaUsuarios, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
	usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 0, ACTUSUARIO),
	insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    exist([IDdocumento, _, NombreUsuario, _, _, _], ListaDocumentos),
    extraer([IDdocumento, NombreDocumento, _, FechaCreacionDocumento, ListaVersiones, ListaAccesos], ListaDocumentos, Documento),    
	extraer([IDversion, _, _], ListaVersiones, VersionActual),
    borrarElemento(VersionActual, ListaVersiones, ActListaVersiones),
    insertarAlFinal(VersionActual, ActListaVersiones, NuevaActListaVersiones),
    correlativo(NuevaActListaVersiones, Acumulador, ListaVersionesInversa),
    correlativo(ListaVersionesInversa, Acumulador, ListaVersionesFinal),
    borrarElemento(Documento, ListaDocumentos, ActListaDocumentos),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, ListaVersionesFinal, ListaAccesos, ActDocumento),
	insertarAlPrincipio(ActDocumento, ActListaDocumentos, ListaDocumentosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentosFinal, ActParadigmaDocs).

% Ejemplo 1:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), 
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16),
paradigmaDocsLogin(PD16, "Benjamin Navarro", "naarro", PD17),
paradigmaDocsAdd(PD17, 0, [25, 12, 2021], ". Segundo contenido del Documento con ID 0.", PD18),
paradigmaDocsLogin(PD18, "Catalina Vergara", "cale", PD19),
paradigmaDocsAdd(PD19, 1, [25, 12, 2021], ". Segundo contenido del Documento con ID 1.", PD20),
paradigmaDocsLogin(PD20, "Benjamin Navarro", "naarro", PD21),
paradigmaDocsAdd(PD21, 0, [25, 12, 2021], " Tercer contenido del Documento con ID 0.", PD22),
paradigmaDocsLogin(PD22, "Benjamin Navarro", "naarro", PD23),
paradigmaDocsRestoreVersion(PD23, 0, 0, PD24).
*/
% Ejemplo 2 (usuario, más no autor, quiere restaurar una versión de un documento -> caso no válido):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2),date(23, 12, 2021, D3), 
paradigmaDocs("Google docs", D1, [], [], PD1), paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2),
paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3), paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4),
paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5), paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6),
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16),
paradigmaDocsLogin(PD16, "Benjamin Navarro", "naarro", PD17),
paradigmaDocsAdd(PD17, 0, [25, 12, 2021], ". Segundo contenido del Documento con ID 0.", PD18),
paradigmaDocsLogin(PD18, "Catalina Vergara", "cale", PD19),
paradigmaDocsAdd(PD19, 1, [25, 12, 2021], ". Segundo contenido del Documento con ID 1.", PD20),
paradigmaDocsLogin(PD20, "Benjamin Navarro", "naarro", PD21),
paradigmaDocsAdd(PD21, 0, [25, 12, 2021], " Tercer contenido del Documento con ID 0.", PD22),
paradigmaDocsLogin(PD22, "Catalina Vergara", "cale", PD23), paradigmaDocsRestoreVersion(PD23, 0, 0, PD24).
*/
% Ejemplo 3:
/*
paradigmaDocsRestoreVersion(["Google docs", [25, 12, 2021], [[[24, 12, 2021], "Benjamin Navarro", "naarro", 1],
[[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [23, 12, 2021], "Primer contenido del Documento con ID 0"],
[1, [25, 12, 2021], "Primer contenido del Documento con ID 0. Segundo contenido del Documento con ID 0."],
[2, [25, 12, 2021],
"Primer contenido del Documento con ID 0. Segundo contenido del Documento con ID 0. Tercer contenido del Documento con ID 0."]],
[["Aranzazu Huerta", "R"], ["Aranzazu Huerta", "W"], ["Aranzazu Huerta", "C"], ["Gonzalo Marambio", "R"], ["Gonzalo Marambio", "W"],
["Gonzalo Marambio", "C"]]], [1, "Documento 1", "Catalina Vergara", [24, 12, 2021], [[0, [24, 12, 2021],
"Primer contenido del Documento con ID 1"], [1, [25, 12, 2021],
"Primer contenido del Documento con ID 1. Segundo contenido del Documento con ID 1."]], [["Jaime Loyola", "W"],
["Jaime Loyola", "C"], ["Benjamin Navarro", "W"], ["Benjamin Navarro", "C"]]], [2, "Documento 2", "Jaime Loyola", [23, 12, 2021],
[[0, [23, 12, 2021], "Primer contenido del Documento con ID 2"]], []]]], 0, 0, ["Google docs", [25, 12, 2021], [[[24, 12, 2021],
"Benjamin Navarro", "naarro", 0], [[23, 12, 2021], "Catalina Vergara", "cale", 0], [[24, 12, 2021], "Jaime Loyola", "pinturaseca123", 0],
[[23, 12, 2021], "Gonzalo Marambio", "GonzalesMarimbio", 0], [[23, 12, 2021], "Aranzazu Huerta", "SUS", 0]],
[[0, "Documento 0", "Benjamin Navarro", [23, 12, 2021], [[0, [25, 12, 2021],
"Primer contenido del Documento con ID 0. Segundo contenido del Documento con ID 0."], [1, [25, 12, 2021],
"Primer contenido del Documento con ID 0. Segundo contenido del Documento con ID 0. Tercer contenido del Documento con ID 0."],
[2, [23, 12, 2021], "Primer contenido del Documento con ID 0"]], [["Aranzazu Huerta", "R"], ["Aranzazu Huerta", "W"],
["Aranzazu Huerta", "C"], ["Gonzalo Marambio", "R"], ["Gonzalo Marambio", "W"], ["Gonzalo Marambio", "C"]]],
[1, "Documento 1", "Catalina Vergara", [24, 12, 2021], [[0, [24, 12, 2021], "Primer contenido del Documento con ID 1"],
[1, [25, 12, 2021], "Primer contenido del Documento con ID 1. Segundo contenido del Documento con ID 1."]], [["Jaime Loyola", "W"],
["Jaime Loyola", "C"], ["Benjamin Navarro", "W"], ["Benjamin Navarro", "C"]]], [2, "Documento 2", "Jaime Loyola", [23, 12, 2021],
[[0, [23, 12, 2021], "Primer contenido del Documento con ID 2"]], []]]]).
*/










% paradigmaDocsToString
% Dominio: Se emplea un tipo de dato paradigmaDocs y una variable (contenedor de la plataforma a retornar)
% Predicado: paradigmaDocs(ParadigmaDocs, ActParadigmaDocs).
%            fechaToString(Elemento, ListaDeElementos).
%            usuariosToString(Elemento, ListaDeElementos, Contenedor).
%            documentosToString(Elemento, ListaDeElementos, ListaAct).
% Meta primaria: paradigmaDocsToString
% Meta secundaria (no nativa): paradigmaDocs
%                              fechaToString
%                              usuariosToString
%                              documentosToString
% Descripción: La regla permite, en caso de tener un usuario autenticado en la plataforma, retornar los...
%              ... datos de la misma considerando aspectos basicos de credencial y documentos que posea...
%              ... o le hayan sido compartidos. Por otra parte, de no haber usuario autenticado se retornará...
%              ... el contenido de la plataforma en su totalidad. El retorno en ambos casos contempla un unico...
%              ... string el cual al ser pasado como argumento a una función write o display retorne dicho string...
%              ... de forma que este pueda ser visualizado y comprendido por el usuario

paradigmaDocsToString([NombrePlataforma, [DD, MM, YYYY], ListaUsuarios, ListaDocumentos], ActParadigmaDocs):-
    exist([_, _, _, 1], ListaUsuarios),
    extraer([_, NombreUsuario, _, 1], ListaUsuarios, USUARIO),
    string_concat("Nombre plataforma: ", NombrePlataforma, NombrePlataformaString),
    fechaToString([DD, MM, YYYY], FechaString),
    usuarioToString(USUARIO, UsuarioString),
    documentosEspecificosToString(ListaDocumentos, NombreUsuario, "", DocumentosString),
    atomics_to_string([NombrePlataformaString, '\n',
                       "Fecha creación plataforma: ", FechaString, '\n',
                        UsuarioString, '\n',
                        DocumentosString, '\n'], ActParadigmaDocs), !;    
    string_concat("Nombre plataforma: ", NombrePlataforma, NombrePlataformaString),
    fechaToString([DD, MM, YYYY], FechaString),
    usuariosToString(ListaUsuarios, "", UsuariosString),
    documentosToString(ListaDocumentos, "", DocumentosString),
    atomics_to_string([NombrePlataformaString, '\n',
                       "Fecha creación plataforma: ", FechaString, '\n',
                        UsuariosString, '\n',
                        DocumentosString, '\n'], ActParadigmaDocs).

% Ejemplo 1 (Usuario No autenticado):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), 
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsShare(PD13, 0, ["R", "W", "C"], ["Aranzazu Huerta", "Gonzalo Marambio"], PD14),
paradigmaDocsLogin(PD14, "Catalina Vergara", "cale", PD15),
paradigmaDocsShare(PD15, 1, ["W", "C"], ["Jaime Loyola", "Benjamin Navarro"], PD16),
paradigmaDocsLogin(PD16, "Benjamin Navarro", "naarro", PD17),
paradigmaDocsAdd(PD17, 0, [25, 12, 2021], ". Segundo contenido del Documento con ID 0.", PD18),
paradigmaDocsLogin(PD18, "Catalina Vergara", "cale", PD19),
paradigmaDocsAdd(PD19, 1, [25, 12, 2021], ". Segundo contenido del Documento con ID 1.", PD20),
paradigmaDocsLogin(PD20, "Benjamin Navarro", "naarro", PD21),
paradigmaDocsAdd(PD21, 0, [25, 12, 2021], " Tercer contenido del Documento con ID 0.", PD22),
paradigmaDocsLogin(PD22, "Benjamin Navarro", "naarro", PD23),
paradigmaDocsRestoreVersion(PD23, 0, 0, PD24),
paradigmaDocsToString(PD24, PD25).
*/
% Ejemplo 2 (Usuario Autenticado):
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), 
paradigmaDocsLogin(PD6, "Benjamin Navarro", "naarro", PD7),
paradigmaDocsCreate(PD7, D3, "Documento 0", "Primer contenido del Documento con ID 0", PD8),
paradigmaDocsLogin(PD8, "Catalina Vergara", "cale", PD9),
paradigmaDocsCreate(PD9, D2, "Documento 1", "Primer contenido del Documento con ID 1", PD10),
paradigmaDocsLogin(PD10, "Jaime Loyola", "pinturaseca123", PD11),
paradigmaDocsCreate(PD11, D3, "Documento 2", "Primer contenido del Documento con ID 2", PD12),
paradigmaDocsLogin(PD12, "Benjamin Navarro", "naarro", PD13),
paradigmaDocsToString(PD13, PD14).
*/
% Ejemplo 3:
/*
date(25, 12, 2021, D1), date(24, 12, 2021, D2), date(23, 12, 2021, D3), paradigmaDocs("Google docs", D1, [], [], PD1),
paradigmaDocsRegister(PD1, D2, "Jaime Loyola", "pinturaseca123", PD2), paradigmaDocsRegister(PD2, D2, "Benjamin Navarro", "naarro", PD3),
paradigmaDocsRegister(PD3, D3, "Catalina Vergara", "cale", PD4), paradigmaDocsRegister(PD4, D3, "Aranzazu Huerta", "SUS", PD5),
paradigmaDocsRegister(PD5, D3, "Gonzalo Marambio", "GonzalesMarimbio", PD6), 
paradigmaDocsToString(PD6, PD7).
*/


    


% Otros Predicados

exist(Elemento, [Elemento|_]):-
    !.
exist(Elemento, [_|Resto]):-
    exist(Elemento, Resto).

insertarAlPrincipio(Elemento, [], [Elemento]):-
    !.
insertarAlPrincipio(Elemento, Lista, [Elemento|Lista]).

extraer(Elemento, [Elemento|_], Elemento):-
    !.
extraer(Elemento, [_|Resto], Elemento):-
    extraer(Elemento, Resto, Elemento).

borrarElemento(Elemento, [Elemento|Resto], Resto):-
    !.
borrarElemento(Elemento, [Cabeza|Resto], [Cabeza|Retorno]):-
    borrarElemento(Elemento, Resto, Retorno).

insertarAlFinal(Elemento, [], [Elemento]):-
    !.
insertarAlFinal(Elemento, [Cabeza|Resto], [Cabeza|Lista]):-
    insertarAlFinal(Elemento, Resto, Lista).

largoLista([], 0).
largoLista([_|Resto], Largo):-
    largoLista(Resto, LargoAcum),
    Largo is LargoAcum + 1.

% Si es una lista de un elemento...
% Ej: productoLista([["u1"]], Combinaciones).
productoLista([[Cabeza]], [[Cabeza]]):-
    !.
% Si es una lista de mas de un elemento...
% Ej: productoLista([["u1", "u5"]], Combinaciones).
productoLista([[Cabeza|Resto1]], [[Cabeza]|Resto2]) :- 
    productoLista([Resto1], Resto2),
    !.

% Si son mas de una lista de elementos...
% Ej: productoLista([["u1", "u5"], ["R", "W", "C"]], Combinaciones).
productoLista([Cabeza|Resto1], Resto2) :-
    productoLista(Resto1, R1),
    producto(Cabeza, R1, Resto2),
    !.

% Caso base, no hay nada listas que "multiplicar"
producto([], _, []):-
    !.
% Caso recursivo, hay elementos de listas que "multiplicar" con elementos de listas de listas
% Ej: producto(["u1", "u5"], [["R"], ["W"], ["C"]], Producto).
producto([Cabeza|Resto], ListadeListas, Acum) :-
    producto(Resto, ListadeListas, Lista),
    combinador(Cabeza, ListadeListas, Lista, Acum),
    !.
% Caso base, el primer elemento no puede "combinarse" con los elementos contenidos en la primera lista ya que no hay ninguno
% Ej: combinador("u5", [], [], Com).
combinador(_, [], Lista, Lista):-
    !.
% Caso recursivo, el primer elemento puede ser "combinado" aun con los elementos de la lista de listas
% combinador("u5", [["R"], ["W"], ["C"]], [], Com).
combinador(Elemento, [Cabeza1|Resto1], Lista, [[Elemento|Cabeza1]|Resto2]) :-
    combinador(Elemento, Resto1, Lista, Resto2),
    !.
    
concatenar([], Lista, Lista).
concatenar([Cabeza|Resto], Lista, [Cabeza|ListaFinal]):-
    concatenar(Resto, Lista, ListaFinal).

correlativo([], Acum, Acum).
correlativo([Cabeza|Resto], Acum, VersionCorrelativa):-
    largoLista(Resto, IDversion),
    modificarIDversion(Cabeza, IDversion, Act),
    insertarAlPrincipio(Act, Acum, V),
    correlativo(Resto, V, VersionCorrelativa).
% Ej: correlativo([[100, [1, 12, 2021], "hola mundo, este es el contenido de un archivo"], [200, [19, 12, 2021], "Este es el segundo texto y/o contenido"], [300, [19, 12, 2021], "Este es el tercer texto y/o contenido"]], Acumulador, VersionesCorrelativas).


usuarioOcompartidoEditar(Usuario, IDdocumento, ListaDocumentos, ListaAccesos):-
    exist([IDdocumento, _, Usuario, _, _, _], ListaDocumentos),
    !;
    exist([Usuario, "W"], ListaAccesos),
    !.

accesoToString([], "").
accesoToString([Usuario, Acceso], AccesoString):-
    atomics_to_string(["Usuario Compartido: ", Usuario, " - ", "Acceso: ", Acceso, '\n'], AccesoString).

% Ejemplo:
% accesoToString(["crios", "W"], AccesoString).

accesosToString([], Acum, Acum).
accesosToString([Cabeza|Resto], Acum, AccesosString):-
    accesoToString(Cabeza, AccesoString),
    string_concat(AccesoString, Acum, Aux),
    accesosToString(Resto, Aux, AccesosString).

% Ejemplo:
% accesosToString([["crios", "W"], ["crios", "R"]], "", AccesosString).

usuarioOcompartido(Usuario, IDdocumento, ListaDocumentos, ListaAccesos):-
    exist([IDdocumento, _, Usuario, _, _, _], ListaDocumentos),
    !;
    exist([Usuario, _], ListaAccesos),
    !.