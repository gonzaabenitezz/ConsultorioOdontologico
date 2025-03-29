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
import logica.Secretario;

@WebServlet(name = "SvEditSecretarios", urlPatterns = {"/SvEditSecretarios"})
public class SvEditSecretarios extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Secretario secre = control.traerSecretario(id);

        HttpSession misession = request.getSession();
        misession.setAttribute("secreEditar", secre);

        response.sendRedirect("editarSecretarios.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        
        String dni = request.getParameter("dnisecre");
        String nombre = request.getParameter("nombresecre");
        String apellido = request.getParameter("apellidosecre");
        String telefono = request.getParameter("telefonosecre");
        String direccion = request.getParameter("direccionsecre");
        String fechaNacString = request.getParameter("fechanacsecre");
        String sector = request.getParameter("sectorsecre");
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = null;
        
        try {
            fechaNac = formatter.parse(fechaNacString);
        } catch (ParseException ex) {
            Logger.getLogger(SvEditSecretarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Secretario secre = (Secretario) request.getSession().getAttribute("secreEditar");
        secre.setDni(dni);
        secre.setNombre(nombre);
        secre.setApellido(apellido);
        secre.setTelefono(telefono);
        secre.setDireccion(direccion);
        secre.setFecha_nac(fechaNac);
        secre.setSector(sector);
        
        control.editarSecretario(secre);
        
        response.sendRedirect("SvSecretarios");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
