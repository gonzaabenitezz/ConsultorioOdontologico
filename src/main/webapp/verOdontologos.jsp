<%@page import="logica.Horario"%>
<%@page import="logica.Usuario"%>
<%@page import="logica.Odontologo"%>
<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<div class="container-fluid">

    <h1 class="h3 mb-2 text-gray-800">Ver Odontólogos</h1>
    <p class="mb-4">Haga clic en el botón de detalles para consultar el horario y usuario asignado.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Odontólogos</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Dni</th>
                            <th>Nacimiento</th>
                            <th>Teléfono</th>
                            <th>Especialidad</th>
                            <th>Gestión Laboral</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos");
                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                            for (Odontologo odon : listaOdontologos) {
                                Usuario usu = odon.getUnUsuario();
                                Horario hor = odon.getUnHorario();
                                String targetId = "infoOdon" + odon.getId();
                                String fechaFormateada = (odon.getFecha_nac() != null) ? formatter.format(odon.getFecha_nac()) : "N/A";
                        %>
                        <tr class="text-dark">
                            <td class="text-center font-weight-bold"><%= odon.getId()%></td>
                            <td><%= odon.getNombre()%></td>
                            <td><%= odon.getApellido()%></td>
                            <td><%= odon.getDni()%></td>
                            <td><%= fechaFormateada%></td>
                            <td><%= odon.getTelefono()%></td>
                            <td><span class="badge badge-primary p-2"><%= odon.getEspecialidad()%></span></td>

                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-info shadow-sm" type="button" data-toggle="collapse" data-target="#<%= targetId%>">
                                    <i class="fas fa-clock"></i> Ver Horario/Usu
                                </button>
                            </td>

                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="SvEditOdontologos" method="GET" class="mr-2">
                                        <input type="hidden" name="id" value="<%=odon.getId()%>">
                                        <input type="hidden" name="idhorario" value="<%= (hor != null) ? hor.getId_horario() : ""%>">
                                        <button type="submit" class="btn btn-info btn-sm shadow-sm">
                                            <i class="fas fa-pencil-alt"></i>
                                        </button>
                                    </form>
                                    <form action="SvElimOdontologos" method="POST">
                                        <input type="hidden" name="id" value="<%=odon.getId()%>">
                                        <button type="submit" class="btn btn-danger btn-sm shadow-sm">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <tr class="collapse" id="<%= targetId%>">
                            <td colspan="9" class="bg-light">
                                <div class="p-3 border-left-info shadow-sm bg-white rounded">
                                    <div class="row text-center">
                                        <div class="col-md-4 border-right">
                                            <h6 class="font-weight-bold text-info"><i class="fas fa-user-circle"></i> Cuenta de Usuario</h6>
                                            <p class="mb-0">ID Usuario: <span class="badge badge-light"><%= (usu != null) ? usu.getId_usuario() : "N/A"%></span></p>
                                        </div>
                                        <div class="col-md-8">
                                            <h6 class="font-weight-bold text-info"><i class="fas fa-calendar-alt"></i> Horario de Atención</h6>
                                            <div class="d-flex justify-content-around mt-2">
                                                <div><strong>ID Horario:</strong> <%= (hor != null) ? hor.getId_horario() : "N/A"%></div>
                                                <div><strong>Entrada:</strong> <span class="text-success"><%= (hor != null) ? hor.getHorario_inicio() : "N/A"%></span></div>
                                                <div><strong>Salida:</strong> <span class="text-danger"><%= (hor != null) ? hor.getHorario_fin() : "N/A"%></span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-2 small text-muted text-center border-top pt-2">
                                        <strong>Dirección registrada:</strong> <%= odon.getDireccion()%>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@include file="components/bodyfinal.jsp" %>