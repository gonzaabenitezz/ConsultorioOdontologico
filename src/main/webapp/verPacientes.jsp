<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Ver Pacientes</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de pacientes.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Pacientes</h6>
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
                            <th>Obra Social</th>
                            <th>Tipo de Sangre</th>
                            <th>Id Res</th>
                            <th>Dni Res</th>
                            <th>Nombre Res</th>
                            <th>Apellido Res</th>
                            <th>Telefono Res</th>
                            <th>Dirección Res</th>
                            <th>Fecha de Nacimiento Res</th>
                            <th>Tipo Res</th>

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
                            <th>Obra Social</th>
                            <th>Tipo de Sangre</th>
                            <th>Id Res</th>
                            <th>Dni Res</th>
                            <th>Nombre Res</th>
                            <th>Apellido Res</th>
                            <th>Telefono Res</th>
                            <th>Dirección Res</th>
                            <th>Fecha de Nacimiento Res</th>
                            <th>Tipo Res</th>
                            <th style="width:210px">Acción</th>
                        </tr>
                    </tfoot>

                    <%                       
                        List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>
                    <%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%> <!-- formatear fecha, asigna el tipo de date que debe ser -->



                    <tbody>
                        <%for (Paciente pac : listaPacientes) {%>
                        <%Responsable resp = pac.getUnResponsable();%>
                        <% String tieneOSString = (pac.isTiene_OS()) ? "Si" : "No"; %> <!-- pasar boolean a string-->
                        <%String fechaFormateada = formatter.format(pac.getFecha_nac());%> <!-- formatear fecha -->
                        <%String fechaFormateadaRes = (resp != null) ? formatter.format(resp.getFecha_nac()) : "N/A";%>

                        <tr>
                            <td id="id_pac<%= pac.getId()%>"> <%= pac.getId()%> </td>  <!--Esta parte del codigo <,%= %,> lo que hace es traer el valor exacto de una variable sin que tengamos que especificar algo mas de codigo --> 
                            <td><%= pac.getDni()%></td>
                            <td><%= pac.getNombre()%></td>
                            <td><%= pac.getApellido()%></td>
                            <td> <%= pac.getTelefono()%> </td>
                            <td> <%= pac.getDireccion()%> </td> 
                            <td> <%= fechaFormateada%> </td> <!-- Si la fecha u otro dato que se formaté o se le realiza un cambio puede tener un error -->
                            <td> <%= tieneOSString%> </td> 
                            <td> <%= pac.getTipoSangre()%> </td>                         
                            <td idresp="id_resp<%= (resp != null) ? resp.getId() : "N/A"%>"> <%= (resp != null) ? resp.getId() : "N/A"%> </td> <!-- mientras idresp no devuelva null, mostrara la id del responsable -->
                            <td><%= (resp != null) ? resp.getDni() : "N/A"%></td>
                            <td><%= (resp != null) ? resp.getNombre() : "N/A"%></td>
                            <td><%= (resp != null) ? resp.getApellido() : "N/A"%></td>
                            <td> <%= (resp != null) ? resp.getTelefono() : "N/A"%> </td>
                            <td> <%= (resp != null) ? resp.getDireccion() : "N/A"%> </td> 
                            <td> <%= fechaFormateadaRes%> </td> <!-- Si la fecha u otro dato que se formaté o se le realiza un cambio puede tener un error -->
                            <td> <%= (resp != null) ? resp.getTipo_resp() : "N/A"%> </td>



                            <td style="display: flex; width: 230px">
                                <form name="eliminar" action="SvElimPacientes" method="POST"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="background-color: red; margin-right:5px;">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                    <input type="hidden" name="id" value="<%=pac.getId()%>"> <!-- esto se conecta con el POST de SvelimPacientes para poder eliminar al paciente con esta id-->
                                    <input type="hidden" name="idresp" value="<%= (resp != null) ? resp.getId() : "" %>"> <!-- si idresp es null devuelve un valor vacio, si no, devuelve la id del responsable. Esto se conecta con el POST de SvelimPacientes para poder eliminar al responsable con esta id -->
                                </form>
                                <form name="editar" action="SvEditPacientes" method="GET"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="margin-left: 5px">
                                        <i class="fas fa-pencil-alt"></i> Editar
                                    </button>
                                    <input type="hidden" name="id" value="<%=pac.getId()%>">
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