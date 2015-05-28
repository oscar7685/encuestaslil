<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Cátedra Unesco para la Lectura y la Escritura</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-touch-fullscreen" content="yes">
        <meta name="description" content="Avalon Admin Theme">
        <meta name="author" content="The Red Team">

        <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400italic,700' rel='stylesheet' type='text/css'>
        <style type="text/css">
            .morris-hover{position:absolute;z-index:1000;}
            .morris-hover.morris-default-style{border-radius:10px;padding:6px;color:#666;background:rgba(255, 255, 255, 0.8);border:solid 2px rgba(230, 230, 230, 0.8);font-family:sans-serif;font-size:12px;text-align:center;}
            .morris-hover.morris-default-style .morris-hover-row-label{font-weight:bold;margin:0.25em 0;}
            .morris-hover.morris-default-style .morris-hover-point{white-space:nowrap;margin:0.1em 0;} 
            #loader-img{
                margin: 0 auto;
                display: block;
            }
        </style>
        <!--[if lt IE 10]>
            <script src="assets/js/media.match.min.js"></script>
            <script src="assets/js/placeholder.min.js"></script>
        <![endif]-->

        <link href="assets/fonts/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet">        <!-- Font Awesome -->
        <link href="assets/css/styles.css" type="text/css" rel="stylesheet">                                     <!-- Core CSS with all styles -->

        <!-- <link href="assets/plugins/jstree/dist/themes/avalon/style.min.css" type="text/css" rel="stylesheet">    <!-- jsTree -->
        <!--<link href="assets/plugins/codeprettifier/prettify.css" type="text/css" rel="stylesheet">                <!-- Code Prettifier -->
        <!-- <link href="assets/plugins/iCheck/skins/minimal/blue.css" type="text/css" rel="stylesheet">              <!-- iCheck -->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries. Placeholdr.js enables the placeholder attribute -->
        <!--[if lt IE 9]>
            <link href="assets/css/ie8.css" type="text/css" rel="stylesheet">
            <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
            <script type="text/javascript" src="assets/plugins/charts-flot/excanvas.min.js"></script>
            <script type="text/javascript" src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- The following CSS are included as plugins and can be removed if unused-->

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script> 
        <script src="<%=request.getContextPath()%>/assets/js/highcharts.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/highcharts-more.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/exporting.js"></script>

    </head>

    <body class="infobar-offcanvas">

        <header id="topnav" class="navbar navbar-default navbar-fixed-top clearfix" role="banner">
            <div class="yamm navbar-left navbar-collapse collapse in">
                <ul class="nav navbar-nav">
                    <li><a href="<%=request.getContextPath()%>/"><strong>Inicio</strong></a></li>

                    <c:choose>
                        <c:when test="${fuente == '2'}">
                            <li>
                                <select class="form-control" style="margin-top: 10px" id="facultad">
                                    <option value="NA">Seleccione una facultad...</option>
                                    <c:forEach items="${facultades}" var="facultad" varStatus="fac">
                                        <option value="${facultad.idfacultad}">${facultad.facultad}</option>
                                    </c:forEach>    

                                </select>
                            </li>
                            <li>
                                <select class="form-control" style="margin-top: 10px" id="programa">
                                    <option value="NA">Seleccione un programa...</option>
                                </select>
                            </li>
                            <li>
                                <select id="semestre" class="form-control" name="semestre" style="margin-top: 10px">
                                    <option value="NA">Seleccione un semestre...</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </li>

                        </c:when>
                        <c:when test="${fuente == '1'}">
                            <li>
                                <select class="form-control" style="margin-top: 10px" id="facultad">
                                    <option value="NA">Seleccione una facultad...</option>
                                    <c:forEach items="${facultades}" var="facultad" varStatus="fac">
                                        <option value="${facultad.idfacultad}">${facultad.facultad}</option>
                                    </c:forEach>    

                                </select>
                            </li>
                            <li>
                                <select class="form-control" style="margin-top: 10px" id="programa">
                                    <option value="NA">Seleccione un programa...</option>
                                </select>
                            </li>
                            <li>
                                <select name="vinculacion" class="form-control " id="vinculacion" style="margin-top: 10px">
                                    <option value="NA">tipo de vinculacion..</option>
                                    <option value="Tiempo completo">Tiempo completo</option>
                                    <option value="Medio tiempo">Medio tiempo</option>
                                    <option value="Catedra">Cátedra</option>
                                </select>
                            </li>
                            <li>
                                <select name="tiempo" class="form-control" id="tiempo" style="margin-top: 10px">
                                    <option value="NA">Tiempo de vinculaci&oacute;n</option>
                                    <option value="menos1">Menos de un ańo</option>
                                    <option value="entre1y2">Entre 1 y 2 ańos</option>
                                    <option value="entre2y5">Entre 2 y 5 ańos</option>
                                    <option value="entre5y10">Entre 5 y 10 ańos</option>
                                    <option value="entre10y15">Entre 10 y 15 ańos</option>
                                    <option value="mas15">Más de 15 ańos</option>
                                </select>
                            </li>

                        </c:when>    

                    </c:choose>

                    <li>
                        <select name="area" class="form-control" id="area" style="margin-top: 10px">
                            <option value="NA">área de conocimiento..</option>
                            <option value="1">Humanidades y Arte</option>
                            <option value="2">Salud y servicios sociales</option>
                            <option value="3"> Ciencias Sociales, Educación Comercial y Derecho</option>
                            <option value="4">Ciencias</option>
                            <option value="5">Ingenierías, industria y construcción</option>
                        </select>
                    </li>

                </ul>

            </div>


        </header>

        <div id="wrapper">
            <div id="layout-static">
                <div class="static-content-wrapper">
                    <div class="static-content">
                        <div class="page-content">
                            <div class="page-heading">            
                                <h1>Informe por Pregunta</h1>
                            </div>
                            <div class="container-fluid">
                                <c:forEach items="${preguntas}" var="pregunta" varStatus="iter">
                                    <c:choose>
                                        <c:when test="${pregunta.getTipo() != '5'}">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h2>${pregunta.pregunta}</h2>
                                                        </div>
                                                        <div class="panel-body">
                                                            <div id="div${pregunta.idpregunta}">
                                                                <c:choose>
                                                                    <c:when test="${pregunta.getTipo() == '3' || pregunta.getTipo() == '4' || pregunta.getTipo() == '2'}">
                                                                        <c:forEach items="${RespuestasPreguntasAbiertas.get(iter.index)}" var="respuestaxx" varStatus="respuestaStatus">
                                                                            ${respuestaxx} ,
                                                                        </c:forEach>
                                                                    </c:when>
                                                                </c:choose>
                                                            </div>
                                                            <div id="di2v${pregunta.idpregunta}">

                                                            </div>
                                                            <div>
                                                                <c:choose>
                                                                    <c:when test="${pregunta.getTipo() == '1'}">
                                                                        <table class="table">
                                                                            <th>Respuesta/Orden</th>
                                                                                <c:set var="aux5" value="0"></c:set>
                                                                                <c:set var="auxheader" value="0"></c:set>
                                                                                <c:forEach items="${pregunta.respuestaList}" var="resf" varStatus="resStat">
                                                                                <th>${resStat.index + 1}</th>    
                                                                                    <c:set var="auxheader" value="${resStat.index}"></c:set>
                                                                                </c:forEach>
                                                                                <c:choose>
                                                                                    <c:when test="${pregunta.otro == 'true'}">
                                                                                    <th>${auxheader + 2}</th>        
                                                                                    </c:when>
                                                                                </c:choose>
                                                                                <c:forEach items="${pregunta.respuestaList}" var="respuesta" varStatus="iter2">
                                                                                <tr>
                                                                                    <td>${respuesta.respuesta}</td>

                                                                                    <c:set var="aux" value="0"></c:set>
                                                                                    <c:forEach items="${pregunta.respuestaList}" var="otra" varStatus="otraStatus">
                                                                                        <td> ${cantidadXOrdenXrespuestaXPregunta.get(iter.index).get(iter2.index).get(otraStatus.index)}</td>

                                                                                        <c:set var="aux" value="${otraStatus.index}"></c:set>
                                                                                    </c:forEach>    
                                                                                    <c:choose>
                                                                                        <c:when test="${pregunta.otro == 'true'}">
                                                                                            <td>  ${cantidadXOrdenXrespuestaXPregunta.get(iter.index).get(iter2.index).get(aux+1)} </td>
                                                                                        </c:when>
                                                                                    </c:choose>   
                                                                                </tr>           
                                                                                <c:set var="aux5" value="${iter2.index}"></c:set>
                                                                            </c:forEach>
                                                                            <c:choose>
                                                                                <c:when test="${pregunta.otro == 'true'}">
                                                                                    <tr>
                                                                                        <td>${pregunta.labelOtro}</td>
                                                                                        <c:set var="aux7" value="0"></c:set>
                                                                                        <c:forEach items="${pregunta.respuestaList}" var="otra2" varStatus="otraStatus2">
                                                                                            <td>${cantidadXOrdenXrespuestaXPregunta.get(iter.index).get(aux5+1).get(otraStatus2.index)}</td>
                                                                                            <c:set var="aux7" value="${otraStatus2.index}"></c:set>
                                                                                        </c:forEach>
                                                                                        <td>${cantidadXOrdenXrespuestaXPregunta.get(iter.index).get(aux5+1).get(aux7+1)}</td>
                                                                                    </tr>
                                                                                </c:when>
                                                                            </c:choose>
                                                                            No Personas: ${cantidadPersonasXpregunta.get(iter.index)}        
                                                                        </table>
                                                                    </c:when>
                                                                    <c:when test="${pregunta.getTipo() == '7'}">
                                                                        <table class="table">
                                                                            <thead>
                                                                            <th>Respuesta/Orden</th>

                                                                            <c:forEach items="${pregunta.respuestaList}" var="resf2" varStatus="resStat2">
                                                                                <th>${resStat2.index + 1}</th>    
                                                                                </c:forEach>
                                                                            </thead>
                                                                            <c:forEach items="${pregunta.respuestaList}" var="respuesta" varStatus="iter2">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>${respuesta.respuesta}</td>

                                                                                        <c:forEach items="${pregunta.respuestaList}" var="otra" varStatus="otraStatus">
                                                                                            <td>${cantidadXOrdenXrespuestaXPregunta.get(iter.index).get(iter2.index).get(otraStatus.index)}</td>
                                                                                        </c:forEach>    
                                                                                    </tr>
                                                                                </tbody>        
                                                                            </c:forEach>
                                                                        </table>   

                                                                        No Personas: ${cantidadPersonasXpregunta.get(iter.index)}
                                                                    </c:when> 
                                                                </c:choose>
                                                            </div>    
                                                        </div>
                                                    </div>
                                                </div>

                                            </div> 
                                        </c:when>
                                    </c:choose>


                                </c:forEach>



                            </div> <!-- .container-fluid -->
                        </div> <!-- #page-content -->
                    </div>
                    <footer role="contentinfo">
                        <div class="clearfix">
                            <ul class="list-unstyled list-inline pull-left">
                                <li><h6 style="margin: 0;"> &copy; 2014 Avalon</h6></li>
                            </ul>
                            <button class="pull-right btn btn-link btn-xs hidden-print" id="back-to-top"><i class="fa fa-arrow-up"></i></button>
                        </div>
                    </footer>
                </div>
            </div>



            <!--<script src="assets/js/jquery-1.10.2.min.js"></script> 							<!-- Load jQuery -->
            <!--<script src="assets/js/jqueryui-1.9.2.min.js"></script> 							<!-- Load jQueryUI -->
            <script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script> 				<!-- Load Bootstrap -->
            <!-- End loading page level scripts-->
           <!-- <script src="<%=request.getContextPath()%>/assets/plugins/sparklines/jquery.sparklines.min.js"></script>  	<!-- Sparkline -->
            <script src="<%=request.getContextPath()%>/assets/js/application2.js"></script>
            <script src="<%=request.getContextPath()%>/assets/js/raphael.min.js"></script> <!-- Load Raphael as Dependency -->
            <script src="<%=request.getContextPath()%>/assets/js/morris.min.js"></script>  <!-- Load Morris.js -->


            <script type="text/javascript">
                var datosTF1vsTF2, datos9, datos1, datos6, datos0, categorias0, series3, categorias3;
                $(function() {
                <c:forEach items="${preguntas}" var="pregunta" varStatus="iter">
                    <c:choose>
                        <c:when test="${pregunta.getTipo() == '0'}">
                    $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP2&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias0 = dat['0']["datos"]["0"]["categorias"];
                            datos0 = dat['0']["datos"]["0"]["series"];
                            var chart;
                            $(document).ready(function() {
                                chart = new Highcharts.Chart({
                                    chart: {
                                        renderTo: 'div${pregunta.idpregunta}',
                                        type: 'column',
                                        margin: [50, 30, 100, 50]
                                    },
                                    title: {
                                        text: '${pregunta.pregunta}'
                                    },
                                    xAxis: {
                                        categories: categorias0,
                                        labels: {
                                            style: {
                                                fontSize: '12px',
                                                fontFamily: 'Verdana, sans-serif'
                                            }
                                        }
                                    },
                                    yAxis: {
                                        title: {
                                            text: 'Cantidad por respuestas'
                                        }
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0,
                                            dataLabels: {
                                                enabled: true,
                                                color: "#4572A7",
                                                style: {
                                                    fontWeight: 'bold'
                                                },
                                                formatter: function() {
                                                    return this.y + '';
                                                }
                                            }
                                        }
                                    },
                                    legend: {
                                        enabled: false
                                    },
                                    series: [{
                                            name: 'repuestas',
                                            data: datos0

                                        }]
                                });
                            });
                        } //fin success
                    }); //fin del $.ajax


                    $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP3&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias3 = dat['0']["datos"];
                            
                            chart2 = new Highcharts.Chart({
                                chart: {
                                    renderTo: 'di2v${pregunta.idpregunta}',
                                    plotBackgroundColor: null,
                                    plotBorderWidth: null,
                                    plotShadow: false

                                },
                                title: {
                                    text: '${pregunta.pregunta}'
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '' +
                                                this.point.name + ': ' + this.y + ' ';
                                    }
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: true,
                                            color: '#000000',
                                            connectorColor: '#000000',
                                            formatter: function() {
                                                var igv = this.percentage;
                                                igv = igv.toFixed(2);
                                                return '<b>' + this.point.name + '</b>: ' + igv + ' %';
                                            }
                                        }
                                    }
                                },
                                series: [{
                                        type: 'pie',
                                        name: 'respuestas',
                                        data: categorias3
                                    }]


                            });
                        } //fin success
                    }); //fin del $.ajax

                        </c:when>
                        <c:when test="${pregunta.getTipo() == '9'}">
                    $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP2&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias0 = dat['0']["datos"]["0"]["categorias"];
                            datos0 = dat['0']["datos"]["0"]["series"];
                            var chart;
                            $(document).ready(function() {
                                chart = new Highcharts.Chart({
                                    chart: {
                                        renderTo: 'div${pregunta.idpregunta}',
                                        type: 'column',
                                        margin: [50, 30, 100, 50]
                                    },
                                    title: {
                                        text: '${pregunta.pregunta}'
                                    },
                                    xAxis: {
                                        categories: categorias0,
                                        labels: {
                                            style: {
                                                fontSize: '12px',
                                                fontFamily: 'Verdana, sans-serif'
                                            }
                                        }
                                    },
                                    yAxis: {
                                        title: {
                                            text: 'Cantidad por respuestas'
                                        }
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0,
                                            dataLabels: {
                                                enabled: true,
                                                color: "#4572A7",
                                                style: {
                                                    fontWeight: 'bold'
                                                },
                                                formatter: function() {
                                                    return this.y + '';
                                                }
                                            }
                                        }
                                    },
                                    legend: {
                                        enabled: false
                                    },
                                    series: [{
                                            name: 'repuestas',
                                            data: datos0

                                        }]
                                });
                            });
                        } //fin success
                    }); //fin del $.ajax
                    
                    $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP3&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias3 = dat['0']["datos"];
                            
                            chart2 = new Highcharts.Chart({
                                chart: {
                                    renderTo: 'di2v${pregunta.idpregunta}',
                                    plotBackgroundColor: null,
                                    plotBorderWidth: null,
                                    plotShadow: false

                                },
                                title: {
                                    text: '${pregunta.pregunta}'
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '' +
                                                this.point.name + ': ' + this.y + ' ';
                                    }
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: true,
                                            color: '#000000',
                                            connectorColor: '#000000',
                                            formatter: function() {
                                                var igv = this.percentage;
                                                igv = igv.toFixed(2);
                                                return '<b>' + this.point.name + '</b>: ' + igv + ' %';
                                            }
                                        }
                                    }
                                },
                                series: [{
                                        type: 'pie',
                                        name: 'respuestas',
                                        data: categorias3
                                    }]


                            });
                        } //fin success
                    }); //fin del $.ajax

                        </c:when>


                        <c:when test="${pregunta.getTipo() == '1'}">
                   $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP2&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias0 = dat['0']["datos"]["0"]["categorias"];
                            datos0 = dat['0']["datos"]["0"]["series"];
                            var chart;
                            $(document).ready(function() {
                                chart = new Highcharts.Chart({
                                    chart: {
                                        renderTo: 'div${pregunta.idpregunta}',
                                        type: 'column',
                                        margin: [50, 30, 100, 50]
                                    },
                                    title: {
                                        text: '${pregunta.pregunta}'
                                    },
                                    xAxis: {
                                        categories: categorias0,
                                        labels: {
                                            style: {
                                                fontSize: '12px',
                                                fontFamily: 'Verdana, sans-serif'
                                            }
                                        }
                                    },
                                    yAxis: {
                                        title: {
                                            text: 'Cantidad por respuestas'
                                        }
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0,
                                            dataLabels: {
                                                enabled: true,
                                                color: "#4572A7",
                                                style: {
                                                    fontWeight: 'bold'
                                                },
                                                formatter: function() {
                                                    return this.y + '';
                                                }
                                            }
                                        }
                                    },
                                    legend: {
                                        enabled: false
                                    },
                                    series: [{
                                            name: 'repuestas',
                                            data: datos0

                                        }]
                                });
                            });
                        } //fin success
                    }); //fin del $.ajax
					
					
					$.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP3&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias3 = dat['0']["datos"];
                            
                            chart2 = new Highcharts.Chart({
                                chart: {
                                    renderTo: 'di2v${pregunta.idpregunta}',
                                    plotBackgroundColor: null,
                                    plotBorderWidth: null,
                                    plotShadow: false

                                },
                                title: {
                                    text: '${pregunta.pregunta}'
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '' +
                                                this.point.name + ': ' + this.y + ' ';
                                    }
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: true,
                                            color: '#000000',
                                            connectorColor: '#000000',
                                            formatter: function() {
                                                var igv = this.percentage;
                                                igv = igv.toFixed(2);
                                                return '<b>' + this.point.name + '</b>: ' + igv + ' %';
                                            }
                                        }
                                    }
                                },
                                series: [{
                                        type: 'pie',
                                        name: 'respuestas',
                                        data: categorias3
                                    }]


                            });
                        } //fin success
                    }); //fin del $.ajax


                        </c:when>

                        <c:when test="${pregunta.getTipo() == '6'}">
                    $.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP2&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias0 = dat['0']["datos"]["0"]["categorias"];
                            datos0 = dat['0']["datos"]["0"]["series"];
                            var chart;
                            $(document).ready(function() {
                                chart = new Highcharts.Chart({
                                    chart: {
                                        renderTo: 'div${pregunta.idpregunta}',
                                        type: 'column',
                                        margin: [50, 30, 100, 50]
                                    },
                                    title: {
                                        text: '${pregunta.pregunta}'
                                    },
                                    xAxis: {
                                        categories: categorias0,
                                        labels: {
                                            style: {
                                                fontSize: '12px',
                                                fontFamily: 'Verdana, sans-serif'
                                            }
                                        }
                                    },
                                    yAxis: {
                                        title: {
                                            text: 'Cantidad por respuestas'
                                        }
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0,
                                            dataLabels: {
                                                enabled: true,
                                                color: "#4572A7",
                                                style: {
                                                    fontWeight: 'bold'
                                                },
                                                formatter: function() {
                                                    return this.y + '';
                                                }
                                            }
                                        }
                                    },
                                    legend: {
                                        enabled: false
                                    },
                                    series: [{
                                            name: 'repuestas',
                                            data: datos0

                                        }]
                                });
                            });
                        } //fin success
                    }); //fin del $.ajax
					
					
					$.ajax({
                        type: "POST",
                        url: 'Encuestas?accion=resultadosP3&preguntaid=${iter.index}',
                        dataType: 'json',
                        success: function(dat)
                        {
                            categorias3 = dat['0']["datos"];
                            
                            chart2 = new Highcharts.Chart({
                                chart: {
                                    renderTo: 'di2v${pregunta.idpregunta}',
                                    plotBackgroundColor: null,
                                    plotBorderWidth: null,
                                    plotShadow: false

                                },
                                title: {
                                    text: '${pregunta.pregunta}'
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '' +
                                                this.point.name + ': ' + this.y + ' ';
                                    }
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: true,
                                            color: '#000000',
                                            connectorColor: '#000000',
                                            formatter: function() {
                                                var igv = this.percentage;
                                                igv = igv.toFixed(2);
                                                return '<b>' + this.point.name + '</b>: ' + igv + ' %';
                                            }
                                        }
                                    }
                                },
                                series: [{
                                        type: 'pie',
                                        name: 'respuestas',
                                        data: categorias3
                                    }]


                            });
                        } //fin success
                    }); //fin del $.ajax


                        </c:when>



                    </c:choose>
                </c:forEach>
                });
            </script>
        </div>

        <!-- Load site level scripts -->

    </body>
