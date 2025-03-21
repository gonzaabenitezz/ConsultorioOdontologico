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
import logica.Responsable;

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
        // int idRes = Integer.parseInt(request.getParameter("unResponsable_id")); borrar esto no anda
        Responsable resp = pas.getUnResponsable();

        //System.out.println("Nombre: " + pas.getNombre());
        //System.out.println("id responsable: " + pas.getUnResponsable());//prueba para ver si trae los datos 
        HttpSession misession = request.getSession();
        misession.setAttribute("pasEditar", pas);
        misession.setAttribute("respEditar", resp);

        response.sendRedirect("editarPacientes.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //Para guardar los datos primero debe pasarlos correctamente, el string de fechanac a date y el de tieneOS a boolean
            throws ServletException, IOException {

        //Datos Pacientes
        String dni = request.getParameter("dnipas");
        String nombre = request.getParameter("nombrepas");
        String apellido = request.getParameter("apellidopas");
        String telefono = request.getParameter("telefonopas");
        String direccion = request.getParameter("direccionpas");
        String fechaNacString = request.getParameter("fechanacpas");
        String tieneOSString = request.getParameter("obrasocialpas");
        String tipoSangre = request.getParameter("tiposangrepas");

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

        if (dniRes != null && !dniRes.isEmpty()) {
            Responsable resp = (Responsable) request.getSession().getAttribute("respEditar");
            if (resp != null) {
                resp.setDni(dniRes);
                resp.setNombre(nombreRes);
                resp.setApellido(apellidoRes);
                resp.setTelefono(telefonoRes);
                resp.setDireccion(direccionRes);
                resp.setFecha_nac(fechaNacRes);
                resp.setTipo_resp(tipoRes);

                control.editarResponsable(resp);
            } else {
                        throw new IllegalStateException("Error: No se encontró el objeto 'respEditar' en la sesión.");
            }
        }

        response.sendRedirect("SvPacientes");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
