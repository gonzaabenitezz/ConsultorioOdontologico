
<%@page import="logica.Paciente"%>
<%@page import="logica.Odontologo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Turno"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <h1 class="h3 mb-2 text-gray-800">Ver Turnos</h1>
    <p class="mb-4">Gestión de citas médicas. Utilice el buscador para filtrar por paciente, odontólogo o fecha.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Turnos</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>ID</th>
                            <th class="bg-primary text-white">Paciente</th>
                            <th class="bg-primary text-white">DNI Pac</th>
                            <th class="bg-info text-white">Odontólogo</th>
                            <th class="bg-info text-white">DNI Odon</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Afección</th>
                            <th style="width: 100px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Turno> listaTurnos = (List) request.getSession().getAttribute("listaTurnos");
                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                            for (Turno tur : listaTurnos) {
                                Paciente pac = tur.getPacien();
                                Odontologo odon = tur.getOdonto();
                                String fechaFormateada = (tur.getFecha_turno() != null) ? formatter.format(tur.getFecha_turno()) : "N/A";
                        %>
                        <tr class="text-dark">
                            <td class="text-center font-weight-bold"><%= tur.getId_turno()%></td>

                            <td>
                                <div class="small font-weight-bold"><%= (pac != null) ? pac.getNombre() + " " + pac.getApellido() : "N/A"%></div>
                                <div class="text-muted small">ID: <%= (pac != null) ? pac.getId() : "-"%></div>
                            </td>
                            <td class="text-center"><%= (pac != null) ? pac.getDni() : "-"%></td>

                            <td>
                                <div class="small font-weight-bold"><%= (odon != null) ? odon.getNombre() + " " + odon.getApellido() : "N/A"%></div>
                                <div class="text-muted small">ID: <%= (odon != null) ? odon.getId() : "-"%></div>
                            </td>
                            <td class="text-center"><%= (odon != null) ? odon.getDni() : "-"%></td>

                            <td class="text-center"><%= fechaFormateada%></td>
                            <td class="text-center">
                                <span class="badge badge-light border shadow-sm">
                                    <i class="far fa-clock text-primary"></i> <%= tur.getHora_turno()%>
                                </span>
                            </td>
                            <td><small><%= tur.getAfeccion()%></small></td>

                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="SvEditTurnos" method="GET" class="mr-1">
                                        <input type="hidden" name="id" value="<%=tur.getId_turno()%>">
                                        <input type="hidden" name="idpaciente" value="<%= (pac != null) ? pac.getId() : ""%>"> 
                                        <input type="hidden" name="idodontologo" value="<%= (odon != null) ? odon.getId() : ""%>">
                                        <button type="submit" class="btn btn-info btn-sm shadow-sm" title="Editar">
                                            <i class="fas fa-pencil-alt"></i>
                                        </button>
                                    </form>
                                    <form action="SvElimTurnos" method="POST">
                                        <input type="hidden" name="id" value="<%=tur.getId_turno()%>">
                                        <button type="submit" class="btn btn-danger btn-sm shadow-sm" title="Eliminar">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
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