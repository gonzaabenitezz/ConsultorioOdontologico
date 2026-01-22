<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Alta de Pacientes</h1>
        <p class="text-muted">Complete la información del paciente y su responsable legal si corresponde.</p>
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
        <i class="fas fa-id-card me-2"></i>
        <strong>Error de Selección:</strong> La opción de Obra Social no es válida. Por favor, intente nuevamente.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% }%>

    <form class="user" action="SvPacientes" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-primary text-uppercase">Datos del Paciente</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid; opacity: 1;">
        </div>

        <div class="card shadow mb-5 border-left-primary">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-user me-1"></i> Datos Personales</h6>
            </div>
            <div class="card-body py-4">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Nombre:</label>
                        <input type="text" class="form-control" name="nombrepac" placeholder="Nombre del paciente" required>
                    </div> 
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Apellido:</label>
                        <input type="text" class="form-control" name="apellidopac" placeholder="Apellido del paciente" required>
                    </div>
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">DNI:</label>
                        <input type="text" class="form-control" name="dnipac" placeholder="DNI sin puntos" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Teléfono:</label>
                        <input type="text" class="form-control" name="telefonopac" placeholder="Ej: 11 22334455" required>
                    </div> 
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Dirección:</label>
                        <input type="text" class="form-control" name="direccionpac" placeholder="Calle, Nro, Localidad" required>
                    </div>
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label>
                        <input type="date" class="form-control" name="fechaNacpac" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold text-primary"> Obra Social:</label>
                        <select class="form-control custom-select" name="tieneOSpac" required>
                            <option value="" disabled selected>Seleccione una opción...</option>
                            <option value="true">Sí posee</option>
                            <option value="false">No posee</option>
                        </select>
                    </div> 
                    <div class="col-md-6 mb-3"> 
                        <label class="form-label font-weight-bold">Tipo de Sangre:</label>
                        <input type="text" class="form-control" name="tipoSangrepac" placeholder="Ej: A+ / 0-" required>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-success text-uppercase">Datos del Responsable</h4>
            <small class="text-muted d-block mt-n2 mb-2">(Completar solo si el paciente es menor de edad)</small>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #28a745; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-success">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-success"><i class="fas fa-user-shield me-1"></i> Información del Tutor/Responsable</h6>
            </div>
            <div class="card-body py-4">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Nombre del Responsable:</label>
                        <input type="text" class="form-control" name="nombreRes" placeholder="Nombre">
                    </div> 
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Apellido del Responsable:</label>
                        <input type="text" class="form-control" name="apellidoRes" placeholder="Apellido">
                    </div>
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">DNI del  Responsable:</label>
                        <input type="text" class="form-control" name="dniRes" placeholder="DNI del tutor">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold">Teléfono del Responsable:</label>
                        <input type="text" class="form-control" name="telefonoRes" placeholder="Teléfono de contacto">
                    </div> 
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Dirección del Responsable:</label>
                        <input type="text" class="form-control" name="direccionRes" placeholder="Dirección del tutor">
                    </div>
                    <div class="col-md-4 mb-3"> 
                        <label class="form-label font-weight-bold">Fechade de Nacimiento:</label>
                        <input type="date" class="form-control" name="fechaNacRes">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label font-weight-bold text-success">Parentesco / Tipo:</label>
                        <input type="text" class="form-control" name="tipo_respRes" placeholder="Ej: Madre, Padre, Abuelo/a">
                    </div> 
                </div>
            </div>
        </div>

        <div class="text-right mt-4 mb-5">
            <button class="btn btn-primary btn-lg px-5 shadow border-0" type="submit" style="border-radius: 10px;">
                <i class="fas fa-save me-2"></i> Finalizar Registro de Paciente
            </button>
        </div>
    </form>
</div>

<%@include file="components/bodyfinal.jsp" %>