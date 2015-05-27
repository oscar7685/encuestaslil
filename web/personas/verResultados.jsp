<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <title>

            Cátedra Unesco para la Lectura y la Escritura

        </title>

        <!-- Bootstrap core CSS -->
        <link href="dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Documentation extras -->
        <link href="assets/css/docs.min.css" rel="stylesheet">
        <!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->    

        <!-- Favicons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="shortcut icon" href="assets/ico/favicon.ico">
        <style type="text/css">
            @media all {
                #insp{
                    line-height: 22px;
                }
            }
            body{
                font-size:14px;
                line-height: 18px;
            }
            body.dragging, body.dragging * {
                cursor: move !important;
            }

            .dragged {
                position: absolute;
                opacity: 0.5;
                z-index: 2000;
            }


        </style>
    </head>
    <!--<body style="background-image: url(assets/img/blue.jpg);background-repeat: repeat">-->
    <body>
        <div class="container bs-docs-container" style="padding:30px 100px;">
            <form class="form-horizontal" id="form_encuesta" method="post">
                <h1 style="font-size: 30px;font-weight: bold;margin-bottom: 5px;">${encuesta.getNombre()}</h1>
                <hr style="margin-top: 0px;"/>
                <div class="alert alert-info">
                    ${encuesta.getObjetivo()}
                </div>
                <br/>


                <div class="form-group">
                    <label for="facultad" class="col-sm-1 control-label">Facultad</label>
                    <div class="col-sm-4">
                        <input type="text"  class="form-control input-sm" disabled value="${personaje.programaIdprograma.facultadIdfacultad.facultad}"/>
                    </div>
                    <label for="programa" class="col-sm-2 control-label">Programa</label>
                    <div class="col-sm-5">
                        <input type="text"  class="form-control input-sm" disabled value="${personaje.programaIdprograma.programa}"/>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${encuesta.idencuesta==1}">
                        <div class="form-group">
                            <label for="nombre" class="col-sm-1 control-label">Docente</label>
                            <div class="col-sm-11">
                                <input type="text" class="form-control input-sm  required" id="nombre" placeholder="Nombre" name="nombre" value="${personaje.nombre}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="vinculacion" class="col-sm-1 control-label">Vinculaci&oacute;n</label>
                            <div class="col-sm-4">
                                <input type="text"  disabled value="${personaje.vinculacion}"/>
                            </div>
                            <label for="tiempo" class="col-sm-2 control-label">Tiempo de vinculaci&oacute;n</label>
                            <div class="col-sm-5">
                                <input type="text"  disabled value="${personaje.tiempo}"/>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${encuesta.idencuesta==2}">
                        <div class="form-group">
                            <label for="nombre" class="col-sm-1 control-label">Estudiante</label>
                            <div class="col-sm-11">
                                <input type="text" disabled class="form-control input-sm required" id="nombre"  value="${personaje.nombre}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="semestre" class="col-sm-1 control-label">Semestre</label>
                            <div class="col-sm-4">
                                <input type="text" disabled class="form-control input-sm required" id="nombre"  value="${personaje.semestre}"/>  
                            </div>
                            <label for="codigo" class="col-sm-2 control-label">Código estudiantil</label>
                            <div class="col-sm-5">
                                <input type="text" disabled class="form-control input-sm required" id="nombre"  value="${personaje.codigo}"/>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                <div class="form-group">
                    <label>&nbsp;</label>
                </div>

                <c:forEach items="${preguntas}" var="pregunta" varStatus="status">
                    <%--${resultadosxpregunta.get(status.index).size()}--%>
                    <c:choose>
                        <%--Pregunta seleccion multiple multiple respuesta SIN ordenamiento--%>
                        <c:when test="${pregunta.getTipo() == '6'}">
                            <c:choose>
                                <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                    <!--<div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                    <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row" id="pregunta${pregunta.idpregunta}">
                                        </c:otherwise>        
                                    </c:choose>

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>${pregunta.pregunta}</label>
                                            <c:forEach items="${pregunta.respuestaList}" var="respuesta" varStatus="st3">
                                                <div class="checkbox">
                                                    <label>
                                                        ${respuesta.respuesta}
                                                        <select name="respuesta${respuesta.idrespuesta}" class="required">
                                                            <option>${resultadosxpregunta.get(status.index).get(st3.index).valor}</option>
                                                        </select> 
                                                    </label>
                                                </div>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${pregunta.otro=='true'}">
                                                    <div class="checkbox">
                                                        <label>
                                                            ${pregunta.labelOtro}
                                                        </label>
                                                        <input type="text" name="preguntaOtro${pregunta.idpregunta}" class="required" disabled="disabled"/>
                                                    </div>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>     
                            </c:when>
                            <%--Pregunta seleccion multiple unica respuesta--%>            
                            <c:when test="${pregunta.getTipo() == '0'}">
                                <div class="row" id="pregunta${pregunta.idpregunta}">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>${pregunta.pregunta}</label>
                                            <c:choose>
                                                <c:when test="${resultadosxpregunta.get(status.index).size() > 0}" >
                                                    <c:forEach items="${pregunta.respuestaList}" var="respuesta" varStatus="s0">
                                                        <c:set var ="encontrado" value="0"></c:set>
                                                        <c:forEach items="${resultadosxpregunta.get(status.index)}" var="resultados0" varStatus="res">
                                                            <c:choose>
                                                                <c:when test="${resultados0.respuestaIdrespuesta!=null && resultados0.respuestaIdrespuesta.idrespuesta == respuesta.idrespuesta}">
                                                                    <div class="radio">
                                                                        <label>
                                                                            <input type="radio" value="${respuesta.idrespuesta}" checked>
                                                                            ${respuesta.respuesta}
                                                                        </label>
                                                                        <c:set var ="encontrado" value="1"></c:set>
                                                                        </div>
                                                                </c:when>
                                                            </c:choose> 
                                                        </c:forEach>   
                                                        <c:choose>
                                                            <c:when test="${encontrado == 0}">
                                                                <div class="radio">
                                                                    <label>
                                                                        <input type="radio" value="${respuesta.idrespuesta}">
                                                                        ${respuesta.respuesta}
                                                                    </label>
                                                                </div>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${pregunta.otro=='true'}">
                                                            <c:set var="encontradoOtro" value="0" ></c:set>
                                                            <c:forEach items="${resultadosxpregunta.get(status.index)}" var="resultados">
                                                                <c:choose>
                                                                    <c:when test="${resultados.valor != null}">
                                                                        <div class="radio">
                                                                            <label class="otroRadio">
                                                                                <input type="radio"  value="otro" checked>
                                                                                ${pregunta.labelOtro}
                                                                            </label>
                                                                            <input type="text"  class="form-control" disabled="disabled" value ="${resultados.valor}"/>
                                                                            <c:set var="encontradoOtro" value="1" ></c:set>
                                                                            </div>
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${encontradoOtro==0}">
                                                                    <div class="radio">
                                                                        <label class="otroRadio">
                                                                            <input type="radio"  value="otro" >
                                                                            ${pregunta.labelOtro}
                                                                        </label>
                                                                        <input type="text"  class="form-control" disabled="disabled"/>
                                                                    </div>                                                               
                                                                </c:when>
                                                            </c:choose>


                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${pregunta.respuestaList}" var="respuesta">
                                                        <div class="radio">
                                                            <label>
                                                                <c:choose>
                                                                    <c:when test="${resultados.respuestaIdrespuesta.idrespuesta == respuesta.idrespuesta}">
                                                                        <input type="radio" value="${respuesta.idrespuesta}" checked  class="required">
                                                                        ${respuesta.respuesta}
                                                                    </c:when>  
                                                                    <c:otherwise>
                                                                        <input type="radio" value="${respuesta.idrespuesta}" class="required">
                                                                        ${respuesta.respuesta}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${pregunta.otro=='true'}">
                                                            <div class="radio">
                                                                <label class="otroRadio">
                                                                    <input type="radio"  value="otro" id="otro${pregunta.idpregunta}" name="pregunta${pregunta.idpregunta}">
                                                                    ${pregunta.labelOtro}
                                                                </label>
                                                                <input type="text" name="preguntaOtro${pregunta.idpregunta}" class="required" disabled="disabled"/>
                                                            </div>

                                                        </c:when>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose> 
                                        </div>
                                    </div> 
                                </div>
                            </c:when>

                            <%--Pregunta SOLO ordenamiento--%>
                            <c:when test="${pregunta.getTipo() == '7'}">
                                <c:choose>
                                    <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                       <!-- <div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                        <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row" id="pregunta${pregunta.idpregunta}">
                                            </c:otherwise>        
                                        </c:choose>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>${pregunta.pregunta}</label>
                                                <c:forEach items="${pregunta.respuestaList}" var="respuesta" varStatus="stats2">
                                                    <div class="checkbox" style="padding-left: 0px;">
                                                        <label>
                                                            ${respuesta.respuesta}
                                                        </label>
                                                        <select name="ordenamiR${respuesta.idrespuesta}" id="ordenamiR${respuesta.idrespuesta}" class="required">
                                                            <option>${resultadosxpregunta.get(status.index).get(stats2.index).orden}</option>
                                                        </select>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div> 
                                    </div>
                                </c:when>

                                <%--Pregunta seleccion multiple multiple respuesta CON ordenamiento--%>            
                                <c:when test="${pregunta.getTipo() == '1'}">
                                    <c:choose>
                                        <c:when test="${fn:length(pregunta.condicionList1)>0 && pregunta.condicionList1[0].tipo=='MostrarSI'}">
                                           <!-- <div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                            <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                            </c:when>
                                            <c:otherwise>
                                                <div class="row" id="pregunta${pregunta.idpregunta}">
                                                </c:otherwise>        
                                            </c:choose>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label>${pregunta.pregunta}</label>
                                                    <c:forEach items="${resultadosxpregunta.get(status.index)}" var="resultados">
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" checked>
                                                                <c:choose>
                                                                    <c:when test="${resultados.respuestaIdrespuesta != null}">
                                                                        ${resultados.respuestaIdrespuesta.respuesta}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <b>${resultados.preguntaIdpregunta.labelOtro}: ${resultados.valor}</b>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </label>
                                                            <select disabled="disabled">
                                                                <option value="${resultados.orden}">${resultados.orden}</option>
                                                            </select>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div> 
                                        </div>
                                    </c:when>

                                    <%--Pregunta Abierta--%>
                                    <c:when test="${pregunta.getTipo() == '2'}">
                                        <c:choose>
                                            <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                                <!--<div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                                <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row" id="pregunta${pregunta.idpregunta}">
                                                    </c:otherwise>        
                                                </c:choose>
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label>${pregunta.pregunta}</label>
                                                        <input type="text" class="form-control required" style="width: 90% !important;" name="respuesta${pregunta.idpregunta}">
                                                    </div>
                                                </div>   
                                            </div>
                                        </c:when>
                                        <%--Pregunta Abierta--%>            
                                        <c:when test="${pregunta.getTipo() == '3'}">
                                            <c:choose>
                                                <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                                    <!-- <div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                                    <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="row" id="pregunta${pregunta.idpregunta}">
                                                        </c:otherwise>        
                                                    </c:choose>
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label>${pregunta.pregunta}</label>
                                                            <input type="text" class="form-control required" style="width: 90% !important;" name="respuesta${pregunta.idpregunta}" value="${resultadosxpregunta.get(status.index).get(0).valor}">
                                                        </div>
                                                    </div>   
                                                </div>
                                            </c:when>
                                            <%--Comentario--%>
                                            <c:when test="${pregunta.getTipo() == '5'}">
                                                <c:choose>
                                                    <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                                        <!--<div class="row hide" id="pregunta${pregunta.idpregunta}"> -->
                                                        <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="row" id="pregunta${pregunta.idpregunta}">
                                                            </c:otherwise>        
                                                        </c:choose>
                                                        <div class="col-md-12 alert alert-info">
                                                            ${pregunta.pregunta}
                                                        </div>  
                                                    </div>       
                                                </c:when>


                                                <%--Pregunta Abierta--%>
                                                <c:when test="${pregunta.getTipo() == '4'}">
                                                    <c:choose>
                                                        <c:when test="${fn:length(pregunta.condicionList1)>0}">
                                                            <%-- <div class="row hide" id="pregunta${pregunta.idpregunta}"> --%>
                                                            <div class="row" id="pregunta${pregunta.idpregunta}"> 
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="row" id="pregunta${pregunta.idpregunta}">
                                                                </c:otherwise>        
                                                            </c:choose>    
                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label>${pregunta.pregunta}</label>
                                                                    <c:choose>
                                                                        <c:when test="${resultadosxpregunta.get(status.index).size() != 0}">
                                                                            <textarea class="form-control required" style="width: 90% !important;" rows="4" name="respuesta${pregunta.idpregunta}">${resultadosxpregunta.get(status.index).get(0).valor}</textarea>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <textarea class="form-control" style="width: 90% !important;" rows="4" ></textarea>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </c:when>  

                                                    <c:when test="${pregunta.getTipo() == '9'}">
                                                        <c:choose>
                                                            <c:when test="${fn:length(pregunta.condicionList1)>0 && pregunta.condicionList1[0].tipo=='MostrarSI'}">
                                                                <%-- <div class="row hide" id="pregunta${pregunta.idpregunta}" > --%>
                                                                <div class="row" id="pregunta${pregunta.idpregunta}" > 
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="row" id="pregunta${pregunta.idpregunta}">
                                                                    </c:otherwise>        
                                                                </c:choose>
                                                                <c:choose>
                                                                    <c:when test="${fn:length(pregunta.condicionList)>0 && pregunta.condicionList[0].tipo=='MostrarSI'}">
                                                                        <div class="col-md-12 condicionador">
                                                                        </c:when>
                                                                        <c:when test="${fn:length(pregunta.condicionList)>0 && pregunta.condicionList[0].tipo=='OcultarSI'}">
                                                                            <div class="col-md-12 condicionador3">
                                                                            </c:when>    
                                                                            <c:otherwise>
                                                                                <div class="col-md-12">
                                                                                </c:otherwise>        
                                                                            </c:choose>

                                                                            <div class="form-group">
                                                                                <label>${pregunta.pregunta}</label>
                                                                                <select name="pregunta${pregunta.idpregunta}" class="required">
                                                                                    <option>
                                                                                        <c:choose>
                                                                                            <c:when test="${resultadosxpregunta.get(status.index).size() != 0}">
                                                                                                ${resultadosxpregunta.get(status.index).get(0).respuestaIdrespuesta.respuesta}

                                                                                            </c:when>
                                                                                        </c:choose>
                                                                                    </option>   
                                                                                </select>
                                                                                <c:choose>
                                                                                    <c:when test="${pregunta.otro=='true'}">
                                                                                        <div class="radio">
                                                                                            <label class="otroRadio">
                                                                                                <input type="radio"  value="otro" id="otro${pregunta.idpregunta}" name="pregunta${pregunta.idpregunta}">
                                                                                                ${pregunta.labelOtro}
                                                                                            </label>
                                                                                            <input type="text" name="preguntaOtro${pregunta.idpregunta}" class="required" disabled="disabled"/>
                                                                                        </div>

                                                                                    </c:when>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div> 
                                                                    </div>
                                                                </c:when>            


                                                            </c:choose>
                                                        </c:forEach>   

                                                        <div class="row">   
                                                            <button id="botonEnviar" class="btn btn-primary" data-content="Env&iacute;a la encuesta evaluada. Verifique que todas las preguntas han sido respondidas correctamente. Esta operación no se podrá deshacer."  value="1" data-original-title="Enviar encuesta" type="button">Enviar</button>
                                                        </div>

                                                        </form> 

                                                    </div>
                                                    <!-- Placed at the end of the document so the pages load faster -->
                                                    <!--<script type="text/javascript" src="http://code.jquery.com/jquery.min.js">-->
                                                    <script src = "https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

                                                    <script src="dist/js/bootstrap.min.js"></script>
                                                    <!--<script src='//code.jquery.com/ui/1.10.4/jquery-ui.js'></script>-->
                                                    <!--<script src="http://jqueryvalidation.org/files/dist/jquery.validate.js"></script>-->
                                                    <!--<script src="<%=request.getContextPath()%>/assets/js/jquery.metadata.js"></script>-->
                                                    <script src="dist/js/responder.js"></script>
                                                    </body>
                                                    </html>

                                                    <div class="modal fade" id="myModalGracias" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                    <h4 class="modal-title" id="myModalLabel">Gracias</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    La encuesta se ha enviado correctamente.
                                                                    Muchas gracias por participar del proceso.
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


