package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Odontologo;
import logica.Usuario;

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

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

        String usuario = request.getParameter("usuario");
        String contrasenia = request.getParameter("contrasenia");

        Usuario usu = control.comprobarIngreso(usuario, contrasenia);

        if (usu != null) {
            HttpSession missesion = request.getSession(true);
            missesion.setAttribute("usuario", usuario);
            missesion.setAttribute("rol", usu.getRol());
            if ("odontologo".equalsIgnoreCase(usu.getRol())) {
                Odontologo odon = control.getOdontologos()
                        .stream()
                        .filter(o -> o.getUnUsuario().getId_usuario() == usu.getId_usuario())
                        .findFirst()
                        .orElse(null);
                if (odon != null) {
                    missesion.setAttribute("id", odon.getId());
                }
            }

            response.sendRedirect("index.jsp");  //EXPLICACION DE ESTO EN EL VIDEO 14 MIN 28.00
        } else {
            response.sendRedirect("loginError.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
