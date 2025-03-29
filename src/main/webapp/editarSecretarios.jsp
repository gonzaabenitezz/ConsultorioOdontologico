<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Secretario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>
    
<h1>Edición de Secretarios</h1>
<p>Este es el apartado para modificar un secretario del sistema.</p>
    
<%Secretario secre  = (Secretario) request.getSession().getAttribute("secreEditar");%> <!-- aca se hace el caste de Usuario para que dfuncione -->

<%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%>
<% String fechaFormateada = formatter.format(secre.getFecha_nac());%>     


<form class="user" action="SvEditSecretarios" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dnipas">DNI:</label>
            <input type="number" class="form-control form-control-user" id="dnipas" name="dnisecre"
                   placeholder="Dni" value="<%=secre.getDni()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="nombrepas">Nombre:</label>
            <input type="text" class="form-control form-control-user" id="nombrepas" name="nombresecre"
                   placeholder="Nombre" value="<%=secre.getNombre() %>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="apellidopas">Apellido:</label>
            <input type="text" class="form-control form-control-user" id="apellidopas" name="apellidosecre"
                   placeholder="Apellido" value="<%=secre.getApellido()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="telefonopas">Telefono:</label>
            <input type="text" class="form-control form-control-user" id="telefonopas" name="telefonosecre"
                   placeholder="Telefono" value="<%=secre.getTelefono()%>">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="direccionpas">Dirección:</label>
            <input type="text" class="form-control form-control-user" id="direccionpas" name="direccionsecre"
                   placeholder="Dirección" value="<%=secre.getDireccion()%>">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="fechanacpas">Fecha de Nacimiento:</label>
            <input type="date" class="form-control form-control-user" id="fechanacpas" name="fechanacsecre"
                   placeholder="Fecha de Nacimiento" value="<%= fechaFormateada%>"> <!-- variable formateada -->
        </div>
        <div class="col-sm-6 mb-3">
            <label for="fechanacpas">Sector:</label>
            <input type="text" class="form-control form-control-user" id="fechanacpas" name="sectorsecre"
                   placeholder="Sector" value="<%= secre.getSector() %>"> <!-- variable formateada -->
        </div>
    </div>                 
    <button class="btn btn-primary btn-user btn-block" type="submit">
        Guardar Modificación
    </button>
</form>
    
<%@include file="components/bodyfinal.jsp" %>