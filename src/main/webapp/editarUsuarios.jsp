<%@page import="logica.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Edición de Usuarios</h1>
        <p class="text-muted">Actualice las credenciales de acceso y los permisos para el personal del sistema.</p>
    </div>

    <%-- Bloque para campos vacíos --%>
    <% if ("campos_vacios".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>¡Atención!</strong> Por favor, completa todos los campos obligatorios para continuar.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <%-- Bloque para rol inválido --%>
    <% if ("rol_invalido".equals(request.getParameter("error"))) { %>
    <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-user-shield me-2"></i>
        <strong>Aviso:</strong> El rol seleccionado no es válido. Por favor, no realice cambios en esa opción.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% }%> 

    <%-- Obtención de datos --%>
    <% Usuario usu = (Usuario) request.getSession().getAttribute("usuEditar");%>

    <form class="user" action="SvEditUsuarios" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-warning text-uppercase">Credenciales del Sistema</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #f6c23e; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-warning">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-warning">
                    <i class="fas fa-key me-1"></i> Configuración de Cuenta
                </h6>
            </div>
            <div class="card-body py-4">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold text-gray-800">Nombre de Usuario:</label>
                        <div class="input-group shadow-sm">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"><i class="fas fa-user text-gray-400"></i></span>
                            </div>
                            <input type="text" class="form-control border-left-0" name="nombreusu" 
                                   value="<%=usu.getNombreUsuario()%>" required>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold text-gray-800">Nueva Contraseña:</label>
                        <div class="input-group shadow-sm">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"><i class="fas fa-lock text-gray-400"></i></span>
                            </div>
                            <input type="password" class="form-control border-left-0" name="contrasenia" 
                                   value="<%=usu.getContrasenia()%>" required>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold text-gray-800">Rol asignado:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-gray-100 border-right-0"><i class="fas fa-user-tag text-gray-400"></i></span>
                            </div>
                            <input type="text" class="form-control border-left-0 bg-gray-100" name="rol" 
                                   value="<%=usu.getRol()%>" readonly>
                        </div>
                        <small class="text-muted ml-1">El rol no puede ser modificado.</small>
                    </div>
                </div>

                <hr class="my-4">

                <div class="text-right">
                    <a href="SvUsuarios" class="btn btn-secondary btn-lg px-4 mr-2" style="border-radius: 10px;">
                       <i class="fas fa-arrow-left me-1"></i> Cancelar
                    </a>
                    <button class="btn btn-warning btn-lg shadow-sm px-5 text-dark font-weight-bold" type="submit" style="border-radius: 10px;"> 
                        <i class="fas fa-check-circle me-2"></i> Guardar Cambios
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>

<%@include file="components/bodyfinal.jsp" %>

