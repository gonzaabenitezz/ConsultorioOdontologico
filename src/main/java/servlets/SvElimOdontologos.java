package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;

@WebServlet(name = "SvElimOdontologos", urlPatterns = {"/SvElimOdontologos"})
public class SvElimOdontologos extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //Primero se elimina el Odontologo y despues el usuario
            throws ServletException, IOException {

        //Elimiar Odontologo
        int id = Integer.parseInt(request.getParameter("id"));
        control.borrarOdontologoIntegral(id);

        response.sendRedirect("SvOdontologos");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
