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
import logica.Horario;
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

        try {
            // 1. Validar parámetros
            String idParam = request.getParameter("id");
            String idHorarioParam = request.getParameter("idhorario");

            if (idParam == null || idParam.trim().isEmpty()) {
                throw new ServletException("El ID del odontólogo es requerido.");
            }
            if (idHorarioParam == null || idHorarioParam.trim().isEmpty()) {
                throw new ServletException("El ID del horario es requerido.");
            }

            // 2. Parsear a enteros
            int id = Integer.parseInt(idParam);
            int idhorario = Integer.parseInt(idHorarioParam);

            // 3. Obtener datos de la base de datos
            Odontologo odon = control.traerOdontologo(id);
            Horario hor = control.traerHorario(idhorario);

            if (odon == null || hor == null) {
                throw new ServletException("No se encontraron datos para editar.");
            }

            // 4. Guardar en sesión
            HttpSession misession = request.getSession();
            misession.setAttribute("odonEditar", odon);
            misession.setAttribute("horEditar", hor);

            // 5. Redirigir
            response.sendRedirect("editarOdontologos.jsp");

        } catch (NumberFormatException e) {
            throw new ServletException("Los IDs deben ser números válidos.", e);
        }

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

        try {

            //Horario
            HttpSession sessionHorario = request.getSession();

            //Procesar horario
            String inicioHorOdon = request.getParameter("inicioHorOdon");
            String finHorOdon = request.getParameter("finHorOdon");

            // Verificación de nulidad y contenido vacío
            if (inicioHorOdon == null || inicioHorOdon.trim().isEmpty()
                    || finHorOdon == null || finHorOdon.trim().isEmpty()
                    || dniOdon == null || dniOdon.trim().isEmpty()
                    || nombreOdon == null || nombreOdon.trim().isEmpty()
                    || apellidoOdon == null || apellidoOdon.trim().isEmpty()
                    || telefonoOdon == null || telefonoOdon.trim().isEmpty()
                    || direccionOdon == null || direccionOdon.trim().isEmpty()
                    || fechaNacOdonString == null || fechaNacOdonString.trim().isEmpty()
                    || especialidadOdon == null || especialidadOdon.trim().isEmpty()) {

                // Si falta algo, redirige con un mensaje de advertencia
                response.sendRedirect("editarOdontologos.jsp?error=campos_vacios");
                return;
            }

            //Guardar horario en session y redirigir a SvEditHorarios
            sessionHorario.setAttribute("inicioHorario", inicioHorOdon);
            sessionHorario.setAttribute("finHorario", finHorOdon);
            request.getRequestDispatcher("SvEditHorarios").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error al procesar horario: " + e.getMessage(), e);
        }

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

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
