package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;

@WebServlet(name = "SvElimUsuarios", urlPatterns = {"/SvElimUsuarios"})
public class SvElimUsuarios extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Obtener sesión de odontólogo
        HttpSession sessionOdonto = request.getSession(false); // false = no crear nueva sesión

        try {

            if (sessionOdonto == null) {
                throw new ServletException("No hay sessión activa");
            }

            // 2. Obtener atributo de sesión
            Integer id = (Integer) sessionOdonto.getAttribute("idUsuarioEliminar");
            //Integer idhor = (Integer) sessionOdonto.getAttribute("idHorarioEliminar");

            if (id == null) {
                throw new ServletException("No se encontró ID de usuario en la sessión");
            }

            // 3. Limpiar la sesión, ahora no xq sino se elimina la id de horario
            sessionOdonto.removeAttribute("idUsuarioEliminar");

            // 4. Procesar la eliminación
            control.borrarUsuario(id);

            // 5. Redirigir
            request.getRequestDispatcher("SvElimHorarios").forward(request, response);

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
