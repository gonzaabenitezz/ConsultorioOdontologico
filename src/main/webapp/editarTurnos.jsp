<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Turno"%>
<%@page import="logica.Odontologo"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Editar Turno</h1>
        <p class="text-muted">Modifique los detalles de la cita para el paciente y profesional seleccionados.</p>
    </div>

    <%-- Bloque para errores --%>
    <% if ("campos_vacios".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>¡Atención!</strong> Por favor, completa todos los campos obligatorios.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% } %>

    <%-- Datos del Turno --%>
    <% Turno tur = (Turno) request.getSession().getAttribute("turnoEditar"); %>
    <% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); %>
    <% String fechaFormateada = formatter.format(tur.getFecha_turno());%>

    <form class="user" action="SvEditTurnos" method="POST">

        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card shadow border-left-primary h-100">
                    <div class="card-header py-3 bg-light">
                        <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-user-check me-1"></i> Paciente Confirmado</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-borderless">
                                <thead class="text-xs text-uppercase text-muted">
                                    <tr>
                                        <th>DNI</th>
                                        <th>Nombre Completo</th>
                                        <th class="text-center">Seleccionado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle font-weight-bold"><%= tur.getPacien().getDni()%></td>
                                        <td class="align-middle"><%= tur.getPacien().getNombre()%> <%= tur.getPacien().getApellido()%></td>
                                        <td class="text-center align-middle">
                                            <input type="radio" name="idPaciente" value="<%= tur.getPacien().getId()%>" checked required>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow border-left-success h-100">
                    <div class="card-header py-3 bg-light">
                        <h6 class="m-0 font-weight-bold text-success"><i class="fas fa-user-md me-1"></i> Odontólogo Confirmado</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm table-borderless">
                                <thead class="text-xs text-uppercase text-muted">
                                    <tr>
                                        <th>Especialidad</th>
                                        <th>Médico</th>
                                        <th class="text-center">Seleccionado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="align-middle"><span class="badge badge-success"><%= tur.getOdonto().getEspecialidad()%></span></td>
                                        <td class="align-middle">Dr. <%= tur.getOdonto().getApellido()%></td>
                                        <td class="text-center align-middle">
                                            <input type="radio" name="idOdontologo" value="<%= tur.getOdonto().getId()%>" checked required>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3">
            <h4 class="fw-bold text-dark text-uppercase">Programación de la Cita</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #5a5c69; opacity: 1;">
        </div>

        <div class="card shadow mb-5 border-left-secondary">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-secondary"><i class="fas fa-calendar-check me-2"></i> Fecha, Hora y Motivo</h6>
            </div>
            <div class="card-body py-4">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Fecha del Turno:</label>
                        <input type="date" class="form-control" id="fechaTurno" name="fechaTurno" 
                               value="<%= fechaFormateada%>" min="<%= java.time.LocalDate.now()%>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Hora del Turno:</label>
                        <select class="form-control" id="horaTurno" name="horaTurno" required>
                            <option value="<%= tur.getHora_turno()%>"><%= tur.getHora_turno()%></option>
                        </select>
                        <small class="text-muted">El horario está sujeto a la disponibilidad del profesional.</small>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <label class="form-label font-weight-bold">Afección / Motivo de la Consulta:</label>
                        <textarea class="form-control" name="afeccion" rows="4" 
                                  placeholder="Describa brevemente el motivo de la cita o síntomas del paciente..." 
                                  required><%= tur.getAfeccion()%></textarea>
                    </div>
                </div>

                <hr class="my-4">

                <div class="text-right">
                    <a href="SvTurnos" class="btn btn-secondary btn-lg px-4 mr-2" style="border-radius: 10px;">
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
        const selectHora = document.getElementById('horaTurno');
        const radiosOdontologos = document.querySelectorAll('input[name="idOdontologo"]');
        const horaActualTurno = "<%= tur.getHora_turno()%>";

        function cargarHorarios(idOdontologo) {
            fetch('SvObtenerHorario?idOdontologo=' + idOdontologo)
                    .then(response => response.text())
                    .then(text => {
                        const data = JSON.parse(text.trim().replace(/[\n\r]/g, ""));
                        selectHora.options.length = 0;

                        let [hI, mI] = data.inicio.substring(0, 5).split(':').map(Number);
                        let [hF, mF] = data.fin.substring(0, 5).split(':').map(Number);
                        let minActual = (hI * 60) + mI;
                        let minLimite = (hF * 60) + mF;

                        while (minActual <= minLimite) {
                            let hh = Math.floor(minActual / 60).toString().padStart(2, '0');
                            let mm = (minActual % 60).toString().padStart(2, '0');
                            let horaLabel = hh + ":" + mm;

                            let opt = new Option(horaLabel, horaLabel);
                            if (horaLabel === horaActualTurno) {
                                opt.selected = true;
                            }
                            selectHora.add(opt);
                            minActual += 30;
                        }
                    })
                    .catch(err => console.error("Error al cargar horarios"));
        }

        const radioSeleccionado = document.querySelector('input[name="idOdontologo"]:checked');
        if (radioSeleccionado) {
            cargarHorarios(radioSeleccionado.value);
        }
    });
</script>

<%@include file="components/bodyfinal.jsp" %>