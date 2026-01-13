package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;
import logica.Odontologo;

@WebServlet(name = "SvObtenerHorario", urlPatterns = {"/SvObtenerHorario"})
public class SvObtenerHorario extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idOdon = Integer.parseInt(request.getParameter("idOdontologo"));
        Odontologo odon = control.traerOdontologo(idOdon);

        String inicio = odon.getUnHorario().getHorario_inicio();
        String fin = odon.getUnHorario().getHorario_fin();

        // En SvObtenerHorario.java
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Creacion de JSON manualmente
        String json = "{\"inicio\":\"" + inicio + "\", \"fin\":\"" + fin + "\"}";
        response.getWriter().print(json);
        response.getWriter().flush();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
