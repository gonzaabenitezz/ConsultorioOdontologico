<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Secretario</h1>
<p>Este es el apartado para dar de alta a los Secretarios del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% } %>

<p>Odontologo</p>
<form class="user" action="SvSecretarios" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Secretario</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniSecre" 
                   placeholder="DNI" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Secretario</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreSecre"
                   placeholder="Nombre" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Secretario</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoSecre"
                   placeholder="Apellido" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Secretario</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoSecre"
                   placeholder="Teléfono" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Secretario</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionSecre"
                   placeholder="Dirección" required="">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Secretario</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacSecre"
                   placeholder="Fecha Nacimiento" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Sector Secretario</label>
            <input type="text" class="form-control form-control-user" id="sector" name="sectorSecre"
                   placeholder="Sector" required="">
        </div> 
        <!-- Aca va a ir todo lo que respecta a horario y usuarios -->
    </div>

    <button class="btn btn-primary btn-user btn-block" type="submit"> <!-- solo agregue el type="submit" -->
        Crear Secretario
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>
