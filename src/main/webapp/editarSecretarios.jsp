<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Secretario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Edición de Secretarios</h1>
        <p class="text-muted">Modifique la información personal o el sector asignado del secretario.</p>
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

    <%-- Lógica de datos --%>
    <% Secretario secre = (Secretario) request.getSession().getAttribute("secreEditar"); %>
    <% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %>
    <% String fechaFormateada = formatter.format(secre.getFecha_nac());%>

    <form class="user" action="SvEditSecretarios" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-primary text-uppercase">Datos Personales</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid; opacity: 1;">
        </div>

        <div class="card shadow mb-5 border-left-primary">
            <div class="card-header py-3 bg-light text-primary">
                <h6 class="m-0 font-weight-bold">
                    <i class="fas fa-id-card me-1"></i> Identificación del Secretario
                </h6>
            </div>
            <div class="card-body py-4">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Nombre:</label>
                        <input type="text" class="form-control" name="nombresecre" value="<%=secre.getNombre()%>" required>
                    </div> 
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Apellido:</label>
                        <input type="text" class="form-control" name="apellidosecre" value="<%=secre.getApellido()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">DNI:</label>
                        <input type="number" class="form-control" name="dnisecre" value="<%=secre.getDni()%>" required>
                    </div>
                </div> 

                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Teléfono:</label>
                        <input type="text" class="form-control" name="telefonosecre" value="<%=secre.getTelefono()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Dirección:</label>
                        <input type="text" class="form-control" name="direccionsecre" value="<%=secre.getDireccion()%>" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label> 
                        <input type="date" class="form-control" name="fechanacsecre" value="<%=fechaFormateada%>" required>
                    </div>
                </div> 
            </div>
        </div>

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-info text-uppercase">Asignación de Cargo</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #36b9cc; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-info">
            <div class="card-header py-3 bg-light text-info">
                <h6 class="m-0 font-weight-bold">
                    <i class="fas fa-briefcase me-1"></i> Información del Puesto
                </h6>
            </div>
            <div class="card-body py-4">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold text-info ">Sector / Área asignada:</label>
                        <input type="text" class="form-control" name="sectorsecre" value="<%= secre.getSector()%>" required>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-right mt-4 mb-5">
            <a href="SvSecretarios" class="btn btn-secondary btn-lg px-4 mr-2" style="border-radius: 10px;">
                <i class="fas fa-arrow-left me-1"></i> Cancelar
            </a>
            <button class="btn btn-primary btn-lg shadow-sm px-5" type="submit" style="border-radius: 10px;"> 
                <i class="fas fa-save me-2"></i> Guardar Cambios
            </button>
        </div>
    </form>
</div>

<%@include file="components/bodyfinal.jsp" %>