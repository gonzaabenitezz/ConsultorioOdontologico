<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="logica.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Edición de Pacientes</h1>
<p>Este es el apartado para modificar un paciente del sistema.</p>

<%Paciente pac = (Paciente) request.getSession().getAttribute("pasEditar");%> <!-- aca se hace el caste de Usuario para que dfuncione -->
<%Responsable resp = (Responsable) request.getSession().getAttribute("respEditar");%> <!-- aca se hace el caste de Usuario para que dfuncione -->


<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %> <!-- asigna el tipo de formateo -->
<% String fechaFormateada = formatter.format(pac.getFecha_nac());%> <!-- formatea la fecha y la asigna a otra variable -->
<% String fechaFormateadaRes = (resp != null) ? formatter.format(resp.getFecha_nac()) : "" ;%> <!-- formatea la fecha y la asigna a otra variable -->


<p>Paciente</p>
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
        
       
        <br>

        <p>Responsable</p>
        <div class="col-sm-6 mb-3">
            <label for="dnires">DNI Responsable:</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniRes"
                   placeholder="DNI" value="<%= (resp != null) ? resp.getDni(): "" %>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Nombre Responsable:</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreRes"
                   placeholder="Nombre" value="<%= (resp != null) ? resp.getNombre(): "" %>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnires">Apellido Responsable:</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoRes"
                   placeholder="Apellido" value="<%= (resp != null) ? resp.getApellido(): "" %>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Teléfono Responsable:</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoRes"
                   placeholder="Teléfono" value="<%= (resp != null) ? resp.getTelefono(): null %>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnires">Dirección Responsable:</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionRes"
                   placeholder="Dirección" value="<%= (resp != null) ? resp.getDireccion(): null %>">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dnires">Fecha Nacimiento Responsable:</label>
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacRes"
                   placeholder="Fecha Nacimiento" value="<%= fechaFormateadaRes %>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Tipo de Responsable:</label>
            <input type="text" class="form-control form-control-user" id="tipo_resp" name="tipo_respRes"
                   placeholder="Tipo de Responsable" value="<%= (resp != null) ? resp.getTipo_resp(): "" %>">
        </div>
        
    </div>                 
    <button class="btn btn-primary btn-user btn-block" type="submit">
        Guardar Modificación
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>