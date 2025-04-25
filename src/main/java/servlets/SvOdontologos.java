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
import logica.Horario;
import logica.Odontologo;

@WebServlet(name = "SvOdontologos", urlPatterns = {"/SvOdontologos"})
public class SvOdontologos extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Odontologo> listaOdontologos = new ArrayList<Odontologo>();
        listaOdontologos = control.getOdontologos();

        HttpSession misession = request.getSession();
        misession.setAttribute("listaOdontologos", listaOdontologos);

        List<Horario> listaHorarios = new ArrayList<Horario>();
        listaHorarios = control.getHorarios();
        misession.setAttribute("listaHorarios", listaHorarios);

        response.sendRedirect("verOdontologos.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int unUsuario = (int) request.getSession().getAttribute("id_usuario");

        try {

            //Horario
            HttpSession sessionHorario = request.getSession();

            //Procesar horario
            String inicioHorOdon = request.getParameter("inicioHorOdon");
            String finHorOdon = request.getParameter("finHorOdon");

            if (inicioHorOdon == null || inicioHorOdon.trim().isEmpty()) {
                throw new ServletException("Horario de inicio no proporcionado");
            }

            if (finHorOdon == null || finHorOdon.trim().isEmpty()) {
                throw new ServletException("Fin de horario no proporcionado");
            }

            //Guardar horario en session y redirigir a SvHorarios
            sessionHorario.setAttribute("inicioHorario", inicioHorOdon);
            sessionHorario.setAttribute("finHorario", finHorOdon);
            request.getRequestDispatcher("SvHorarios").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error al procesar horario: " + e.getMessage(), e);
        }

        int unHorario = (int) request.getSession().getAttribute("id_horario");

        String dniOdon = request.getParameter("dniOdon");
        String nombreOdon = request.getParameter("nombreOdon");
        String apellidoOdon = request.getParameter("apellidoOdon");
        String telefonoOdon = request.getParameter("telefonoOdon");
        String direccionOdon = request.getParameter("direccionOdon");
        String fechaNacStringOdon = request.getParameter("fechaNacOdon");
        String especialidadOdon = request.getParameter("especialidadOdon");

        //Resto de valores del Odontologo
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNacOdon = null;

        try {
            fechaNacOdon = formatter.parse(fechaNacStringOdon);
        } catch (ParseException ex) {
            Logger.getLogger(SvPacientes.class.getName()).log(Level.SEVERE, null, ex);
        }

        control.crearOdontologo(dniOdon, nombreOdon, apellidoOdon, telefonoOdon, direccionOdon, fechaNacOdon, especialidadOdon, unUsuario, unHorario);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
