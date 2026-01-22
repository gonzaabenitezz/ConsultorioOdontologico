<%@page import="logica.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<div class="container-fluid">

    <h1 class="h3 mb-2 text-gray-800">Ver Usuarios</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de usuarios registrados en el sistema.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Usuarios</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>Id</th>
                            <th>Nombre de Usuario</th>
                            <th>Rol</th>
                            <th style="width: 120px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Usuario> listaUsuarios = (List) request.getSession().getAttribute("listaUsuarios");
                            for (Usuario usu : listaUsuarios) {
                        %>
                        <tr class="text-dark">
                            <td class="text-center font-weight-bold"><%= usu.getId_usuario()%></td>
                            <td><%= usu.getNombreUsuario()%></td>
                            <td class="text-center">
                                <span class="badge badge-info p-2" style="min-width: 90px;">
                                    <%= usu.getRol()%>
                                </span>
                            </td>

                            <td>
                                <div class="d-flex justify-content-center">
                                    <form action="SvEditUsuarios" method="GET" class="mr-2">
                                        <input type="hidden" name="id" value="<%=usu.getId_usuario()%>">
                                        <button type="submit" class="btn btn-info btn-sm shadow-sm" title="Editar">
                                            <i class="fas fa-pencil-alt"></i>
                                        </button>
                                    </form>

                                    <form action="SvElimUsuarios" method="POST">
                                        <input type="hidden" name="id" value="<%=usu.getId_usuario()%>">
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