package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;

@WebServlet(name = "SvElimHorarios", urlPatterns = {"/SvElimHorarios"})
public class SvElimHorarios extends HttpServlet {

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

        HttpSession sessionOdonto = request.getSession(false);

        try {

            if (sessionOdonto == null) {
                throw new ServletException("No hay sessión activa");
            }

            Integer id = (Integer) sessionOdonto.getAttribute("idHorarioEliminar");

            if (id == null) {
                throw new ServletException("No se encontro ID de usuario en la sessión");
            }

            sessionOdonto.removeAttribute("idHorarioEliminar");

            control.borrarHorario(id);

            response.sendRedirect("SvOdontologos");

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
