package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Usuario;

@WebServlet(name = "SvEditUsuarios", urlPatterns = {"/SvEditUsuarios"})
public class SvEditUsuarios extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usu = control.traerUsuario(id);

        HttpSession missesion = request.getSession();
        missesion.setAttribute("usuEditar", usu);

        response.sendRedirect("editarUsuarios.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreUsu = request.getParameter("nombreusu");
        String contrasenia = request.getParameter("contrasenia");

        // Verificación de nulidad y contenido vacío
        if (nombreUsu == null || nombreUsu.trim().isEmpty()) {
            // Si falta algo, redirige con un mensaje de advertencia
            response.sendRedirect("editarUsuarios.jsp?error=campos_vacios");
            return;
        }

        Usuario usu = (Usuario) request.getSession().getAttribute("usuEditar");
        usu.setNombreUsuario(nombreUsu);
        control.editarUsuario(usu, contrasenia);

        response.sendRedirect("SvUsuarios");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
