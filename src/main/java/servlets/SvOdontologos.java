package servlets;

import java.io.IOException;
//import java.io.PrintWriter;
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
        
        response.sendRedirect("verOdontologos.jsp");
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dniOdon = request.getParameter("dniOdon");
        String nombreOdon = request.getParameter("nombreOdon");
        String apellidoOdon = request.getParameter("apellidoOdon");
        String telefonoOdon = request.getParameter("telefonoOdon");
        String direccionOdon = request.getParameter("direccionOdon");
        String fechaNacStringOdon = request.getParameter("fechaNacOdon");
        String especialidadOdon = request.getParameter("especialidadOdon");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNacOdon = null;

        try {
            fechaNacOdon = formatter.parse(fechaNacStringOdon);
        } catch (ParseException ex) {
            Logger.getLogger(SvPacientes.class.getName()).log(Level.SEVERE, null, ex);
        }

        control.crearOdontologo(dniOdon, nombreOdon, apellidoOdon, telefonoOdon, direccionOdon, fechaNacOdon, especialidadOdon);

        response.sendRedirect("index.jsp");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
