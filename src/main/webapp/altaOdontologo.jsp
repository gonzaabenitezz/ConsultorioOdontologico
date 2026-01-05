<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Odontólogos</h1>
<p>Este es el apartado para dar de alta a los odontólogos del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% } %>

<p>Odontólogo</p>
<form class="user" action="SvOdontologos" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniOdon" 
                   placeholder="DNI" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreOdon"
                   placeholder="Nombre" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoOdon"
                   placeholder="Apellido" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoOdon"
                   placeholder="Teléfono" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionOdon"
                   placeholder="Dirección" required="">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Odontólogo</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacOdon"
                   placeholder="Fecha Nacimiento" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Especialidad Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="especialidad" name="especialidadOdon"
                   placeholder="Especialidad" required="">
        </div> 
        <!-- Sector de Horario-->
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Inicio de Horario</label> 
            <input type="time" class="form-control form-control-user" id="inicioHor" name="inicioHorOdon"
                   placeholder="Inicio de Horario" min="07:00" step="1800" required=""> <!-- min es el horario minimo que se puede colocar y step es un rango de 30 minutos que se debe coloar -->
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fin de Horario</label>
            <input type="time" class="form-control form-control-user" id="finHor" name="finHorOdon"
                   placeholder="Fin de Horario" max="22:00" step="1800" required=""><!-- max es el horario maximo que se puede colocar y step es un rango de 30 minutos que se debe coloar -->
        </div> 
    </div>

    <button class="btn btn-primary btn-user btn-block" type="submit"> 
        Crear Odontólogo
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>
