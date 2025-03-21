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
import logica.Paciente;

@WebServlet(name = "SvPacientes", urlPatterns = {"/SvPacientes"})
public class SvPacientes extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Paciente> listaPacientes = new ArrayList<Paciente>();
      //  List<Responsable> listaResponsables = new ArrayList<Responsable>();

        listaPacientes = control.getPacientes();
       // listaResponsables = control.getResponsables();

        //for (Paciente pac : listaPacientes) {
        //    System.out.println("Nombre: " + pac.getNombre());
        //    System.out.println("OS: " + pac.isTiene_OS());//prueba para ver si trae los datos 
        //}
        HttpSession misession = request.getSession();
        misession.setAttribute("listaPacientes", listaPacientes); // el name "listaUsuarios" es una especie de alias. Esto hace que despues de que listaUsuarios se guarde (linea 30), esa misma lista se guardara como un atributo de session, eso hace que por mas que estemos fuera del servlet u otra cosa, realizara de igual manera la consulta
       // misession.setAttribute("listaResponsables", listaResponsables);
        
        response.sendRedirect("verPacientes.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //Guarda los datos de altaPacientes.jsp
            throws ServletException, IOException {

        //Datos Pacientes
        String dni = request.getParameter("dnipac");
        String nombre = request.getParameter("nombrepac");
        String apellido = request.getParameter("apellidopac");
        String telefono = request.getParameter("telefonopac");
        String direccion = request.getParameter("direccionpac");
        String fechaNacString = request.getParameter("fechaNacpac");
        String tieneOSString = request.getParameter("tieneOSpac");
        String tipoSangre = request.getParameter("tipoSangrepac");
        //String responsable = request.getParameter("responsable");

        //Datos Responsables
        String dniRes = request.getParameter("dniRes");
        String nombreRes = request.getParameter("nombreRes");
        String apellidoRes = request.getParameter("apellidoRes");
        String telefonoRes = request.getParameter("telefonoRes");
        String direccionRes = request.getParameter("direccionRes");
        String fechaNacStringRes = request.getParameter("fechaNacRes");
        String tipoRes = request.getParameter("tipo_respRes");

        // Crear un formateador de fecha
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = null;
        Date fechaNacRes = null;

        try {
            // Convertir el String a Date
            fechaNac = formatter.parse(fechaNacString);
            fechaNacRes = formatter.parse(fechaNacStringRes);
        } catch (ParseException ex) {
            Logger.getLogger(SvPacientes.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean tieneOS = Boolean.parseBoolean(tieneOSString); // Convertir "true" o "false" a boolean

        control.crearPacienteYResponsable(dni, nombre, apellido, telefono, direccion, fechaNac, tieneOS,
                tipoSangre, dniRes, nombreRes, apellidoRes, telefonoRes, direccionRes, fechaNacRes, tipoRes);

        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