</html>
<script type="text/javascript">
    $(function() {
        $("#facultad").change(function() {
            $.ajax({
                type: 'POST',
                url: "Encuestas?accion=selectorProgramas",
                data: "facultad=" + $('#facultad :selected').val(),
                dataType: "json",
                success: function(datos) {
                    $("#programa").empty();
                    $("#programa").append("<option value='NA'>Seleccione un programa...</option>");
                    $.each(datos.programas, function(posicion, programa) {
                        $("#programa").append("<option value='" +
                                programa.id + "'>" + programa.programa + "</option>");
                    });

                    $("#wrapper").empty();
                    $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
                    $.ajax({
                        type: 'POST',
                        url: "fontController?accion=informeXpreguntaFacultad",
                        data: "facultad=" + $('#facultad :selected').val() + "&para=${fuente}&para2=g",
                        success: function(datos) {
                            $("#wrapper").html(datos);
                        }, //fin success
                        error: function(datos) {
                            $("#wrapper").empty();
                            $("#wrapper").append(datos);
                        }

                    }); //fin $.ajax

                }, //fin success
                error: function(datos) {
                    $("#programa").empty();
                    $("#programa").append("<option value='NA'>Seleccione un programa...</option>");
                }

            }); //fin $.ajax
        });

        $("#programa").change(function() {
            $("#wrapper").empty();
            $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
            $.ajax({
                type: 'POST',
                url: "fontController?accion=informeXpreguntaPrograma",
                data: "programa=" + $('#programa :selected').val() + "&para=${fuente}&para2=g",
                success: function(datos) {
                    $("#wrapper").html(datos);
                }, //fin success
                error: function(datos) {
                    $("#wrapper").empty();
                    $("#wrapper").append(datos);
                }

            }); //fin $.ajax

        }); //fin changeprograma


        $("#semestre").change(function() {
            var text1 = 'Seleccione una facultad...';
            $("select option").filter(function() {
                //may want to use $.trim in here
                return $(this).text() == text1;
            }).prop('selected', true);
            $("#programa").empty();
            $("#wrapper").empty();
            $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
            $.ajax({
                type: 'POST',
                url: "fontController?accion=informeXpreguntaSemestre",
                data: "semestre=" + $('#semestre :selected').val() + "&para=${fuente}&para2=g",
                success: function(datos) {
                    $("#wrapper").html(datos);
                }, //fin success
                error: function(datos) {
                    $("#wrapper").empty();
                    $("#wrapper").append(datos);
                }

            }); //fin $.ajax

        }); //fin changeprograma
        $("#vinculacion").change(function() {
            var text1 = 'Seleccione una facultad...';
            $("select option").filter(function() {
                //may want to use $.trim in here
                return $(this).text() == text1;
            }).prop('selected', true);
            $("#programa").empty();
            $("#wrapper").empty();
            $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
            $.ajax({
                type: 'POST',
                url: "fontController?accion=informeXpreguntaVinculacion",
                data: "vinculacion=" + $('#vinculacion :selected').val() + "&para=${fuente}&para2=g",
                success: function(datos) {
                    $("#wrapper").html(datos);
                }, //fin success
                error: function(datos) {
                    $("#wrapper").empty();
                    $("#wrapper").append(datos);
                }

            }); //fin $.ajax

        }); //fin changeprograma


        $("#tiempo").change(function() {
            var text1 = 'Seleccione una facultad...';
            $("select option").filter(function() {
                //may want to use $.trim in here
                return $(this).text() == text1;
            }).prop('selected', true);
            $("#programa").empty();
            $("#wrapper").empty();
            $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
            $.ajax({
                type: 'POST',
                url: "fontController?accion=informeXpreguntaTiempo",
                data: "tiempo=" + $('#tiempo :selected').val() + "&para=${fuente}&para2=g",
                success: function(datos) {
                    $("#wrapper").html(datos);
                }, //fin success
                error: function(datos) {
                    $("#wrapper").empty();
                    $("#wrapper").append(datos);
                }

            }); //fin $.ajax

        }); //fin changeprograma

        $("#area").change(function() {
            var text1 = 'Seleccione una facultad...';
            $("select option").filter(function() {
                //may want to use $.trim in here
                return $(this).text() == text1;
            }).prop('selected', true);
            $("#programa").empty();
            $("#wrapper").empty();
            $('#wrapper').html('<img id="loader-img" alt="" src="assets/img/loader-larger.gif" width="100" height="100" align="center" />');
            $.ajax({
                type: 'POST',
                url: "fontController?accion=informeXpreguntaArea",
                data: "area=" + $('#area :selected').val() + "&para=${fuente}&para2=g",
                success: function(datos) {
                    $("#wrapper").html(datos);
                }, //fin success
                error: function(datos) {
                    $("#wrapper").empty();
                    $("#wrapper").append(datos);
                }

            }); //fin $.ajax

        }); //fin changeprograma

    });
</script>
