
<%@page import="logica.Paciente"%>
<%@page import="logica.Odontologo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Turno"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Ver Turnos</h1>
    <p class="mb-4">A continuación podrá visualizar la lista completa de turnos.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Turnos</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Id Pac</th>
                            <th>Dni Pac</th>
                            <th>Nom Pac</th>
                            <th>Apell Pac</th>
                            <th>Id Odon</th>
                            <th>Dni Odon</th>
                            <th>Nom Odon</th>
                            <th>Apell Odon</th>
                            <th>Fecha Turno</th>
                            <th>Hora Turno</th>
                            <th>Afeccion</th>

                            <th style="width:210px">Acción</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>Id Pac</th>
                            <th>Dni Pac</th>
                            <th>Nom Pac</th>
                            <th>Apell Pac</th>
                            <th>Id Odon</th>
                            <th>Dni Odon</th>
                            <th>Nom Odon</th>
                            <th>Apell Odon</th>
                            <th>Fecha Turno</th>
                            <th>Hora Turno</th>
                            <th>Afeccion</th>
                            <th style="width:210px">Acción</th>
                        </tr>
                    </tfoot>

                    <%                        List<Turno> listaTurnos = (List) request.getSession().getAttribute("listaTurnos"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>
                    <%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%> <!-- formatear fecha, asigna el tipo de date que debe ser -->

                    <%
                        List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>

                    <%
                        List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes"); //video 13 min 45.00. getSession va a traer la sesion, getAttribute va a traer de la sesion la listaUsuarios, (List) va a hacer el casteo para que se transforme en una lista y lo va a guardar en la lista listaUsuarios
                    %>


                    <tbody>
                        <%for (Turno tur : listaTurnos) {%>
                        <% Paciente pac = tur.getPacien();%>
                        <% Odontologo odon = tur.getOdonto(); %>
                        <%String fechaFormateada = formatter.format(tur.getFecha_turno());%> <!-- formatear fecha -->


                        <tr>
                            <td id="id_tur<%= tur.getId_turno()%>"> <%= tur.getId_turno()%> </td>  <!--Esta parte del codigo <,%= %,> lo que hace es traer el valor exacto de una variable sin que tengamos que especificar algo mas de codigo --> 
                            <td idpaciente="id_pac<%= (pac != null) ? pac.getId(): "N/A"%>"> <%= (pac != null) ? pac.getId(): "N/A"%></td>
                            <td><%= pac.getDni()%></td>
                            <td><%= pac.getNombre()%></td>
                            <td><%= pac.getApellido()%></td>

                            <td idodontologo="id_odon<%= (odon != null) ? odon.getId(): "N/A"%>"> <%= (odon != null) ? odon.getId(): "N/A"%></td>
                            <td><%= odon.getDni()%></td>
                            <td><%= odon.getNombre()%></td>
                            <td><%= odon.getApellido()%></td>

                            <td> <%= fechaFormateada%> </td> <!-- Si la fecha u otro dato que se formaté o se le realiza un cambio puede tener un error -->                              

                            
                            <td> <%= tur.getHora_turno()%> </td> 
                            <td> <%= tur.getAfeccion()%> </td> 



                            <td style="display: flex; width: 230px">
                                <form name="eliminar" action="SvElimTurnos" method="POST"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="background-color: red; margin-right:5px;">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                    <input type="hidden" name="id" value="<%=tur.getId_turno()%>"> <!-- esto se conecta con el POST de SvelimPacientes para poder eliminar al paciente con esta id-->
                                    <!-- si idresp es null devuelve un valor vacio, si no, devuelve la id del responsable. E<!--sto se conecta con el POST de SvelimPacientes para poder eliminar al responsable con esta id -->
                                </form>
                                <form name="editar" action="SvEditTurnos" method="GET"> <!--esto es para mandar el codigo al servlet-->
                                    <button type="submit" class="btn btn-primary btn-user btn-block" style="margin-left: 5px">
                                        <i class="fas fa-pencil-alt"></i> Editar
                                    </button>
                                    <input type="hidden" name="id" value="<%=tur.getId_turno()%>">
                                    <input type="hidden" name="idpaciente" value="<%= (pac != null) ? pac.getId(): ""%>"> 
                                    <input type="hidden" name="idodontologo" value="<%= (odon != null) ? odon.getId(): ""%>">
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