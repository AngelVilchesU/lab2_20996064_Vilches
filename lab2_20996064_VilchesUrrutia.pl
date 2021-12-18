% Representación de la plataforma/paradigmadocs
% Representación: [NombrePlataforma FechaCreación [TDAusuarios] [TDAdocumentos]]
%                 [ string, date, [ [date, string, string, integer] [...] ], [ [integer, string, date [ [integer date string] [...] ] [ [string access] [...] ] [...] ] ]
% TDA usuarios: [date, string, string, integer]
% TDA documentos: [integer, string, date [ [TDA versiones] [...] ] [ [string access] [...] ]
% TDA versiones: [integer date string]
%
% TDA Fecha
% Representación: [DD MM YYYY]
%                 [integer, integer, integer]
% Predicado de pertenencia
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

% TDA paradigmadocs
% Constructor paradigmadocs
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
% Constructor usuario
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

% TDA documento
% Constructor documento
documento(IDdocumento, NombreDocumento, Autor, [DD, MM, YYYY], ListaVersiones, ListaAccesos, [IDdocumento, Autor, NombreDocumento, [DD, MM, YYYY], ListaVersiones, ListaAccesos]):-
    integer(IDdocumento),
    string(NombreDocumento),
    string(Autor),
    date(_, _, _, [DD, MM, YYYY]).

% Como constructor
% documento(0, "Doc1", "USER1", [14, 12, 2021], [], [], Documento1).

% Como pertenencia
% documento(_, _, _, _, _, _, [0, "USER1", "Doc1", [14, 12, 2021], [[0, [14, 12, 2021], "PRIMER CONTENIDO DOC1"]], []]).

% Como selector
% documento(_, NombreDocumento, _, _, _, _, [0, "USER1", "Doc1", [14, 12, 2021], [[0, [14, 12, 2021], "PRIMER CONTENIDO DOC1"]], []]).

% TDA versiones
% Constructor version
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

% paradigmaDocsRegister

paradigmaDocsRegister(ParadigmaDocs, [DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, ActParadigmaDocs):-
    paradigmaDocs(_, _, ListaUsuarios, _, ParadigmaDocs),
    usuario([DD, MM, YYYY], NombreUsuario, ContraseniaUsuario, 0, USUARIO),
    not(exist(USUARIO, ListaUsuarios)),
    insertarAlPrincipio(USUARIO, ListaUsuarios, ActListaUsuarios),
    paradigmaDocs(NombrePlataforma, FechaCreacion, _, ListaDocumentos, ParadigmaDocs),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ActListaUsuarios, ListaDocumentos, ActParadigmaDocs).

% Ejemplo 1:
% paradigmaDocsRegister(["paradigmaDocs", [12, 10, 2002], [], []], [14, 12, 2021], "USER1", "PASS1", ActParadigmaDocs).
% Ejemplo 2:
% paradigmaDocsRegister(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 0]], []], [14, 12, 2021], "USER1", "PASS1", ActParadigmaDocs).
% Ejemplo 3:
% date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmaDocs("google docs", D1, [], [], PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).


% paradigmaDocsLogin

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
% paradigmaDocsLogin(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 0]], []], "USER1", "PASS1", ActParadigmaDocs).
% Ejemplo 2:
% paradigmaDocsLogin(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 0], [[14, 12, 2021], "USER2", "PASS2", 0]], []], "USER2", "PASSFALSE", ActParadigmaDocs).
% Ejemplo 3:
% paradigmaDocsLogin(["google docs", [20, 12, 2015], [[[3, 12, 2021], "alopez", "asdfg", 0], [[1, 12, 2021], "crios", "qwert", 0], [[1, 12, 2021], "vflores", "hola123", 0]], []], "vflores", "hola123", ActParadigmaDocs).

% paradigmaDocsCreate

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
% paradigmaDocsCreate(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 1]], []], [17, 12, 2021], "Doc1", "Primer Contenido Doc 1", ActParadigmaDocs).
% Ejemplo 2:
% paradigmaDocsCreate(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 1]], [[0, "USER1", "Doc1", [17, 12, 2021], [[0, [17, 12, 2021], "Primer Contenido Doc 1"]], []]]], [17, 12, 2021], "Doc2", "Primer Contenido Doc 2", ActParadigmaDocs).
% Ejemplo 3:
% date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmaDocs("google docs", D1, [],[], PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4), paradigmaDocsLogin(PD4, "vflores", "hola123", PD5), paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es el contenido de un archivo", PD6).

% paradigmaDocsShare

paradigmaDocsShare(ParadigmaDocs, IDdocumento, ListaPermisos, ListaUsuariosCompartidos, ActParadigmaDocs):-
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuarios, ListaDocumentos, ParadigmaDocs),
    exist([_, _, _, 1], ListaUsuarios),
    extraer([FechaUsuario, NombreUsuario, ContraseniaUsuario, 1], ListaUsuarios, USUARIO),
    borrarElemento(USUARIO, ListaUsuarios, ActListaUsuarios),
	usuario(FechaUsuario, NombreUsuario, ContraseniaUsuario, 0, ACTUSUARIO),
	insertarAlPrincipio(ACTUSUARIO, ActListaUsuarios, ListaUsuariosFinal),
    exist([IDdocumento, NombreUsuario, _, _, _, _], ListaDocumentos),
    extraer([IDdocumento, _, NombreDocumento, FechaCreacionDocumento, ListaVersiones, ListaAccesos], ListaDocumentos, Documento),
    productoLista([ListaUsuariosCompartidos, ListaPermisos], ListaCompartidos),
    concatenar(ListaCompartidos, ListaAccesos, ListaAccesosFinal),
    borrarElemento(Documento, ListaDocumentos, ActListaDocumentos),
    documento(IDdocumento, NombreDocumento, NombreUsuario, FechaCreacionDocumento, ListaVersiones, ListaAccesosFinal, DocumentoFinal),
    insertarAlPrincipio(DocumentoFinal, ActListaDocumentos, ListaDocumentosFinal),
    paradigmaDocs(NombrePlataforma, FechaCreacion, ListaUsuariosFinal, ListaDocumentosFinal, ActParadigmaDocs).

% Ejemplo 1:
% paradigmaDocsShare(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 1], [[18, 12, 2021], "USER2", "PASS2", 0], [[18, 12, 2021], "USER3", "PASS3", 0]], [[0, "USER1", "Doc1", [17, 12, 2021], [[0, [17, 12, 2021], "Primer Contenido Doc 1"]], []]]], 0, ["R", "W", "C"], ["USER2", "USER3"], ActParadigmaDocs).
% Ejemplo 2:
% paradigmaDocsShare(["paradigmaDocs", [12, 10, 2002], [[[14, 12, 2021], "USER1", "PASS1", 1], [[18, 12, 2021], "USER2", "PASS2", 0], [[18, 12, 2021], "USER3", "PASS3", 0]], [[0, "USER1", "Doc1", [17, 12, 2021], [[0, [17, 12, 2021], "Primer Contenido Doc 1"]], []]]], 0, ["C"], ["USER3"], ActParadigmaDocs).
% Ejemplo 3:
% date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmaDocs("google docs", D1, [],[], PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4), paradigmaDocsLogin(PD4, "vflores", "hola123", PD5), paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es el contenido de un archivo", PD6), paradigmaDocsLogin(PD6, "vflores", "hola123", PD7), paradigmaDocsShare(PD7, 0, ["W", "R"], ["crios"], PD8).

















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