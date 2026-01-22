<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>


<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Alta de Odontólogos</h1>
        <p class="text-muted">Registre los datos personales y la disponibilidad horaria del profesional.</p>
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
    <% }%>

    <form class="user" action="SvOdontologos" method="POST">

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
                        <input type="text" class="form-control" name="nombreOdon" placeholder="Nombre completo" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Apellido:</label>
                        <input type="text" class="form-control" name="apellidoOdon" placeholder="Apellido completo" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">DNI:</label>
                        <input type="text" class="form-control" name="dniOdon" placeholder="DNI sin puntos" required>
                    </div>
                </div> 

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label font-weight-bold">Teléfono:</label>
                        <input type="text" class="form-control" name="telefonoOdon" placeholder="Ej: 1234 567890" required>
                    </div> 
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Dirección:</label>
                            <input type="text" class="form-control" name="direccionOdon" placeholder="Calle y número" required>
                    </div>
                    <div class="col-md-4"> 
                        <label class="form-label font-weight-bold">Fecha de Nacimiento:</label> 
                        <input type="date" class="form-control" name="fechaNacOdon" required>
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
                        <input type="text" class="form-control" name="especialidadOdon" placeholder="Ej: Endodoncia" required>
                    </div>
                </div> 

                <hr>

                <div class="text-right mt-4">
                    <button class="btn btn-primary btn-lg shadow-sm px-5" type="submit" style="border-radius: 10px;"> 
                        <i class="fas fa-save me-2"></i> Finalizar Registrar Odontólogo
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
        const horaMin = 7;
        const horaMax = 22;

        function generarOpciones() {
            selectInicio.innerHTML = "";
            selectFin.innerHTML = "";
            for (let h = horaMin; h <= horaMax; h++) {
                ["00", "30"].forEach(min => {
                    if (h === horaMax && min === "30")
                        return;
                    let horaFormateada = h.toString().padStart(2, '0') + ":" + min;
                    if (h < horaMax) {
                        selectInicio.add(new Option(horaFormateada, horaFormateada));
                    }
                    if (!(h === horaMin && min === "00")) {
                        selectFin.add(new Option(horaFormateada, horaFormateada));
                    }
                });
            }
        }
        generarOpciones();

        selectFin.addEventListener('change', function () {
            if (selectFin.value <= selectInicio.value) {
                alert("La hora de fin debe ser posterior a la hora de inicio");
                selectFin.selectedIndex = selectFin.options.length - 1;
            }
        });
    });
</script>

<%@include file="components/bodyfinal.jsp" %>
