<%@page import="logica.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="logica.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Edición de Pacientes</h1>
        <p class="text-muted">Actualice la información del paciente y su responsable legal si corresponde.</p>
    </div>

    <%-- Bloque para errores --%>
    <% if ("campos_vacios".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>¡Atención!</strong> Por favor, completa todos los campos obligatorios para continuar.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <% if ("OS_invalido".equals(request.getParameter("error"))) { %>
    <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-id-card-alt me-2"></i>
        <strong>Error:</strong> La opción de Obra Social seleccionada no es válida.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <%-- Lógica de Datos --%>
    <% Paciente pac = (Paciente) request.getSession().getAttribute("pasEditar"); %>
    <% Responsable resp = (Responsable) request.getSession().getAttribute("respEditar"); %>
    <% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %>
    <% String fechaFormateada = formatter.format(pac.getFecha_nac()); %>
    <% String fechaFormateadaRes = (resp != null) ? formatter.format(resp.getFecha_nac()) : "";%>

    <form class="user" action="SvEditPacientes" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-primary text-uppercase">Datos del Paciente</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid; opacity: 1;">
        </div>

        <div class="card shadow mb-5 border-left-primary">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-user me-1"></i> Datos Personales</h6>
            </div>
            <div class="card-body py-4">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Nombre:</label>
                        <input type="text" class="form-control" name="nombrepas" value="<%=pac.getNombre()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Apellido:</label>
                        <input type="text" class="form-control" name="apellidopas" value="<%=pac.getApellido()%>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">DNI:</label>
                        <input type="number" class="form-control" name="dnipas" value="<%=pac.getDni()%>" required>
                    </div> 
                </div> 

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Teléfono:</label>
                        <input type="text" class="form-control" name="telefonopas" value="<%=pac.getTelefono()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Dirección:</label>
                        <input type="text" class="form-control" name="direccionpas" value="<%=pac.getDireccion()%>" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label> 
                        <input type="date" class="form-control" name="fechanacpas" value="<%= fechaFormateada%>" required>
                    </div>
                </div> 

                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold text-primary">Obra Social:</label>
                        <select class="form-control custom-select" name="obrasocialpas" required>
                            <option value="true" <%= pac.isTiene_OS() ? "selected" : ""%>>Sí, posee obra social</option>
                            <option value="false" <%= !pac.isTiene_OS() ? "selected" : ""%>>No posee obra social</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Tipo de Sangre:</label>
                        <input type="text" class="form-control" name="tiposangrepas" value="<%=pac.getTipoSangre()%>" required>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-success text-uppercase">Datos del Responsable</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #28a745; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-success">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-success"><i class="fas fa-user-shield me-1"></i> Información del Tutor/Responsable</h6>
            </div>
            <div class="card-body py-4">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Nombre del Responsable:</label>
                        <input type="text" class="form-control" name="nombreRes" value="<%= (resp != null) ? resp.getNombre() : ""%>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Apellido del Responsable:</label>
                        <input type="text" class="form-control" name="apellidoRes" value="<%= (resp != null) ? resp.getApellido() : ""%>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">DNI del Responsable:</label>
                        <input type="text" class="form-control" name="dniRes" value="<%= (resp != null) ? resp.getDni() : ""%>">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Teléfono del Responsable:</label>
                        <input type="text" class="form-control" name="telefonoRes" value="<%= (resp != null) ? resp.getTelefono() : ""%>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Dirección del Responsable:</label>
                        <input type="text" class="form-control" name="direccionRes" value="<%= (resp != null) ? resp.getDireccion() : ""%>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label>
                        <input type="date" class="form-control" name="fechaNacRes" value="<%= fechaFormateadaRes%>">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold text-success">Parentesco / Tipo:</label>
                        <input type="text" class="form-control" name="tipo_respRes" placeholder="Ej: Madre, Padre, Tutor" value="<%= (resp != null) ? resp.getTipo_resp() : ""%>">
                    </div>
                </div>
            </div>
        </div>

        <div class="text-right mt-4 mb-5">
            <a href="SvPacientes" class="btn btn-secondary btn-lg px-4 mr-2" style="border-radius: 10px;">
                <i class="fas fa-arrow-left me-1"></i> Cancelar
            </a>
            <button class="btn btn-primary btn-lg shadow-sm px-5" type="submit" style="border-radius: 10px;"> 
                <i class="fas fa-save me-2"></i> Guardar Cambios
            </button>
        </div>
    </form>
</div>

<%@include file="components/bodyfinal.jsp" %>