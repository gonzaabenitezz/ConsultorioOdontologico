<%@page import="logica.Odontologo"%>
<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Ver Odontologos</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de odontologos.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Odontologos</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Dni</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Telefono</th>
                            <th>Dirección</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Especialidad</th>

                            <th style="width:210px">Acción</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>Dni</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Telefono</th>
                            <th>Dirección</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Especialidad</th>
                            
                            <th style="width:210px">Acción</th>
                        </tr>
                    </tfoot>

                    <%                       
                        List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>
                    <%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%> <!-- formatear fecha, asigna el tipo de date que debe ser -->



                    <tbody>
                        <%for (Odontologo odon : listaOdontologos) {%>
                        <%String fechaFormateada = formatter.format(odon.getFecha_nac());%> <!-- formatear fecha -->

                        <tr>
                            <td id="id_odon<%= odon.getId()%>"> <%= odon.getId()%> </td>  <!--Esta parte del codigo <,%= %,> lo que hace es traer el valor exacto de una variable sin que tengamos que especificar algo mas de codigo --> 
                            <td><%= odon.getDni()%></td>
                            <td><%= odon.getNombre()%></td>
                            <td><%= odon.getApellido()%></td>
                            <td> <%= odon.getTelefono()%> </td>
                            <td> <%= odon.getDireccion()%> </td> 
                            <td> <%= fechaFormateada%> </td> <!-- Si la fecha u otro dato que se formaté o se le realiza un cambio puede tener un error -->
                            <td> <%= odon.getEspecialidad()%> </td>                         
                            



                            <td style="display: flex; width: 230px">
                                <form name="eliminar" action="SvElimOdontologos" method="POST"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="background-color: red; margin-right:5px;">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                    <input type="hidden" name="id" value="<%=odon.getId()%>"> <!-- esto se conecta con el POST de SvelimPacientes para poder eliminar al paciente con esta id-->
                                </form>
                                <form name="editar" action="SvEditOdontologos" method="GET"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="margin-left: 5px">
                                        <i class="fas fa-pencil-alt"></i> Editar
                                    </button>
                                    <input type="hidden" name="id" value="<%=odon.getId()%>">
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