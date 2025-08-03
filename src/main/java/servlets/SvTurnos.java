package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Odontologo;
import logica.Paciente;
import logica.Turno;

@WebServlet(name = "SvTurnos", urlPatterns = {"/SvTurnos"})
public class SvTurnos extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Turno> listaTurnos = new ArrayList<Turno>();
        listaTurnos = control.getTurnos();
        HttpSession misession = request.getSession();
        misession.setAttribute("listaTurnos", listaTurnos);

        List<Odontologo> listaOdontologos = new ArrayList<Odontologo>();
        listaOdontologos = control.getOdontologos();
        misession.setAttribute("listaOdontologos", listaOdontologos);
        
        List<Paciente> listaPacientes = new ArrayList<Paciente>();
        listaPacientes = control.getPacientes();
        misession.setAttribute("listaPacientes", listaPacientes);

        response.sendRedirect("verTurnos.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
        int idOdontologo = Integer.parseInt(request.getParameter("idOdontologo"));
        String fecha = request.getParameter("fechaTurno");
        String horaTurno = request.getParameter("horaTurno");
        String afeccion = request.getParameter("afeccion");

        if (horaTurno == null) {
            throw new ServletException("No se encontro el horario del turno");
        }

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaTurno = null;

        try {
            fechaTurno = formatter.parse(fecha);
        } catch (ParseException ex) {
            Logger.getLogger(SvSecretarios.class.getName()).log(Level.SEVERE, null, ex);
        }

        control.crearTurno(idPaciente, idOdontologo, fechaTurno, horaTurno, afeccion);

        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
