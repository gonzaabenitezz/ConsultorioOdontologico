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
        control.borrarOdontologo(id);
        HttpSession sessionOdonto = request.getSession();

        try {//Eliminar Usuario            
            // 1. Obtener parámetros
            String idusuodonto = request.getParameter("idusuodonto");
            String idhorario = request.getParameter("idhorario");

            if (idusuodonto == null || idusuodonto.trim().isEmpty()) { //si el parámetro es null o si está vacío después de quitar espacios   
                throw new ServletException("ID de usuario Odontólogo no proporcionado");
            }
            if (idhorario == null || idhorario.trim().isEmpty()) { //si el parámetro es null o si está vacío después de quitar espacios   
                throw new ServletException("Horario de Odontólogo no proporcionado");
            }

            // 2. Validar que sea un número
            int idusu;
            int idhor;

            try {
                idusu = Integer.parseInt(idusuodonto);
                idhor = Integer.parseInt(idhorario);
            } catch (Exception e) {
                throw new ServletException("ID de usuario Odontólogo no valido: " + idusuodonto + " " + "ID de horario no valido: " + idhorario);
            }

            // 3. Guardar en sesión (como Integer)
            sessionOdonto.setAttribute("idUsuarioEliminar", idusu); // Se gaurda como Integer
            sessionOdonto.setAttribute("idHorarioEliminar", idhor);

            // 4. Usar forward en lugar de redirect para mantener la sesión
            request.getRequestDispatcher("SvElimUsuarios").forward(request, response);
            //response.sendRedirect("SvElimUsuarios");
        } catch (Exception e) {
            throw new ServletException("Ocurrió un error al eliminar el usuario: " + e.getMessage());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
