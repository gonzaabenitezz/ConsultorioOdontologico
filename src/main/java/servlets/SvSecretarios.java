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
import logica.Secretario;

@WebServlet(name = "SvSecretarios", urlPatterns = {"/SvSecretarios"})
public class SvSecretarios extends HttpServlet {
    
    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Secretario> listaSecretarios = new ArrayList<Secretario>();
        
        listaSecretarios = control.getSecretarios();
        
        HttpSession misession = request.getSession();
        misession.setAttribute("listaSecretarios", listaSecretarios);
        
        response.sendRedirect("verSecretarios.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int unUsuario = (int) request.getSession().getAttribute("id_usuario"); //para pasar la id de usaurio (no es explicacion esto)
        
        String dni = request.getParameter("dniSecre");
        String nombre = request.getParameter("nombreSecre");
        String apellido = request.getParameter("apellidoSecre");
        String telefono = request.getParameter("telefonoSecre");
        String direccion = request.getParameter("direccionSecre");
        String fechaNacParam = request.getParameter("fechaNacSecre");
        String sector = request.getParameter("sectorSecre");

         // Verificación de nulidad y contenido vacío
        if (dni == null || dni.trim().isEmpty()
                || nombre == null || nombre.trim().isEmpty()
                || apellido == null || apellido.trim().isEmpty()
                || telefono == null || telefono.trim().isEmpty()
                || direccion == null || direccion.trim().isEmpty()
                || fechaNacParam == null || fechaNacParam.trim().isEmpty()
                || sector == null || sector.trim().isEmpty()) {

            // Si falta algo, redirige con un mensaje de advertencia
            response.sendRedirect("altaSecretarios.jsp?error=campos_vacios");
            return;
        }
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = null;
        
        try {
            fechaNac = formatter.parse(fechaNacParam);
        } catch (ParseException ex) {
            Logger.getLogger(SvSecretarios.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        control.crearSecretario(dni, nombre, apellido, telefono, direccion, fechaNac, sector, unUsuario);

        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
