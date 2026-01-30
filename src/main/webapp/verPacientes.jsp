<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<div class="container-fluid">

    <h1 class="h3 mb-2 text-gray-800">Ver Pacientes</h1>
    <p class="mb-4">Haga clic en el botón del responsable para ver sus detalles.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Pacientes</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>ID</th>
                            <th>Nombre Completo</th>
                            <th>DNI</th>
                            <th>Nacimiento</th>
                            <th>Teléfono</th>
                            <th>O. Social</th>
                            <th>Sangre</th>
                            <th class="text-center">Responsable</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes");
                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                            for (Paciente pac : listaPacientes) {
                                Responsable resp = pac.getUnResponsable();
                                String targetId = "respData" + pac.getId(); // ID único para el colapso
                        %>
                        <tr>
                            <td><%= pac.getId()%></td>
                            <td><strong><%= pac.getApellido()%>, <%= pac.getNombre()%></strong></td>
                            <td><%= pac.getDni()%></td>
                            <td><%= (pac.getFecha_nac() != null) ? formatter.format(pac.getFecha_nac()) : "N/A"%></td>
                            <td><%= pac.getTelefono()%></td>
                            <td class="text-center">
                                <span class="badge <%= pac.isTiene_OS() ? "badge-success" : "badge-secondary"%>">
                                    <%= pac.isTiene_OS() ? "Si" : "No"%>
                                </span>
                            </td>
                            <td><%= pac.getTipoSangre()%></td>

                            <td class="text-center">
                                <% if (resp != null) {%>
                                <button class="btn btn-sm btn-outline-primary" type="button" data-toggle="collapse" data-target="#<%= targetId%>" aria-expanded="false">
                                    <i class="fas fa-user-shield"></i> Ver Info
                                </button>
                                <% } else { %>
                                <span class="text-muted small">Sin Resp.</span>
                                <% }%>
                            </td>

                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="SvEditPacientes" method="GET" class="mr-1">
                                        <input type="hidden" name="id" value="<%=pac.getId()%>">
                                        <button type="submit" class="btn btn-info btn-sm"><i class="fas fa-pencil-alt"></i></button>
                                    </form>
                                    <form action="SvElimPacientes" method="POST">
                                        <input type="hidden" name="id" value="<%=pac.getId()%>">
                                        <input type="hidden" name="idresp" value="<%= (resp != null) ? resp.getId() : ""%>">
                                        <button type="submit" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <% if (resp != null) {%>
                        <tr class="collapse" id="<%= targetId%>">
                            <td colspan="9" class="bg-light">
                                <div class="p-3 border rounded shadow-sm bg-white">
                                    <h6 class="font-weight-bold text-primary border-bottom pb-2">Datos del Responsable</h6>
                                    <div class="row">
                                        <div class="col-md-3"><strong>ID:</strong> <%= resp.getId()%></div>
                                        <div class="col-md-3"><strong>Nombre:</strong> <%= resp.getNombre()%> <%= resp.getApellido()%></div>
                                        <div class="col-md-3"><strong>DNI:</strong> <%= resp.getDni()%></div>
                                        <div class="col-md-3"><strong>Tipo:</strong> <%= resp.getTipo_resp()%></div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-3"><strong>Teléfono:</strong> <%= resp.getTelefono()%></div>
                                        <div class="col-md-6"><strong>Dirección:</strong> <%= resp.getDireccion()%></div>
                                        <div class="col-md-3"><strong>F. Nac:</strong> <%= (resp.getFecha_nac() != null) ? formatter.format(resp.getFecha_nac()) : "N/A"%></div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <% } %>

                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@include file="components/bodyfinal.jsp" %>