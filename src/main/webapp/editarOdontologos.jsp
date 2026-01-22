<%@page import="java.util.List"%>
<%@page import="logica.Horario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Odontologo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Editar Odontólogo</h1>
        <p class="text-muted">Modifique la información personal o el rango horario del profesional seleccionado.</p>
    </div>

    <%-- Bloque para campos vacíos --%>
    <% if ("campos_vacios".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>¡Atención!</strong> Por favor, no dejar ningún campo vacío para continuar.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <%-- Extracción de datos del backend --%>
    <% Odontologo odon = (Odontologo) request.getSession().getAttribute("odonEditar"); %>
    <% Horario hor = (Horario) request.getSession().getAttribute("horEditar"); %>
    <% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %>
    <% String fechaFormateada = formatter.format(odon.getFecha_nac());%>

    <form class="user" action="SvEditOdontologos" method="POST">

        <div class="text-center mb-3">
            <h4 class="font-weight-bold text-primary text-uppercase">Datos del Odontólogo</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid; opacity: 1;">
        </div>

        <div class="card shadow mb-4 border-left-primary">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-primary">
                    <i class="fas fa-user-md me-1"></i> Datos Personales y Especialidad
                </h6>
            </div>
            <div class="card-body py-4">

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Nombre:</label>
                        <input type="text" class="form-control" name="nombreOdon" value="<%=odon.getNombre()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Apellido:</label>
                        <input type="text" class="form-control" name="apellidoOdon" value="<%=odon.getApellido()%>" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">DNI:</label>
                        <input type="text" class="form-control" name="dniOdon" value="<%=odon.getDni()%>" required>
                    </div>
                </div> 

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Teléfono:</label>
                        <input type="text" class="form-control" name="telefonoOdon" value="<%=odon.getTelefono()%>" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Dirección:</label>
                        <input type="text" class="form-control" name="direccionOdon" value="<%=odon.getDireccion()%>" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label> 
                        <input type="date" class="form-control" name="fechaNacOdon" value="<%=fechaFormateada%>" required>
                    </div>
                </div> 

                <div class="row mb-4">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold text-primary"><i class="far fa-clock"></i> Inicio Horario:</label> 
                        <select class="form-control custom-select" id="inicioHor" name="inicioHorOdon" required></select>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold text-primary"><i class="fas fa-history"></i> Fin Horario:</label>
                        <select class="form-control custom-select" id="finHor" name="finHorOdon" required></select>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Especialidad:</label>
                        <input type="text" class="form-control" name="especialidadOdon" value="<%=odon.getEspecialidad()%>" required>
                    </div>
                </div> 

                <hr>

                <div class="text-right mt-4">
                    <a href="SvOdontologos" class="btn btn-secondary btn-lg px-4 mr-2" style="border-radius: 10px;">
                        <i class="fas fa-arrow-left me-1"></i> Cancelar
                    </a>
                    <button class="btn btn-primary btn-lg shadow-sm px-5" type="submit" style="border-radius: 10px;"> 
                        <i class="fas fa-save me-2"></i> Guardar Cambios
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const selectInicio = document.getElementById('inicioHor');
        const selectFin = document.getElementById('finHor');

        // Valores actuales del backend
        const valorActualInicio = "<%= hor.getHorario_inicio()%>".substring(0, 5);
        const valorActualFin = "<%= hor.getHorario_fin()%>".substring(0, 5);

        const horaMin = 7;
        const horaMax = 22;

        function generarOpciones() {
            selectInicio.innerHTML = "";
            selectFin.innerHTML = "";

            for (let h = horaMin; h <= horaMax; h++) {
                ["00", "30"].forEach(min => {
                    if (h === horaMax && min === "30")
                        return;
                    let horaLabel = h.toString().padStart(2, '0') + ":" + min;

                    // Lógica Inicio
                    if (h < horaMax) {
                        let optInicio = new Option(horaLabel, horaLabel);
                        if (horaLabel === valorActualInicio)
                            optInicio.selected = true;
                        selectInicio.add(optInicio);
                    }

                    // Lógica Fin
                    if (!(h === horaMin && min === "00")) {
                        let optFin = new Option(horaLabel, horaLabel);
                        if (horaLabel === valorActualFin)
                            optFin.selected = true;
                        selectFin.add(optFin);
                    }
                });
            }
        }

        generarOpciones();

        const validarHorarios = () => {
            if (selectFin.value <= selectInicio.value) {
                selectFin.setCustomValidity("La hora de fin debe ser posterior al inicio");
            } else {
                selectFin.setCustomValidity("");
            }
        };

        selectInicio.addEventListener('change', validarHorarios);
        selectFin.addEventListener('change', validarHorarios);
    });
</script>

<%@include file="components/bodyfinal.jsp" %>