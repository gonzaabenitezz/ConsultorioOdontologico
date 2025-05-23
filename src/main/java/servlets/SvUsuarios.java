package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Usuario;

@WebServlet(name = "SvUsuarios", urlPatterns = {"/SvUsuarios"})
public class SvUsuarios extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Usuario> listaUsuarios = new ArrayList<Usuario>();

        listaUsuarios = control.getUsuarios(); //listaUsuarios almacena el resultado de control.getUsuarios

        HttpSession misession = request.getSession();
        misession.setAttribute("listaUsuarios", listaUsuarios); // el name "listaUsuarios" es una especie de alias. Esto hace que despues de que listaUsuarios se guarde (linea 30), esa misma lista se guardara como un atributo de session, eso hace que por mas que estemos fuera del servlet u otra cosa, realizara de igual manera la consulta

        response.sendRedirect("verUsuarios.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreUsuario = request.getParameter("nombreusu");
        String contra = request.getParameter("contrasenia");
        String rol = request.getParameter("rol");

        int id_usuario  = control.crearUsuario(nombreUsuario, contra, rol);
        
        HttpSession idsession = request.getSession();
        idsession.setAttribute("id_usuario", id_usuario);
        
        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
