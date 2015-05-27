/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.udec.actions;

import com.udec.controlador.Action;
import com.udec.ejb.EncuestaFacade;
import com.udec.ejb.FacultadFacade;
import com.udec.ejb.ResultadosFacade;
import com.udec.entidades.Encuesta;
import com.udec.entidades.Facultad;
import com.udec.entidades.Pregunta;
import com.udec.entidades.Programa;
import com.udec.entidades.Respuesta;
import com.udec.entidades.Resultados;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author acreditacion
 */
public class InformeXpreguntaFacultad implements Action {

    ResultadosFacade resultadosFacade = lookupResultadosFacadeBean();

    EncuestaFacade encuestaFacade = lookupEncuestaFacadeBean();

    FacultadFacade facultadFacade = lookupFacultadFacadeBean();

    @Override
    public String procesar(HttpServletRequest request) throws IOException, ServletException {
        HttpSession sesion = request.getSession();
        String para = (String) request.getParameter("para");
        String para2 = (String) request.getParameter("para2");
        String para3 = (String) request.getParameter("para3");
        String facultad = (String) request.getParameter("facultad");
        Facultad fac = null;
        if (facultad != null && !facultad.equals("NA")) {
            fac = facultadFacade.find(Integer.parseInt(facultad));
        }
        int num = Integer.parseInt(para);
        int totalr = 0;
        List cantidadPersonasxPregunta = new ArrayList();
        Encuesta e = encuestaFacade.find(num);
        List<Pregunta> preguntas = encuestaFacade.preguntasOrdenadasXorden(e);

        List<List<String>> RespuestasPreguntasAbiertas = new ArrayList<List<String>>();

        List<String> totalrespuestas = new ArrayList<String>();
        List<List<String>> cantidadXrespuestaXPregunta = new ArrayList<List<String>>();
        List<List<String>> cantidadXrespuestaXPregunta6 = new ArrayList<List<String>>();

        List<List<List<String>>> cantidadXOrdenXrespuestaXPregunta = new ArrayList<List<List<String>>>();
        int preguntaIndex = 0;
        for (Pregunta pregunta : preguntas) {
            int cantidadPersonas = resultadosFacade.ContarPersonasXPregunta("preguntaIdpregunta", pregunta);
            pregunta.getRespuestaList().size();
            List<String> resultadosAbiertaPreguntaActual = new ArrayList<String>();
            totalr = 0;
            List<String> cantidadRespuestasPreguntaActual = new ArrayList<String>();
            List<String> cantidadRespuestasPreguntaActual6 = new ArrayList<String>();
            List<List<String>> cantidadOrdenRespuestasPreguntaActual = new ArrayList<List<String>>();
            if ("0".equals(pregunta.getTipo())) {
                //Preguntas tipo 0  seleccion multiple unica respuesta
                List<Respuesta> respuestas = pregunta.getRespuestaList();
                for (Respuesta respuesta : respuestas) {
                    if (!facultad.equals("NA")) {
                        List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                        cantidadRespuestasPreguntaActual.add("" + resultados.size());
                        totalr += resultados.size();
                    }

                }
                if ("true".equals(pregunta.getOtro())) {
                    if (!facultad.equals("NA")) {
                        List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                        cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                        totalr += resultados2.size();
                    }
                }
            } else if ("1".equals(pregunta.getTipo())) {
                //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                List<Respuesta> respuestas = pregunta.getRespuestaList();

                for (Respuesta respuesta : respuestas) {
                    List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                    List<Resultados> resultados = null;

                    if (!facultad.equals("NA")) {
                        resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                    }

                    if ("true".equals(pregunta.getOtro())) {

                        if ( !facultad.equals("NA")) {
                            for (int i = 0; i <= respuestas.size(); i++) {
                                List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                            }
                        }

                    } else {
                        if ( !facultad.equals("NA")) {
                            for (int i = 0; i < respuestas.size(); i++) {
                                List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                            }
                        }

                    }
                    cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                    cantidadRespuestasPreguntaActual.add("" + resultados.size());
                    totalr += resultados.size();

                }
                if ("true".equals(pregunta.getOtro())) {
                    List<String> cantidadOrdenRespuestasActual22 = new ArrayList<String>();

                    if ( !facultad.equals("NA")) {
                        for (int i = 0; i <= respuestas.size(); i++) {
                            List<Resultados> CantidadOrdenresultados2 = resultadosFacade.findByList2Especial3("preguntaIdpregunta", pregunta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                            cantidadOrdenRespuestasActual22.add("" + CantidadOrdenresultados2.size());
                        }
                    }

                    cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual22);

                    if ( !facultad.equals("NA")) {
                        List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                        cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                        totalr += resultados2.size();
                    }

                }
            } else if ("2".equals(pregunta.getTipo()) || "3".equals(pregunta.getTipo()) || "4".equals(pregunta.getTipo())) {
                List<Resultados> resultadoAbierta = new ArrayList<Resultados>();
                if ( !facultad.equals("NA")) {
                    resultadoAbierta = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                }
                for (Resultados resultados : resultadoAbierta) {
                    resultadosAbiertaPreguntaActual.add(resultados.getValor());
                }
                RespuestasPreguntasAbiertas.add(resultadosAbiertaPreguntaActual);

            } else if ("6".equals(pregunta.getTipo())) {
                //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                List<Respuesta> respuestas6 = pregunta.getRespuestaList();
                if ( !facultad.equals("NA")) {
                    for (Respuesta respuesta : respuestas6) {
                        List<Resultados> resultados6 = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "valor", "Si", "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                        cantidadRespuestasPreguntaActual6.add("" + resultados6.size());
                        totalr += resultados6.size();

                    }
                }

            } else if ("7".equals(pregunta.getTipo())) {
                //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                List<Respuesta> respuestas = pregunta.getRespuestaList();

                if ( !facultad.equals("NA")) {
                    for (Respuesta respuesta : respuestas) {
                        List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                        List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);

                        for (int i = 0; i < respuestas.size(); i++) {
                            List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                            cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                        }

                        cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                        cantidadRespuestasPreguntaActual.add("" + resultados.size());
                        totalr += resultados.size();

                    }

                }

            } else if ("9".equals(pregunta.getTipo())) {
                //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                List<Respuesta> respuestas = pregunta.getRespuestaList();

                if ( !facultad.equals("NA")) {
                    for (Respuesta respuesta : respuestas) {
                        List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                        cantidadRespuestasPreguntaActual.add("" + resultados.size());
                        totalr += resultados.size();
                    }
                }

            }

            if (RespuestasPreguntasAbiertas.size() < preguntaIndex + 1) {
                RespuestasPreguntasAbiertas.add(new ArrayList<String>());
            }

            if (!"6".equals(pregunta.getTipo())) {
                cantidadRespuestasPreguntaActual6.add("NA");
            }

            preguntaIndex++;
            totalrespuestas.add("" + totalr);
            cantidadXrespuestaXPregunta.add(cantidadRespuestasPreguntaActual);
            cantidadXrespuestaXPregunta6.add(cantidadRespuestasPreguntaActual6);
            cantidadXOrdenXrespuestaXPregunta.add(cantidadOrdenRespuestasPreguntaActual);
            //cantidadXOrdenXrespuestaXPregunta.add(cantidadOrdenRespuestasPreguntaActual6);

        }
        sesion.setAttribute("cantidadPersonasXpregunta", cantidadPersonasxPregunta);
        sesion.setAttribute("preguntas", preguntas);
        sesion.setAttribute("totalrespuestas", totalrespuestas);
        sesion.setAttribute("cantidadXrespuestaXPregunta", cantidadXrespuestaXPregunta);
        sesion.setAttribute("cantidadXrespuestaXPregunta6", cantidadXrespuestaXPregunta6); //tipo 6
        sesion.setAttribute("cantidadXOrdenXrespuestaXPregunta", cantidadXOrdenXrespuestaXPregunta);
        sesion.setAttribute("RespuestasPreguntasAbiertas", RespuestasPreguntasAbiertas);
        sesion.setAttribute("fuente", para);
        sesion.setAttribute("facultades", facultadFacade.findAll());

        String url = "informes/informeAjax2.jsp"; //sin graficas
        if (para2 != null && para2.equals("g")) { //con graficas
            url = "informes/informeAjax.jsp";
        }
        return url;
    }

    private FacultadFacade lookupFacultadFacadeBean() {
        try {
            Context c = new InitialContext();
            return (FacultadFacade) c.lookup("java:global/encuestas/FacultadFacade!com.udec.ejb.FacultadFacade");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

    private EncuestaFacade lookupEncuestaFacadeBean() {
        try {
            Context c = new InitialContext();
            return (EncuestaFacade) c.lookup("java:global/encuestas/EncuestaFacade!com.udec.ejb.EncuestaFacade");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

    private ResultadosFacade lookupResultadosFacadeBean() {
        try {
            Context c = new InitialContext();
            return (ResultadosFacade) c.lookup("java:global/encuestas/ResultadosFacade!com.udec.ejb.ResultadosFacade");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

}
