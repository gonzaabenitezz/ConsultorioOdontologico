<%@page import="java.util.List"%>
<%@page import="logica.Horario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Odontologo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Editar Odontólogos</h1>
<p>Este es el apartado para editar a los odontologos del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, no dejar ningún campo vacío para continuar. 
</div>
<% } %>

<% Odontologo odon = (Odontologo) request.getSession().getAttribute("odonEditar"); %>
<%Horario hor = (Horario) request.getSession().getAttribute("horEditar"); %>


<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%>
<% String fechaFormateada = formatter.format(odon.getFecha_nac());%>


<p>Odontologo</p>
<form class="user" action="SvEditOdontologos" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Odontologo</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniOdon" 
                   placeholder="DNI" value="<%=odon.getDni()%>" required=""> 
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Odontologo</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreOdon"
                   placeholder="Nombre" value="<%=odon.getNombre()%>" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Odontologo</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoOdon"
                   placeholder="Apellido" value="<%=odon.getApellido()%>" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Odontologo</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoOdon"
                   placeholder="Teléfono" value="<%=odon.getTelefono()%>" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Odontologo</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionOdon"
                   placeholder="Dirección" value="<%=odon.getDireccion()%>" required="">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Odontologo</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacOdon"
                   placeholder="Fecha Nacimiento" value="<%=fechaFormateada%>" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Especialidad Odontologo</label>
            <input type="text" class="form-control form-control-user" id="especialidad" name="especialidadOdon"
                   placeholder="Especialidad" value="<%=odon.getEspecialidad()%>" required="">
        </div> 
        <!-- Sector de Horario -->
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Inicio de Horario</label> 
            <input type="time" class="form-control form-control-user" id="inicioHor" name="inicioHorOdon"
                   placeholder="Inicio de Horario" value="<%= hor.getHorario_inicio()%>" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fin de Horario</label>
            <input type="time" class="form-control form-control-user" id="finHor" name="finHorOdon"
                   placeholder="Fin de Horario" value="<%= hor.getHorario_fin()%>" required="">
        </div> 
    </div>

    <button class="btn btn-primary btn-user btn-block" type="submit"> <!-- solo agregue el type="submit" -->
        Editar Odontólogo
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>