/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.udec.controlador;

import com.udec.ejb.EncuestaFacade;
import com.udec.ejb.FacultadFacade;
import com.udec.ejb.PersonaFacade;
import com.udec.ejb.PreguntaFacade;
import com.udec.ejb.ProgramaFacade;
import com.udec.ejb.RespuestaFacade;
import com.udec.ejb.ResultadosFacade;
import com.udec.entidades.Encuesta;
import com.udec.entidades.Facultad;
import com.udec.entidades.Persona;
import com.udec.entidades.Pregunta;
import com.udec.entidades.Programa;
import com.udec.entidades.Respuesta;
import com.udec.entidades.Resultados;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Diana
 */
public class Encuestas extends HttpServlet {

    @EJB
    private ResultadosFacade resultadosFacade;
    @EJB
    private PersonaFacade personaFacade;
    @EJB
    private ProgramaFacade programaFacade;
    @EJB
    private RespuestaFacade respuestaFacade;
    @EJB
    private PreguntaFacade preguntaFacade;
    @EJB
    private FacultadFacade facultadFacade;
    @EJB
    private EncuestaFacade encuestaFacade;
    private final static Logger LOGGER = Logger.getLogger(Encuestas.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        String accion = (String) request.getParameter("accion");
        try {

            if (accion.equals("informeXpregunta")) {
                String para = (String) request.getParameter("para");
                String para2 = (String) request.getParameter("para2");
                String para3 = (String) request.getParameter("para3");
                String facultad = (String) request.getParameter("facultad");
                Facultad fac = null;
                if (facultad != null && !facultad.equals("NA")) {
                    fac = facultadFacade.find(Integer.parseInt(facultad));
                }

                String programa = (String) request.getParameter("programa");
                Programa prog = null;
                if (programa != null && !programa.equals("NA")) {
                    prog = programaFacade.find(Integer.parseInt(programa));
                }
                int semestreInt = 0;
                String semestre = (String) request.getParameter("semestre");
                try {
                    semestreInt = Integer.parseInt(semestre);
                } catch (Exception e) {

                }

                int num = Integer.parseInt(para);
                int totalr = 0;
                Encuesta e = encuestaFacade.find(num);
                List<Pregunta> preguntas = encuestaFacade.preguntasOrdenadasXorden(e);

                List<List<String>> RespuestasPreguntasAbiertas = new ArrayList<List<String>>();

                List<String> totalrespuestas = new ArrayList<String>();
                List<List<String>> cantidadXrespuestaXPregunta = new ArrayList<List<String>>();
                List<List<String>> cantidadXrespuestaXPregunta6 = new ArrayList<List<String>>();

                List<List<List<String>>> cantidadXOrdenXrespuestaXPregunta = new ArrayList<List<List<String>>>();
                int preguntaIndex = 0;
                for (Pregunta pregunta : preguntas) {
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
                            if (semestre != null && !semestre.equals("NA")) {
                                List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.semestre", semestreInt);
                                cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                totalr += resultados.size();
                            } else {
                                if (para2 == null || !para2.equals("ajax")) {
                                    List<Resultados> resultados = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta);
                                    cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                    totalr += resultados.size();
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                        List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                        cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                        totalr += resultados.size();
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                            List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma", prog);
                                            cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                            totalr += resultados.size();
                                        }
                                    }
                                }
                            }

                        }
                        if ("true".equals(pregunta.getOtro())) {
                            if (semestre != null && !semestre.equals("NA")) {
                                List<Resultados> resultados2 = resultadosFacade.findByList2Especial2("preguntaIdpregunta", pregunta, "personaIdpersona.semestre", semestreInt);
                                cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                totalr += resultados2.size();
                            } else {
                                if (para2 == null || !para2.equals("ajax")) {
                                    List<Resultados> resultados2 = resultadosFacade.findByList2Especial("preguntaIdpregunta", pregunta);
                                    cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                    totalr += resultados2.size();
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                        List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                        cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                        totalr += resultados2.size();
                                    } else {
                                        List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma", prog);
                                        cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                        totalr += resultados2.size();
                                    }
                                }
                            }
                        }

                    } else if ("1".equals(pregunta.getTipo())) {
                        //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();

                        for (Respuesta respuesta : respuestas) {
                            List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                            List<Resultados> resultados = null;

                            if (semestre != null && !semestre.equals("NA")) {
                                resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.semestre", semestreInt);
                            } else {

                                if (para2 == null || !para2.equals("ajax")) {
                                    resultados = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta);
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                        resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                            resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma", prog);
                                        }
                                    }
                                }
                            }

                            if ("true".equals(pregunta.getOtro())) {
                                if (semestre != null && !semestre.equals("NA")) {
                                    for (int i = 0; i <= respuestas.size(); i++) {
                                        List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.semestre", semestreInt);
                                        cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                    }
                                } else {
                                    if (para2 == null || !para2.equals("ajax")) {
                                        for (int i = 0; i <= respuestas.size(); i++) {
                                            List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1);
                                            cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                        }
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                            for (int i = 0; i <= respuestas.size(); i++) {
                                                List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                                cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                            }
                                        } else {
                                            if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                                for (int i = 0; i <= respuestas.size(); i++) {
                                                    List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma", prog);
                                                    cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                                }
                                            }
                                        }
                                    }
                                }

                            } else {
                                if (semestre != null && !semestre.equals("NA")) {
                                    for (int i = 0; i < respuestas.size(); i++) {
                                        List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.semestre", semestreInt);
                                        cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                    }
                                } else {

                                    if (para2 == null || !para2.equals("ajax")) {
                                        for (int i = 0; i < respuestas.size(); i++) {
                                            List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1);
                                            cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                        }
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                            for (int i = 0; i < respuestas.size(); i++) {
                                                List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                                cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                            }
                                        } else {
                                            if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                                for (int i = 0; i < respuestas.size(); i++) {
                                                    List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma", prog);
                                                    cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                            cantidadRespuestasPreguntaActual.add("" + resultados.size());
                            totalr += resultados.size();

                        }
                        if ("true".equals(pregunta.getOtro())) {
                            List<String> cantidadOrdenRespuestasActual22 = new ArrayList<String>();

                            if (semestre != null && !semestre.equals("NA")) {
                                for (int i = 0; i <= respuestas.size(); i++) {
                                    List<Resultados> CantidadOrdenresultados2 = resultadosFacade.findByList2Especial3("preguntaIdpregunta", pregunta, "orden", i + 1, "personaIdpersona.semestre", semestreInt);
                                    cantidadOrdenRespuestasActual22.add("" + CantidadOrdenresultados2.size());

                                }
                            } else {
                                if (para2 == null || !para2.equals("ajax")) {
                                    for (int i = 0; i <= respuestas.size(); i++) {
                                        List<Resultados> CantidadOrdenresultados2 = resultadosFacade.findByList2Especial2("preguntaIdpregunta", pregunta, "orden", i + 1);
                                        cantidadOrdenRespuestasActual22.add("" + CantidadOrdenresultados2.size());

                                    }
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                        for (int i = 0; i <= respuestas.size(); i++) {
                                            List<Resultados> CantidadOrdenresultados2 = resultadosFacade.findByList2Especial3("preguntaIdpregunta", pregunta, "orden", i + 1, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                            cantidadOrdenRespuestasActual22.add("" + CantidadOrdenresultados2.size());
                                        }
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                            for (int i = 0; i <= respuestas.size(); i++) {
                                                List<Resultados> CantidadOrdenresultados2 = resultadosFacade.findByList2Especial3("preguntaIdpregunta", pregunta, "orden", i + 1, "personaIdpersona.programaIdprograma", prog);
                                                cantidadOrdenRespuestasActual22.add("" + CantidadOrdenresultados2.size());
                                            }
                                        }
                                    }
                                }
                            }
                            cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual22);
                            if (semestre != null && !semestre.equals("NA")) {
                                List<Resultados> resultados2 = resultadosFacade.findByList2Especial2("preguntaIdpregunta", pregunta, "personaIdpersona.semestre", semestreInt);
                                cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                totalr += resultados2.size();
                            } else {
                                if (para2 == null || !para2.equals("ajax")) {
                                    List<Resultados> resultados2 = resultadosFacade.findByList2Especial("preguntaIdpregunta", pregunta);
                                    cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                    totalr += resultados2.size();
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                        List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                        cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                        totalr += resultados2.size();
                                    } else {
                                        if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                            List<Resultados> resultados2 = resultadosFacade.findByList2EspecialParametro1("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma", prog);
                                            cantidadRespuestasPreguntaActual.add("" + resultados2.size());
                                            totalr += resultados2.size();
                                        }
                                    }
                                }
                            }
                        }
                    } else if ("2".equals(pregunta.getTipo()) || "3".equals(pregunta.getTipo()) || "4".equals(pregunta.getTipo())) {
                        List<Resultados> resultadoAbierta = new ArrayList<Resultados>();
                        if (semestre != null && !semestre.equals("NA")) {
                            resultadoAbierta = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "personaIdpersona.semestre", semestreInt);
                        } else {
                            if (para2 == null || !para2.equals("ajax")) {
                                resultadoAbierta = resultadosFacade.findByList("preguntaIdpregunta", pregunta);
                            } else {
                                if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                    resultadoAbierta = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                        resultadoAbierta = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "personaIdpersona.programaIdprograma", prog);
                                    }
                                }
                            }
                        }
                        for (Resultados resultados : resultadoAbierta) {
                            resultadosAbiertaPreguntaActual.add(resultados.getValor());
                        }
                        RespuestasPreguntasAbiertas.add(resultadosAbiertaPreguntaActual);

                    } else if ("6".equals(pregunta.getTipo())) {
                        //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                        List<Respuesta> respuestas6 = pregunta.getRespuestaList();
                        if (semestre != null && !semestre.equals("NA")) {
                            for (Respuesta respuesta : respuestas6) {
                                List<Resultados> resultados6 = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "valor", "Si", "personaIdpersona.semestre", semestreInt);
                                cantidadRespuestasPreguntaActual6.add("" + resultados6.size());
                                totalr += resultados6.size();

                            }
                        } else {
                            if (para2 == null || !para2.equals("ajax")) {
                                for (Respuesta respuesta : respuestas6) {
                                    List<Resultados> resultados6 = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "valor", "Si");
                                    cantidadRespuestasPreguntaActual6.add("" + resultados6.size());
                                    totalr += resultados6.size();

                                }
                            } else {
                                if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                    for (Respuesta respuesta : respuestas6) {
                                        List<Resultados> resultados6 = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "valor", "Si", "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                        cantidadRespuestasPreguntaActual6.add("" + resultados6.size());
                                        totalr += resultados6.size();

                                    }
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                        for (Respuesta respuesta : respuestas6) {
                                            List<Resultados> resultados6 = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "valor", "Si", "personaIdpersona.programaIdprograma", prog);
                                            cantidadRespuestasPreguntaActual6.add("" + resultados6.size());
                                            totalr += resultados6.size();

                                        }
                                    }
                                }
                            }
                        }

                    } else if ("7".equals(pregunta.getTipo())) {
                        //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();

                        if (semestre != null && !semestre.equals("NA")) {
                            for (Respuesta respuesta : respuestas) {
                                List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                                List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.semestre", semestreInt);

                                for (int i = 0; i < respuestas.size(); i++) {
                                    List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.semestre", semestreInt);
                                    cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                }

                                cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                                cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                totalr += resultados.size();

                            }
                        } else {
                            if (para2 == null || !para2.equals("ajax")) {
                                for (Respuesta respuesta : respuestas) {
                                    List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                                    List<Resultados> resultados = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta);

                                    for (int i = 0; i < respuestas.size(); i++) {
                                        List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1);
                                        cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                    }

                                    cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                                    cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                    totalr += resultados.size();

                                }
                            } else {
                                if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
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

                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                        for (Respuesta respuesta : respuestas) {
                                            List<String> cantidadOrdenRespuestasActual = new ArrayList<String>();
                                            List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma", prog);

                                            for (int i = 0; i < respuestas.size(); i++) {
                                                List<Resultados> CantidadOrdenresultados = resultadosFacade.findByList4("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "orden", i + 1, "personaIdpersona.programaIdprograma", prog);
                                                cantidadOrdenRespuestasActual.add("" + CantidadOrdenresultados.size());
                                            }

                                            cantidadOrdenRespuestasPreguntaActual.add(cantidadOrdenRespuestasActual);
                                            cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                            totalr += resultados.size();

                                        }
                                    }
                                }
                            }
                        }

                    } else if ("9".equals(pregunta.getTipo())) {
                        //Preguntas tipo 1  seleccion multiple multiple respuesta con ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();

                        if (semestre != null && !semestre.equals("NA")) {
                            for (Respuesta respuesta : respuestas) {
                                List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.semestre", semestreInt);
                                cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                totalr += resultados.size();
                            }
                        } else {
                            if (para2 == null || !para2.equals("ajax")) {
                                for (Respuesta respuesta : respuestas) {
                                    List<Resultados> resultados = resultadosFacade.findByList2("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta);
                                    cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                    totalr += resultados.size();
                                }
                            } else {
                                if (para2.equals("ajax") && !facultad.equals("NA") && programa.equals("NA")) {
                                    for (Respuesta respuesta : respuestas) {
                                        List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma.facultadIdfacultad", fac);
                                        cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                        totalr += resultados.size();
                                    }
                                } else {
                                    if (para2.equals("ajax") && !facultad.equals("NA") && !programa.equals("NA")) {
                                        for (Respuesta respuesta : respuestas) {
                                            List<Resultados> resultados = resultadosFacade.findByList3("preguntaIdpregunta", pregunta, "respuestaIdrespuesta", respuesta, "personaIdpersona.programaIdprograma", prog);
                                            cantidadRespuestasPreguntaActual.add("" + resultados.size());
                                            totalr += resultados.size();
                                        }
                                    }
                                }
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
                sesion.setAttribute("preguntas", preguntas);
                sesion.setAttribute("totalrespuestas", totalrespuestas);
                sesion.setAttribute("cantidadXrespuestaXPregunta", cantidadXrespuestaXPregunta);
                sesion.setAttribute("cantidadXrespuestaXPregunta6", cantidadXrespuestaXPregunta6); //tipo 6
                sesion.setAttribute("cantidadXOrdenXrespuestaXPregunta", cantidadXOrdenXrespuestaXPregunta);
                sesion.setAttribute("RespuestasPreguntasAbiertas", RespuestasPreguntasAbiertas);
                sesion.setAttribute("fuente", para);
                sesion.setAttribute("facultades", facultadFacade.findAll());

                String url = "informes/informexpregunta.jsp";
                if (para2 != null && para2.equals("g")) {
                    url = "informes/informe.jsp";
                } else {
                    if (para2 != null && para2.equals("ajax")) {
                        url = "informes/informeAjax.jsp";
                    }
                }
                if (para3 != null && para3.equals("para3")) {
                    url = "informes/informeAjax2.jsp";
                }

                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);

            } else if (accion.equals("resultadosP")) {
                response.setContentType("application/json");

                String preguntaid = (String) request.getParameter("preguntaid");
                int indicePregunta = Integer.parseInt(preguntaid);
                List<List<String>> aux = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta");
                List<List<String>> aux6 = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta6");
                List<Pregunta> preg = (List<Pregunta>) sesion.getAttribute("preguntas");

                String aux4 = "{ \"datos\":[";

                try {
                    for (int i = 0; i < preg.get(indicePregunta).getRespuestaList().size(); i++) {
                        if (!preg.get(indicePregunta).getTipo().equals("6")) {
                            String aux5 = ""
                                    + "{"
                                    + "\"y\": \"" + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\" ," + " \"a\": \"" + aux.get(indicePregunta).get(i)
                                    + "\""
                                    + "},"
                                    + "";
                            aux4 += aux5;
                        } else {
                            String aux5 = ""
                                    + "{"
                                    + "\"y\": \"" + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\" ," + " \"a\": \"" + aux6.get(indicePregunta).get(i)
                                    + "\""
                                    + "},"
                                    + "";
                            aux4 += aux5;
                        }

                    }
                    aux4 = aux4.substring(0, aux4.length() - 1);
                    aux4 += "]}";

                    out.println("[" + aux4 + "]");

                } finally {
                    out.close();
                }

            } else if (accion.equals("resultadosP3")) {
                response.setContentType("application/json");

                String preguntaid = (String) request.getParameter("preguntaid");
                int indicePregunta = Integer.parseInt(preguntaid);
                List<List<String>> aux = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta");
                List<List<String>> aux6 = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta6");
                List<Pregunta> preg = (List<Pregunta>) sesion.getAttribute("preguntas");

                String aux4 = "{ \"datos\":[";

                try {
                    for (int i = 0; i < preg.get(indicePregunta).getRespuestaList().size(); i++) {
                        if (!preg.get(indicePregunta).getTipo().equals("6")) {
                            String aux5 = ""
                                    + "["
                                    + "\"" + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\" ," + aux.get(indicePregunta).get(i)
                                    + ""
                                    + "],"
                                    + "";
                            aux4 += aux5;
                        } else {
                            String aux5 = ""
                                    + "["
                                    + "\"" + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\" ," + aux6.get(indicePregunta).get(i)
                                    + ""
                                    + "],"
                                    + "";
                            aux4 += aux5;
                        }

                    }
                    aux4 = aux4.substring(0, aux4.length() - 1);
                    aux4 += "]}";

                    out.println("[" + aux4 + "]");

                } finally {
                    out.close();
                }

            } else if (accion.equals("resultadosP5")) {
                response.setContentType("application/json");

                String preguntaid = (String) request.getParameter("preguntaid");
                int indicePregunta = Integer.parseInt(preguntaid);
                List<List<List>> aux = (List<List<List>>) sesion.getAttribute("cantidadXrespuestaXPreguntaF");
                List<List<List>> aux6 = (List<List<List>>) sesion.getAttribute("cantidadXrespuestaXPregunta6F");

                List<Pregunta> preg = (List<Pregunta>) sesion.getAttribute("preguntas");

                String aux4 = "[";

                try {
                    for (int i = 0; i < preg.get(indicePregunta).getRespuestaList().size(); i++) {
                        if (!preg.get(indicePregunta).getTipo().equals("6")) {
                            String aux5 = "{"
                                    + "\"name\": \"" + preg.get(indicePregunta).getRespuestaList().get(i).getRespuesta().trim()
                                    + "\" , \"data\":["
                                    + aux.get(0).get(indicePregunta).get(i)
                                    + "," + aux.get(1).get(indicePregunta).get(i)
                                    + "," + aux.get(2).get(indicePregunta).get(i)
                                    + "," + aux.get(3).get(indicePregunta).get(i)
                                    + "," + aux.get(4).get(indicePregunta).get(i)
                                    + "]"
                                    + ""
                                    + "},"
                                    + "";
                            aux4 += aux5;
                        } else {
                            String aux5 = "{"
                                    + "\"name\": \"" + preg.get(indicePregunta).getRespuestaList().get(i).getRespuesta().trim()
                                    + "\" , \"data\":["
                                    + aux6.get(0).get(indicePregunta).get(i)
                                    + "," + aux6.get(1).get(indicePregunta).get(i)
                                    + "," + aux6.get(2).get(indicePregunta).get(i)
                                    + "," + aux6.get(3).get(indicePregunta).get(i)
                                    + "," + aux6.get(4).get(indicePregunta).get(i)
                                    + "]"
                                    + ""
                                    + "},"
                                    + "";
                            aux4 += aux5;
                        }

                    }
                    aux4 = aux4.substring(0, aux4.length() - 1);
                    aux4 += "]";

                    out.print(aux4);
                    

                } catch (Exception e) {
                    System.out.println("ha ocurrido un error");
                } finally {
                    //out.close();
                }

            } else if (accion.equals("resultadosP2")) {
                response.setContentType("application/json");

                String preguntaid = (String) request.getParameter("preguntaid");
                int indicePregunta = Integer.parseInt(preguntaid);
                List<List<String>> aux = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta");
                List<List<String>> aux6 = (List<List<String>>) sesion.getAttribute("cantidadXrespuestaXPregunta6");
                List<Pregunta> preg = (List<Pregunta>) sesion.getAttribute("preguntas");

                String aux4 = "{ \"datos\":[{\"categorias\":[";

                try {
                    for (int i = 0; i < preg.get(indicePregunta).getRespuestaList().size(); i++) {
                        if (!preg.get(indicePregunta).getTipo().equals("6")) {
                            String aux5 = "\""
                                    + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\","
                                    + "";
                            aux4 += aux5;
                        } else {
                            String aux5 = "\""
                                    + preg.get(indicePregunta).getRespuestaList()
                                    .get(i).getRespuesta().trim()
                                    + "\","
                                    + "";
                            aux4 += aux5;
                        }

                    }
                    aux4 = aux4.substring(0, aux4.length() - 1);
                    aux4 += "],\"series\":[";
                    for (int i = 0; i < preg.get(indicePregunta).getRespuestaList().size(); i++) {
                        if (!preg.get(indicePregunta).getTipo().equals("6")) {
                            String aux5 = ""
                                    + aux.get(indicePregunta).get(i)
                                    + ","
                                    + "";
                            aux4 += aux5;
                        } else {
                            String aux5 = ""
                                    + aux6.get(indicePregunta).get(i)
                                    + ","
                                    + "";
                            aux4 += aux5;
                        }

                    }
                    aux4 = aux4.substring(0, aux4.length() - 1);

                    aux4 += "]}]}";

                    out.println("[" + aux4 + "]");

                } finally {
                    out.close();
                }

            } else if (accion.equals("irEncuesta")) {
                String idencuesta = (String) request.getParameter("idencuesta");
                sesion.setAttribute("listaF", facultadFacade.findAll());
                sesion.setAttribute("listaP", programaFacade.findAll());
                Encuesta e = encuestaFacade.find(Integer.parseInt(idencuesta));
                sesion.setAttribute("encuesta", e);
                sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                String url = "encuestas/responder.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);

            } else if (accion.equals("guardarEncuesta")) {
                String nombre = (String) request.getParameter("nombre");
                String programa = (String) request.getParameter("programa");
                Programa pro = programaFacade.find(Integer.parseInt(programa));
                Encuesta encuesta = (Encuesta) sesion.getAttribute("encuesta");
                List<Pregunta> preguntas = encuesta.getPreguntaList();
                Persona p = new Persona();
                p.setNombre(nombre);
                p.setProgramaIdprograma(pro);

                if (encuesta.getIdencuesta() == 1) {//docentes
                    String tipoVinculacion = (String) request.getParameter("vinculacion");
                    String tiempoVin = (String) request.getParameter("tiempo");
                    p.setTiempo(tiempoVin);
                    p.setVinculacion(tipoVinculacion);

                } else {
                    if (encuesta.getIdencuesta() == 2) {//estudiantes
                        String semestre = (String) request.getParameter("semestre");
                        String codigo = (String) request.getParameter("codigo");
                        p.setSemestre(Integer.parseInt(semestre));
                        p.setCodigo(codigo);
                    }
                }
                personaFacade.create(p);
                Persona recienCreado = personaFacade.findByUltimo();
                for (Pregunta pregunta : preguntas) {
                    if (pregunta.getTipo().equals("0")) {//seleccion multiple unica respuesta
                        Resultados re = new Resultados();
                        re.setPersonaIdpersona(recienCreado);
                        re.setPreguntaIdpregunta(pregunta);
                        String respuesta1 = (String) request.getParameter("pregunta" + pregunta.getIdpregunta());
                        try {
                            int idRespuesta = Integer.parseInt(respuesta1);
                            re.setRespuestaIdrespuesta(respuestaFacade.find(idRespuesta));
                        } catch (Exception e) {
                            if (respuesta1 != null && respuesta1.equals("otro")) {
                                String respuesta2 = (String) request.getParameter("preguntaOtro" + pregunta.getIdpregunta());
                                if (respuesta2 == null || respuesta2.equals("")) {
                                    re.setValor("ESCOGIERON LA OPCION OTRO Y NO ESCRIBIERON NADA");
                                } else {
                                    re.setValor(respuesta2);
                                }

                            }
                            if (respuesta1 == null) {
                                re.setValor("NO RESPONDIO");
                            }

                        } finally {
                            resultadosFacade.create(re);
                        }

                    } else if (pregunta.getTipo().equals("1")) {//Seleccion multiple con ordenamiento
                        String respuestasEscogidas[] = request.getParameterValues("pregunta" + pregunta.getIdpregunta() + "[]");
                        if (respuestasEscogidas != null) {
                            for (int j = 0; j < respuestasEscogidas.length; j++) {
                                Resultados re = new Resultados();
                                re.setPersonaIdpersona(recienCreado);
                                re.setPreguntaIdpregunta(pregunta);

                                try {
                                    int idRespuesta = Integer.parseInt(respuestasEscogidas[j]);
                                    Respuesta respuesta = respuestaFacade.find(idRespuesta);
                                    re.setRespuestaIdrespuesta(respuesta);
                                    String aux = (String) request.getParameter("ordenR" + respuesta.getIdrespuesta());
                                    try {
                                        re.setOrden(Integer.parseInt(aux));
                                    } catch (Exception ex) {
                                        re.setValor("ESCOGIERON LA OPCION PERO NO LE PUSIERON ORDEN");
                                    }

                                } catch (Exception e) {
                                    if (respuestasEscogidas[j] != null && respuestasEscogidas[j].equals("otro")) {
                                        String respuesta2 = (String) request.getParameter("preguntaOtro" + pregunta.getIdpregunta());
                                        re.setValor(respuesta2);

                                        try {
                                            String aux = (String) request.getParameter("ordenRP" + pregunta.getIdpregunta());
                                            int orden = Integer.parseInt(aux);
                                            re.setOrden(orden);
                                        } catch (Exception ex) {
                                            LOGGER.warn("NO LE COLOCARON EL ORDEN A UNA RESPUESTA DE ORDENAMIENTO Y SELECCION MULTIPLE: ");
                                        }

                                    }
                                } finally {
                                    resultadosFacade.create(re);
                                }

                            }
                        }

                    } else if (pregunta.getTipo().equals("2") || pregunta.getTipo().equals("3")
                            || pregunta.getTipo().equals("4")) { //Respuesta Abierta
                        Resultados re = new Resultados();
                        re.setPersonaIdpersona(recienCreado);
                        re.setPreguntaIdpregunta(pregunta);
                        String respuesta1 = (String) request.getParameter("respuestaAbierta" + pregunta.getIdpregunta());
                        if (respuesta1 == null || respuesta1.equals("")) {
                            re.setValor("NO RESPONDIO");
                        } else {
                            re.setValor(respuesta1);
                        }

                        resultadosFacade.create(re);

                    } else if (pregunta.getTipo().equals("6")) {//multiple respuesta sin ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();
                        for (Respuesta respuesta : respuestas) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta);
                            re.setRespuestaIdrespuesta(respuesta);
                            String aux = (String) request.getParameter("respuesta" + respuesta.getIdrespuesta());
                            re.setValor(aux);
                            resultadosFacade.create(re);

                        }

                    } else if (pregunta.getTipo().equals("7")) {//Solo ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();
                        for (Respuesta respuesta : respuestas) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta);
                            re.setRespuestaIdrespuesta(respuesta);
                            try {
                                String aux = (String) request.getParameter("ordenamiR" + respuesta.getIdrespuesta());
                                int orden = Integer.parseInt(aux);
                                re.setOrden(orden);
                            } catch (Exception e) {
                                re.setValor("NO LE COLOCARON EL ORDEN A UNA RESPUESTA DE SOLO ORDENAMIENTO");
                            } finally {
                                resultadosFacade.create(re);
                            }
                        }
                    } else if (pregunta.getTipo().equals("9")) {
                        Resultados re = new Resultados();
                        re.setPersonaIdpersona(recienCreado);
                        re.setPreguntaIdpregunta(pregunta);
                        String respuesta1 = (String) request.getParameter("pregunta" + pregunta.getIdpregunta());
                        try {
                            int idRespuesta = Integer.parseInt(respuesta1);
                            re.setRespuestaIdrespuesta(respuestaFacade.find(idRespuesta));
                        } catch (Exception e) {
                            if (respuesta1 == null) {
                                re.setValor("NO RESPONDIO");
                            }

                        } finally {
                            resultadosFacade.create(re);
                        }
                    }

                }
            } else {
                if (accion.equals("crearPregunta")) {
                    sesion.setAttribute("listaP", preguntaFacade.findAll());
                    sesion.setAttribute("listaE", encuestaFacade.findAll());
                    String url = "preguntas/crear.jsp";
                    RequestDispatcher rd = request.getRequestDispatcher(url);
                    rd.forward(request, response);

                } else {
                    if (accion.equals("listaP")) {
                        sesion.setAttribute("listaP", preguntaFacade.findAll());
                        String url = "preguntas/listar.jsp";
                        RequestDispatcher rd = request.getRequestDispatcher(url);
                        rd.forward(request, response);

                    } else {
                        if (accion.equals("crearPregunta2")) {
                            Pregunta pre = new Pregunta();
                            String idencuesta = (String) request.getParameter("idencuesta");
                            String padre = (String) request.getParameter("padre");
                            String pregunta = (String) request.getParameter("pregunta");
                            String otro = (String) request.getParameter("otro");
                            String textoOtro = (String) request.getParameter("textoOtro");
                            String tipo = (String) request.getParameter("tipo");
                            String resp = (String) request.getParameter("respuestas");
                            String[] res = resp.split("\n");

                            pre.setEncuestaIdencuesta(encuestaFacade.find(Integer.parseInt(idencuesta)));
                            pre.setPregunta(pregunta);
                            if (otro != null) {
                                pre.setOtro("true");
                                pre.setLabelOtro(textoOtro);

                            }

                            if (padre != null && !padre.equals("")) {
                                pre.setPreguntaPadre(preguntaFacade.find(Integer.parseInt(padre)));
                            }
                            pre.setTipo(tipo);
                            //0
                            //1

                            preguntaFacade.create(pre);
                            List<Pregunta> preg = preguntaFacade.findLastPregunta();
                            Pregunta ultima = preg.get(0);
                            if (tipo.equals("0") || tipo.equals("1") || tipo.equals("6") || tipo.equals("7")) {
                                for (int i = 0; i < res.length; i++) {
                                    Respuesta r = new Respuesta();
                                    r.setRespuesta(res[i]);
                                    r.setPreguntaIdpregunta(ultima);
                                    respuestaFacade.create(r);
                                }
                                List<Respuesta> respuestas = respuestaFacade.findByList("preguntaIdpregunta", ultima);
                                ultima.setRespuestaList(respuestas);
                            }

                            preguntaFacade.edit(ultima);
                            sesion.setAttribute("listaP", preguntaFacade.findAll());

                        } else {
                            if (accion.equals("selectorProgramas")) {
                                response.setContentType("text/json;charset=UTF-8");
                                String facultad = (String) request.getParameter("facultad");
                                Facultad f = facultadFacade.find(Integer.parseInt(facultad));
                                List<Programa> programas = programaFacade.findByList("facultadIdfacultad", f);
                                String aux = "";
                                for (Programa programa : programas) {
                                    if (!aux.equals("")) {
                                        aux += ",{\"id\":\"" + programa.getIdprograma() + "\",\"programa\":\"" + programa.getPrograma() + "\"}";

                                    } else {
                                        aux += "{\"id\":\"" + programa.getIdprograma() + "\",\"programa\":\"" + programa.getPrograma() + "\"}";

                                    }
                                }
                                out.write("{\"programas\":[" + aux + "]}");

                            } else if (accion.equals("listaE")) {
                                sesion.setAttribute("listaE", encuestaFacade.findAll());
                                String url = "encuestas/listar.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);
                            } else if (accion.equals("ordenarP")) {
                                String encu = (String) request.getParameter("encuesta");
                                Encuesta e = encuestaFacade.find(Integer.parseInt(encu));
                                sesion.setAttribute("encuesta", e);
                                sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                                String url = "encuestas/ordenarP.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);
                            } else if (accion.equals("ordenarPreguntas")) {
                                String orden = request.getParameter("order");
                                String separados[] = orden.split(",");
                                for (int i = 0; i < separados.length; i++) {
                                    Pregunta aux = preguntaFacade.find(Integer.parseInt(separados[i]));
                                    aux.setOrden(i + 1);
                                    preguntaFacade.edit(aux);
                                }
                            } else if (accion.equals("Condicionar")) {
                                String encu = (String) request.getParameter("encuesta");
                                Encuesta e = encuestaFacade.find(Integer.parseInt(encu));
                                sesion.setAttribute("encuesta", e);
                                sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                                String url = "encuestas/condicionarP.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);
                            } else if (accion.equals("listaPersonas")) {
                                sesion.setAttribute("listaPersonas", personaFacade.findAll());
                                String url = "personas/listar.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);
                            } else if (accion.equals("verRespuestas")) {
                                sesion.setAttribute("listaPersonas", personaFacade.findAll());
                                String persona = request.getParameter("persona");
                                Persona p = personaFacade.find(Integer.parseInt(persona));
                                Encuesta enc = null;
                                if (p.getSemestre() != null) {
                                    enc = encuestaFacade.find(2);
                                } else if (p.getVinculacion() != null) {
                                    enc = encuestaFacade.find(1);
                                }

                                List<Pregunta> preguntasOrdenadas = encuestaFacade.preguntasOrdenadasXorden(enc);
                                sesion.setAttribute("encuesta", enc);
                                sesion.setAttribute("preguntas", preguntasOrdenadas);
                                List<List<Resultados>> resultadosxpregunta = new ArrayList<List<Resultados>>();
                                for (Pregunta pregunta : preguntasOrdenadas) {
                                    List<Resultados> resultados = resultadosFacade.findByList2("personaIdpersona", p, "preguntaIdpregunta", pregunta);
                                    resultadosxpregunta.add(resultados);
                                }

                                sesion.setAttribute("resultadosxpregunta", resultadosxpregunta);

                                sesion.setAttribute("personaje", p);
                                String url = "personas/verResultados.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);

                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("Se ha presentado un error: ", e);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
