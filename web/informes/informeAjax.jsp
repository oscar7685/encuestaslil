<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                                            </table>
                                                            No Personas: ${cantidadPersonasXpregunta.get(iter.index)}
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

