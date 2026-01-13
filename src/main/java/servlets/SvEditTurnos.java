package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Turno;

@WebServlet(name = "SvEditTurnos", urlPatterns = {"/SvEditTurnos"})
public class SvEditTurnos extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Turno tur = control.traerTurno(id);
        HttpSession misession = request.getSession();

        misession.setAttribute("turnoEditar", tur);

        response.sendRedirect("editarTurnos.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fecha = request.getParameter("fechaTurno");
        String horaTurno = request.getParameter("horaTurno");
        String afeccion = request.getParameter("afeccion");

        // Verificación de nulidad y contenido vacío
        if (fecha == null || fecha.trim().isEmpty()
                || horaTurno == null || horaTurno.trim().isEmpty()
                || afeccion == null || afeccion.trim().isEmpty()) {

            // Si falta algo, redirige con un mensaje de advertencia
            response.sendRedirect("editarTurnos.jsp?error=campos_vacios");
            return;
        }

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaTurno = null;

        try {
            fechaTurno = formatter.parse(fecha);
        } catch (ParseException ex) {
            Logger.getLogger(SvSecretarios.class.getName()).log(Level.SEVERE, null, ex);
        }

        Turno tur = (Turno) request.getSession().getAttribute("turnoEditar");
        tur.setFecha_turno(fechaTurno);
        tur.setHora_turno(horaTurno);
        tur.setAfeccion(afeccion);

        control.editarTurno(tur);
        response.sendRedirect("SvTurnos");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
