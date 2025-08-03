package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@WebServlet(name = "SvEditTurnos", urlPatterns = {"/SvEditTurnos"})
public class SvEditTurnos extends HttpServlet {
    
    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
            
        int id = Integer.parseInt(request.getParameter("id"));
        Turno tur = control.traerTurno(id);
        HttpSession misession = request.getSession();
        
        misession.setAttribute("turnoEditar", tur);
        

        
        
        response.sendRedirect("editarTurnos.jsp");

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
        
        Turno tur = (Turno) request.getSession().getAttribute("turnoEditar");
        //tur.setPacien(pacien);
        //tur.setOdonto(odonto);
        tur.setFecha_turno(fechaTurno);
        tur.setHora_turno(horaTurno);
        tur.setAfeccion(afeccion);
        
        control.editarTurno(tur);
        response.sendRedirect("SvTurnos");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
