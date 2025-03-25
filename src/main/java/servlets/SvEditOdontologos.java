package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "SvEditOdontologos", urlPatterns = {"/SvEditOdontologos"})
public class SvEditOdontologos extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Odontologo odon = control.traerOdontologo(id);

        HttpSession misession = request.getSession();
        misession.setAttribute("odonEditar", odon);

        response.sendRedirect("editarOdontologos.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dniOdon = request.getParameter("dniOdon");
        String nombreOdon = request.getParameter("nombreOdon");
        String apellidoOdon = request.getParameter("apellidoOdon");
        String telefonoOdon = request.getParameter("telefonoOdon");
        String direccionOdon = request.getParameter("direccionOdon");
        String fechaNacOdonString = request.getParameter("fechaNacOdon");
        String especialidadOdon = request.getParameter("especialidadOdon");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNacOdon = null;
        
        try {
            fechaNacOdon = formatter.parse(fechaNacOdonString);
        } catch (ParseException ex) {
            Logger.getLogger(SvEditOdontologos.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Odontologo odon = (Odontologo) request.getSession().getAttribute("odonEditar");
        odon.setDni(dniOdon);
        odon.setNombre(nombreOdon);
        odon.setApellido(apellidoOdon);
        odon.setTelefono(telefonoOdon);
        odon.setDireccion(direccionOdon);
        odon.setFecha_nac(fechaNacOdon);
        odon.setEspecialidad(especialidadOdon);
        
        control.editarOdontologo(odon);
        
        response.sendRedirect("SvOdontologos");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
