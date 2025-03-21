package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;

@WebServlet(name = "SvElimPacientes", urlPatterns = {"/SvElimPacientes"})
public class SvElimPacientes extends HttpServlet {

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

        int id = Integer.parseInt(request.getParameter("id"));

        String idrespParam = request.getParameter("idresp");
        control.borrarPaciente(id); //debe ir primero esto xq si se trata de borrar primero el responsable se eliminaria la union por la clave foranea que esta en el paciente (unResponsable) y eso daria error
        if(idrespParam != null && !idrespParam.isEmpty()){
            int idresp = Integer.parseInt(idrespParam);
            control.borrarResponsable(idresp);
        }

        response.sendRedirect("SvPacientes");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
