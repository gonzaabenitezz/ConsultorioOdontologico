<%@page import="logica.Odontologo"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Turno</h1>
<p>Este es el apartado para dar de alta los turnos del sistema.</p>

<form class="user" action="SvTurnos" method="POST">
    <div class="form-group col">     

        <div class="row">
            <!-- Pacientes -->
            <div class="col-md-6">
                <div class="card shadow mb-2">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Pacientes</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                            <table class="table table-bordered" width="100%">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Dni</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes"); %>
                                    <% if (listaPacientes != null && !listaPacientes.isEmpty()) {
                                            for (Paciente pac : listaPacientes) {%>
                                    <tr>
                                        <td><%= pac.getId()%></td>
                                        <td><%= pac.getDni()%></td>
                                        <td><%= pac.getNombre()%></td>
                                        <td><%= pac.getApellido()%></td>
                                        <td>
                                            <input type="radio" name="idPaciente" value="<%= pac.getId()%>" required>
                                        </td>
                                    </tr>
                                    <%  }
                                    } else { %>
                                    <tr><td colspan="5" class="text-center">No hay pacientes registrados</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Odontólogos -->
            <div class="col-md-6">
                <div class="card shadow mb-2">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Odontólogos</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                            <table class="table table-bordered" width="100%">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Especialidad</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String rolOdon = (String) misession.getAttribute("rol");
                                        Integer idOdon = null;
                                        if ("odontologo".equalsIgnoreCase(rolOdon)) {
                                            idOdon = (Integer) misession.getAttribute("id"); // puede ser null si faltara
                                        }
                                        List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos");

                                        if (listaOdontologos != null && !listaOdontologos.isEmpty()) {

                                            // Si es odontólogo, mostrar solo sus datos
                                            if ("odontologo".equalsIgnoreCase(rolOdon)) {
                                                for (Odontologo odon : listaOdontologos) {
                                                    if (idOdon == odon.getId()) {
                                    %>
                                    <tr>
                                        <td><%= odon.getId()%></td>
                                        <td><%= odon.getNombre()%></td>
                                        <td><%= odon.getApellido()%></td>
                                        <td><%= odon.getEspecialidad()%></td>
                                        <td>
                                            <input type="radio" name="idOdontologo" value="<%= odon.getId()%>" required>
                                        </td>
                                    </tr>
                                    <%
                                                break; // detenerse después de mostrar su propio registro
                                            }
                                        }
                                    } // Si es secretario, mostrar todos los odontólogos
                                    else if ("secretario".equalsIgnoreCase(rolOdon) || "administrador".equalsIgnoreCase(rolOdon)) {
                                        for (Odontologo odon : listaOdontologos) {
                                    %>
                                    <tr>
                                        <td><%= odon.getId()%></td>
                                        <td><%= odon.getNombre()%></td>
                                        <td><%= odon.getApellido()%></td>
                                        <td><%= odon.getEspecialidad()%></td>
                                        <td>
                                            <input type="radio" name="idOdontologo" value="<%= odon.getId()%>" required>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    } else {
                                    %>
                                    <tr><td colspan="5" class="text-center">No hay odontólogos registrados</td></tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Fecha, Hora y Afección -->
        <div class="row">
            <div class="col-sm-6 mb-3">
                <label for="fecha">Fecha Turno</label>
                <input type="date" class="form-control" id="fechaTurno" name="fechaTurno" min="<%= java.time.LocalDate.now()%>" required>
            </div>
            <div class="col-sm-6 mb-3">
                <label for="hora">Hora Turno</label>
                <input type="time" class="form-control" id="horaTurno" name="horaTurno" min="07:00" step="1800" required>
            </div>
            <div class="col-sm-12 mb-3">
                <label for="afeccion">Afección</label>
                <input type="text" class="form-control" id="afeccion" name="afeccion" placeholder="Describa la afección o motivo de la consulta" required>
            </div>
        </div>

        <button class="btn btn-primary btn-user btn-block" type="submit">Crear Turno</button>
    </div>
</form>

<%@include file="components/bodyfinal.jsp" %>