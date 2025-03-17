<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="logica.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Edición de Pacientes</h1>
<p>Este es el apartado para modificar un paciente del sistema.</p>

<%Paciente pac = (Paciente) request.getSession().getAttribute("pasEditar");%> <!-- aca se hace el caste de Usuario para que dfuncione -->

<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %> <!-- asigna el tipo de formateo -->
<% String fechaFormateada = formatter.format(pac.getFecha_nac());%> <!-- formatea la fecha y la asigna a otra variable -->

<form class="user" action="SvEditPacientes" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dnipas">DNI:</label>
            <input type="number" class="form-control form-control-user" id="dnipas" name="dnipas"
                   placeholder="Dni" value="<%=pac.getDni()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="nombrepas">Nombre:</label>
            <input type="text" class="form-control form-control-user" id="nombrepas" name="nombrepas"
                   placeholder="Nombre" value="<%=pac.getNombre()%>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="apellidopas">Apellido:</label>
            <input type="text" class="form-control form-control-user" id="apellidopas" name="apellidopas"
                   placeholder="Apellido" value="<%=pac.getApellido()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="telefonopas">Telefono:</label>
            <input type="text" class="form-control form-control-user" id="telefonopas" name="telefonopas"
                   placeholder="Telefono" value="<%=pac.getTelefono()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="direccionpas">Dirección:</label>
            <input type="text" class="form-control form-control-user" id="direccionpas" name="direccionpas"
                   placeholder="Dirección" value="<%=pac.getDireccion()%>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="fechanacpas">Fecha de Nacimiento:</label>
            <input type="date" class="form-control form-control-user" id="fechanacpas" name="fechanacpas"
                   placeholder="Fecha de Nacimiento" value="<%= fechaFormateada%>"> <!-- variable formateada -->
        </div>
        <div class="col-sm-6 mb-3">
            <label for="obrasocialpas">Obra Social:</label>
            <input type="text" class="form-control form-control-user" id="obrasocialpas" name="obrasocialpas"
                   placeholder="Obra Social" value="<%= pac.isTiene_OS()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="tiposangrepas">Tipo de Sangre:</label>
            <input type="text" class="form-control form-control-user" id="tiposangrepas" name="tiposangrepas"
                   placeholder="Tipo de Sangre" value="<%=pac.getTipoSangre()%>">
        </div>
    </div>                 
    <button class="btn btn-primary btn-user btn-block" type="submit">
        Guardar Modificación
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>