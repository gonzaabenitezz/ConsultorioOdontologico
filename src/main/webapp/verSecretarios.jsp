<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Secretario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<div class="container-fluid">

    <h1 class="h3 mb-2 text-gray-800">Ver Secretarios</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de secretarios registrados en el sistema.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Secretarios</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>DNI</th>
                            <th>Nacimiento</th>
                            <th>Teléfono</th>
                            <th>Dirección</th>
                            <th>Sector</th>
                            <th style="width: 120px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Secretario> listaSecretarios = (List) request.getSession().getAttribute("listaSecretarios");
                            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

                            for (Secretario secre : listaSecretarios) {
                                String fechaFormateada = (secre.getFecha_nac() != null) ? formatter.format(secre.getFecha_nac()) : "N/A";
                        %>
                        <tr class="text-dark">
                            <td class="text-center font-weight-bold"><%= secre.getId()%></td>
                            <td><%= secre.getNombre()%></td>
                            <td><%= secre.getApellido()%></td>
                            <td class="text-center"><%= secre.getDni()%></td>
                            <td class="text-center"><%= fechaFormateada%></td>
                            <td><%= secre.getTelefono()%></td>
                            <td><%= secre.getDireccion()%></td>
                            <td class="text-center">
                                <span class="badge badge-primary p-2" style="min-width: 80px;">
                                    <%= secre.getSector()%>
                                </span>
                            </td>

                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="SvEditSecretarios" method="GET" class="mr-2">
                                        <input type="hidden" name="id" value="<%=secre.getId()%>">
                                        <button type="submit" class="btn btn-info btn-sm shadow-sm" title="Editar">
                                            <i class="fas fa-pencil-alt"></i>
                                        </button>
                                    </form>

                                    <form action="SvElimSecretarios" method="POST">
                                        <input type="hidden" name="id" value="<%=secre.getId()%>">
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