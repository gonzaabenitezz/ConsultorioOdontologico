<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Usuarios</h1>
<p>Este es el apartado para dar de alta a los usuarios del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% } %>

<%-- Bloque para rol inválido --%>
<% if ("rol_invalido".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    El rol seleccionado no es válido. Por favor, seleccione un rol válido.
</div>
<% }%> 
<form class="user" action="SvUsuarios" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <input type="text" class="form-control form-control-user" id="nombreusu" name="nombreusu"
                   placeholder="Nombre Usuario" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <input type="password" class="form-control form-control-user" id="contrasenia" name="contrasenia"
                   placeholder="Contraseña" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <select class="form-control" id="rol" name="rol" style="border-radius: 10rem; height: 3.1rem; padding-left: 0.8rem;" required="">
                <option value="" disabled selected>Seleccione un Rol</option>
                <option value="admin">admin</option>
                <option value="odonto">odonto</option>
                <option value="secre">secre</option>
            </select>
        </div>
    </div>                 
    <button class="btn btn-primary btn-user btn-block" type="submit">
        Crear Usuario
    </button>
</form>

<%@include file="components/bodyfinal.jsp" %>

