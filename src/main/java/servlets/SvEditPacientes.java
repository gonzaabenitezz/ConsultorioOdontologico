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
import logica.Paciente;

@WebServlet(name = "SvEditPacientes", urlPatterns = {"/SvEditPacientes"})
public class SvEditPacientes extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Paciente pas = control.traerPaciente(id);

        //System.out.println("Nombre: " + pas.getNombre());
        //System.out.println("OS: " + pas.getFecha_nac());//prueba para ver si trae los datos 

        HttpSession misession = request.getSession();
        misession.setAttribute("pasEditar", pas);

        response.sendRedirect("editarPacientes.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //Para guardar los datos primero debe pasarlos correctamente, el string de fechanac a date y el de tieneOS a boolean
            throws ServletException, IOException {

        String dni = request.getParameter("dnipas");
        String nombre = request.getParameter("nombrepas");
        String apellido = request.getParameter("apellidopas");
        String telefono = request.getParameter("telefonopas");
        String direccion = request.getParameter("direccionpas");
        String fechaNacString = request.getParameter("fechanacpas");
        String tieneOSString = request.getParameter("obrasocialpas");
        String tipoSangre = request.getParameter("tiposangrepas");

        // Crear un formateador de fecha
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = null;

        try {
            // Convertir el String a Date
            fechaNac = formatter.parse(fechaNacString);
        } catch (ParseException ex) {
            Logger.getLogger(SvPacientes.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean tiene_OS = Boolean.parseBoolean(tieneOSString); // Convertir "true" o "false" a boolean

        Paciente pas = (Paciente) request.getSession().getAttribute("pasEditar");
        pas.setDni(dni);
        pas.setNombre(nombre);
        pas.setApellido(apellido);
        pas.setTelefono(telefono);
        pas.setDireccion(direccion);
        pas.setFecha_nac(fechaNac);
        pas.setTiene_OS(tiene_OS);
        pas.setTipoSangre(tipoSangre);

        control.editarPaciente(pas);

        response.sendRedirect("SvPacientes");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
