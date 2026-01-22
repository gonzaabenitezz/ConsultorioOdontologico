<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Alta de Usuarios</h1>
        <p class="text-muted">Configure las credenciales de acceso y los permisos para el personal del sistema.</p>
    </div>

    <%-- Bloque para campos vacíos --%>
    <% if ("campos_vacios".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>¡Atención!</strong> Por favor, completa todos los campos obligatorios.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <%-- Bloque para rol inválido --%>
    <% if ("rol_invalido".equals(request.getParameter("error"))) { %>
    <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-user-shield me-2"></i>
        <strong>Error de permisos:</strong> El rol seleccionado no es válido.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% }%> 

    <form class="user" action="SvUsuarios" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-warning text-uppercase">Credenciales del Sistema</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #f6c23e; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-warning">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-warning">
                    <i class="fas fa-lock me-1"></i> Configuración de Cuenta
                </h6>
            </div>
            <div class="card-body py-4">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Nombre de Usuario:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"><i class="fas fa-user text-gray-400"></i></span>
                            </div>
                            <input type="text" class="form-control border-left-0" id="nombreusu" name="nombreusu" placeholder="Ej: jgonzalez" required>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Contraseña:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"><i class="fas fa-key text-gray-400"></i></span>
                            </div>
                            <input type="password" class="form-control border-left-0" id="contrasenia" name="contrasenia" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Rol de Usuario:</label>
                        <select class="form-control custom-select" id="rol" name="rol" required>
                            <option value="" disabled selected>Seleccione un Rol...</option>
                            <option value="admin">Administrador</option>
                            <option value="odonto">Odontólogo</option>
                            <option value="secre">Secretario/a</option>
                        </select>
                    </div>
                </div>

                <hr>

                <div class="text-right mt-4">
                    <button class="btn btn-warning btn-lg shadow-sm px-5 text-dark font-weight-bold" type="submit" style="border-radius: 10px;"> 
                        <i class="fas fa-user-plus me-2"></i> Crear Usuario
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
<%@include file="components/bodyfinal.jsp" %>

