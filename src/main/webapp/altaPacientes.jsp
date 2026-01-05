<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Pacientes</h1>
<p>Este es el apartado para dar de alta a los pacientes del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% } %>

<%-- Bloque para Obra Social invalida --%>
<% if ("OS_invalido".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    La opción de Obra Social no es válido. Por favor, seleccione una opcipon válida.
</div>
<% }%> 
<p>Paciente</p>
<form class="user" action="SvPacientes" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dnipac">DNI Paciente:</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dnipac"
                   placeholder="DNI" required>
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Nombre Paciente:</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombrepac"
                   placeholder="Nombre" required>
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Apellido Paciente:</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidopac"
                   placeholder="Apellido" required>
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Teléfono Paciente:</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonopac"
                   placeholder="Teléfono" required>
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Dirección Paciente:</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionpac"
                   placeholder="Dirección" required>
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Fecha Nacimiento Paciente:</label>
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacpac"
                   placeholder="Fecha Nacimiento" required>
        </div> 
        <!--<!-- Aca va a ir todo lo que respecta a horario y usuarios -->
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Obra social Paciente:</label>
            <select class="form-control" id="tieneOS" name="tieneOSpac" style="border-radius: 10rem; height: 3.1rem; padding-left: 0.8rem;" required="">
                <option value="" disabled selected>Seleccione la condición</option>
                <option value="true">Si</option>
                <option value="false">No</option>
            </select>
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnipac">Tipo Sangre Paciente:</label>
            <input type="text" class="form-control form-control-user" id="tipoSangre" name="tipoSangrepac"
                   placeholder="Tipo Sangre" required>
        </div>

        <br>

        <p>Responsable</p>
        <div class="col-sm-6 mb-3">
            <label for="dnires">DNI Responsable:</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniRes"
                   placeholder="DNI">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Nombre Responsable:</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreRes"
                   placeholder="Nombre">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnires">Apellido Responsable:</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoRes"
                   placeholder="Apellido">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Teléfono Responsable:</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoRes"
                   placeholder="Teléfono">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dnires">Dirección Responsable:</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionRes"
                   placeholder="Dirección">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dnires">Fecha Nacimiento Responsable:</label>
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacRes"
                   placeholder="Fecha Nacimiento">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dnires">Tipo de Responsable:</label>
            <input type="text" class="form-control form-control-user" id="tipo_resp" name="tipo_respRes"
                   placeholder="Tipo de Responsable">
        </div>
    </div>


    <button class="btn btn-primary btn-user btn-block" type="submit">
        Crear Paciente
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>