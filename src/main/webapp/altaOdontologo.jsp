<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Odontólogos</h1>
<p>Este es el apartado para dar de alta a los odontologos del sistema.</p>

<p>Odontologo</p>
<form class="user" action="SvOdontologos" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Odontologo</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniOdon" 
                   placeholder="DNI">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Odontologo</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreOdon"
                   placeholder="Nombre">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Odontologo</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoOdon"
                   placeholder="Apellido">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Odontologo</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoOdon"
                   placeholder="Teléfono">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Odontologo</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionOdon"
                   placeholder="Dirección">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Odontologo</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacOdon"
                   placeholder="Fecha Nacimiento">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Especialidad Odontologo</label>
            <input type="text" class="form-control form-control-user" id="especialidad" name="especialidadOdon"
                   placeholder="Especialidad">
        </div> 
        <!-- Aca va a ir todo lo que respecta a horario y usuarios -->
    </div>

    <button class="btn btn-primary btn-user btn-block" type="submit"> <!-- solo agregue el type="submit" -->
        Crear Odontólogo
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>
