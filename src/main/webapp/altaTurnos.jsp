<%@page import="logica.Odontologo"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<div class="container-fluid">

    <div class="mb-4">
        <h1 class="h3 mb-2 text-gray-800 font-weight-bold">Alta de Turnos</h1>
        <p class="text-muted">Seleccione un paciente, un profesional y asigne el horario correspondiente.</p>
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

    <form class="user" action="SvTurnos" method="POST">
        
        <div class="text-center mb-3">
            <h4 class="fw-bold text-secondary text-uppercase">1. Selección de Paciente y Odontólogo</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #858796; opacity: 1;">
        </div>

        <div class="row mb-5">
            <div class="col-lg-6 mb-4">
                <div class="card shadow border-left-primary h-100">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                        <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-hospital-user me-2"></i> Pacientes</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 250px; overflow-y: auto;">
                            <table class="table table-hover table-sm border">
                                <thead class="bg-gray-100 text-dark">
                                    <tr>
                                        <th>DNI</th>
                                        <th>Nombre Completo</th>
                                        <th class="text-center">Seleccionar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes"); %>
                                    <% if (listaPacientes != null && !listaPacientes.isEmpty()) {
                                        for (Paciente pac : listaPacientes) {%>
                                    <tr>
                                        <td class="align-middle"><%= pac.getDni()%></td>
                                        <td class="align-middle"><%= pac.getNombre()%> <%= pac.getApellido()%></td>
                                        <td class="text-center align-middle">
                                            <div class="custom-control custom-radio">
                                                <input type="radio" id="pac_<%= pac.getId()%>" name="idPaciente" value="<%= pac.getId()%>" class="custom-control-input" required>
                                                <label class="custom-control-label" for="pac_<%= pac.getId()%>"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                    <tr><td colspan="3" class="text-center py-3">No hay pacientes registrados</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 mb-4">
                <div class="card shadow border-left-success h-100">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-light">
                        <h6 class="m-0 font-weight-bold text-success"><i class="fas fa-user-md me-2"></i> Odontólogos</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 250px; overflow-y: auto;">
                            <table class="table table-hover table-sm border text-sm">
                                <thead class="bg-gray-100 text-dark">
                                    <tr>
                                        <th>Especialidad</th>
                                        <th>Profesional</th>
                                        <th class="text-center">Seleccionar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String rolOdon = (String) misession.getAttribute("rol");
                                        Integer idOdon = (Integer) misession.getAttribute("id");
                                        List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos");

                                        if (listaOdontologos != null && !listaOdontologos.isEmpty()) {
                                            for (Odontologo odon : listaOdontologos) {
                                                // Lógica de filtrado por rol
                                                boolean mostrar = false;
                                                if ("secre".equalsIgnoreCase(rolOdon) || "admin".equalsIgnoreCase(rolOdon)) {
                                                    mostrar = true;
                                                } else if ("odon".equalsIgnoreCase(rolOdon) && idOdon.equals(odon.getId())) {
                                                    mostrar = true;
                                                }
                                                
                                                if (mostrar) { %>
                                    <tr>
                                        <td class="align-middle"><span class="badge badge-success"><%= odon.getEspecialidad()%></span></td>
                                        <td class="align-middle"><%= odon.getNombre()%> <%= odon.getApellido()%></td>
                                        <td class="text-center align-middle">
                                            <div class="custom-control custom-radio">
                                                <input type="radio" id="odon_<%= odon.getId()%>" name="idOdontologo" value="<%= odon.getId()%>" class="custom-control-input odon-radio" required>
                                                <label class="custom-control-label" for="odon_<%= odon.getId()%>"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } } } else { %>
                                    <tr><td colspan="3" class="text-center py-3">No hay odontólogos registrados</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-3">
            <h4 class="fw-bold text-secondary text-uppercase">2. Programación de la Cita</h4>
            <hr class="mx-auto" style="width: 50px; border: 2px solid #858796; opacity: 1;">
        </div>

        <div class="card shadow mb-5 border-left-secondary">
            <div class="card-header py-3 bg-light">
                <h6 class="m-0 font-weight-bold text-secondary"><i class="fas fa-calendar-check me-2"></i> Fecha, Hora y Motivo</h6>
            </div>
            <div class="card-body py-4">
                <div class="row mb-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Fecha del Turno:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"> </span>
                            </div>
                            <input type="date" class="form-control border-left-0" id="fechaTurno" name="fechaTurno" min="<%= java.time.LocalDate.now()%>" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label font-weight-bold">Hora del Turno:</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0"></span>
                            </div>
                            <select class="form-control border-left-0 custom-select" id="horaTurno" name="horaTurno" required>
                                <option value="" disabled selected>Seleccione un odontólogo primero...</option>
                            </select>
                        </div>
                        <small id="rangoInfo" class="text-muted italic ml-1"></small>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <label class="form-label font-weight-bold">Afección / Motivo de Consulta:</label>
                        <textarea class="form-control" id="afeccion" name="afeccion" rows="4" 
                                  placeholder="Describa brevemente el motivo del turno..." required></textarea>
                    </div>
                </div>

                <hr class="my-4">

                <div class="text-right">
                    <button class="btn btn-primary btn-lg shadow-sm px-5" type="submit" style="border-radius: 10px;">
                        <i class="fas fa-check-circle me-2"></i> Confirmar y Crear Turno
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const selectHora = document.getElementById('horaTurno');
        const radiosOdontologos = document.querySelectorAll('.odon-radio');

        radiosOdontologos.forEach(radio => {
            radio.addEventListener('change', function () {
                // Efecto visual de carga
                selectHora.innerHTML = '<option value="">Cargando horarios...</option>';
                
                fetch('SvObtenerHorario?idOdontologo=' + this.value)
                    .then(response => response.text())
                    .then(text => {
                        const data = JSON.parse(text.trim().replace(/[\n\r]/g, ""));
                        selectHora.options.length = 0;
                        selectHora.add(new Option("-- Seleccione una hora disponible --", ""));

                        let [hI, mI] = data.inicio.substring(0, 5).split(':').map(Number);
                        let [hF, mF] = data.fin.substring(0, 5).split(':').map(Number);

                        let minActual = (hI * 60) + mI;
                        let minLimite = (hF * 60) + mF;

                        while (minActual <= minLimite) {
                            let hh = Math.floor(minActual / 60).toString().padStart(2, '0');
                            let mm = (minActual % 60).toString().padStart(2, '0');
                            let horaLabel = hh + ":" + mm;
                            selectHora.add(new Option(horaLabel, horaLabel));
                            minActual += 30;
                        }
                    })
                    .catch(err => {
                        console.error("Error:", err);
                        selectHora.innerHTML = '<option value="">Error al cargar horarios</option>';
                    });
            });
        });
    });
</script>

<%@include file="components/bodyfinal.jsp" %>