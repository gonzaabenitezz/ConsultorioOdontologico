package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Horario;

@WebServlet(name = "SvEditHorarios", urlPatterns = {"/SvEditHorarios"})
public class SvEditHorarios extends HttpServlet {

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
        
        
         try {

            HttpSession sessionHorario = request.getSession(false);

            if (sessionHorario == null) {
                throw new ServletException("No hay session activa");
            }

            String inicioHorarioOdon = (String) sessionHorario.getAttribute("inicioHorario");
            String finHorarioOdon = (String) sessionHorario.getAttribute("finHorario");

            if (inicioHorarioOdon == null) {
                throw new ServletException("No se encontro el horario de inicio");
            }
            if (finHorarioOdon == null) {
                throw new ServletException("No se encontro el fin del horario");
            }
            
            
            sessionHorario.removeAttribute("inicioHorario");
            sessionHorario.removeAttribute("finHorario");
            
             Horario hor = (Horario) request.getSession().getAttribute("horEditar");
             hor.setHorario_inicio(inicioHorarioOdon);
             hor.setHorario_fin(finHorarioOdon);
             
             control.editarHorarios(hor);
            
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
