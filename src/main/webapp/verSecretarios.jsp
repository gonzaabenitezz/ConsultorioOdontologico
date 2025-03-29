<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Secretario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Ver Secretarios</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de secretarios.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Secretarios</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>DNI</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Telefono</th>
                            <th>Direccion</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Sector</th>
                            <th style="width:210px">Acción</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>DNI</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Telefono</th>
                            <th>Direccion</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Sector</th>
                            <th style="width:210px">Acción</th>
                        </tr>
                    </tfoot>

                    <%                       
                        List<Secretario> listaSecretarios = (List) request.getSession().getAttribute("listaSecretarios"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>
                    <%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%>

                    <tbody>
                        <%for (Secretario secre : listaSecretarios) {%>
                        <%String fechaFormateada = formatter.format(secre.getFecha_nac());%>
                        <tr>
                            <td id="id_usu<%= secre.getId()%>"> <%= secre.getId()%> </td>  <!--Esta parte del codigo <,%= %,> lo que hace es traer el valor exacto de una variable sin que tengamos que especificar algo mas de codigo --> 
                            <td> <%= secre.getDni()%> </td>
                            <td> <%= secre.getNombre()%> </td>
                            <td> <%= secre.getApellido()%> </td>
                            <td> <%= secre.getTelefono()%> </td>
                            <td> <%= secre.getDireccion()%> </td>
                            <td> <%= fechaFormateada %> </td>
                            <td> <%= secre.getSector()%> </td>

                            <td style="display: flex; width: 230px">
                                <form name="eliminar" action="SvElimSecretarios" method="POST"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="background-color: red; margin-right:5px;">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                    <input type="hidden" name="id" value="<%=secre.getId()%>">
                                </form>
                                <form name="editar" action="SvEditSecretarios" method="GET"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="margin-left: 5px">
                                        <i class="fas fa-pencil-alt"></i> Editar
                                    </button>
                                    <input type="hidden" name="id" value="<%=secre.getId()%>">
                                </form>
                            </td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->


<%@include file="components/bodyfinal.jsp" %>