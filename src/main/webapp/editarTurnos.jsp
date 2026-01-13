<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Turno"%>
<%@page import="logica.Odontologo"%>
<%@page import="logica.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Editar Turno</h1>
<p>Este es el apartado para editar los turnos del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% } %>

<% Turno tur = (Turno) request.getSession().getAttribute("turnoEditar"); %>

<%SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%>
<% String fechaFormateada = formatter.format(tur.getFecha_turno());%> 

<form class="user" action="SvEditTurnos" method="POST">
    <div class="form-group col">     

        <div class="row">
            <!-- Pacientes -->
            <div class="col-md-6">
                <div class="card shadow mb-2">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Pacientes</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                            <table class="table table-bordered" width="100%">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Dni</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= tur.getPacien().getId()%></td>
                                        <td><%= tur.getPacien().getDni()%></td>
                                        <td><%= tur.getPacien().getNombre()%></td>
                                        <td> <%= tur.getPacien().getApellido()%></td>
                                        <td class="text-center">
                                            <input type="radio" name="idPaciente" value="<%= tur.getPacien().getId()%>" checked required>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Odontólogos -->
            <div class="col-md-6">
                <div class="card shadow mb-2">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Odontólogos</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                            <table class="table table-bordered" width="100%">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Especialidad</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= tur.getOdonto().getId()%></td>
                                        <td><%= tur.getOdonto().getNombre()%></td>
                                        <td><%= tur.getOdonto().getApellido()%></td>
                                        <td><%= tur.getOdonto().getEspecialidad()%></td>
                                        <td class="text-center">
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

        <!-- Fecha, Hora y Afección -->
        <div class="row">
            <div class="col-sm-6 mb-3">
                <label for="fecha">Fecha Turno</label>
                <input type="date" class="form-control" id="fechaTurno" name="fechaTurno" value="<%= fechaFormateada%>" min="<%= java.time.LocalDate.now()%>" required>
            </div>
            <div class="col-sm-6 mb-3">
                <label for="fecha">Horario Turno</label>
                <select class="form-control" id="horaTurno" name="horaTurno" required>
                    <option value="<%= tur.getHora_turno()%>"><%= tur.getHora_turno()%></option>
                </select>
            </div>
            <div class="col-sm-12 mb-3">
                <label for="afeccion">Afección</label>
                <input type="text" class="form-control" id="afeccion" name="afeccion" value="<%= tur.getAfeccion()%>" placeholder="Describa la afección o motivo de la consulta" required>
            </div>
        </div>

        <button class="btn btn-primary btn-user btn-block" type="submit">Editar Turno</button>
    </div>
</form>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const selectHora = document.getElementById('horaTurno');
        const radiosOdontologos = document.querySelectorAll('input[name="idOdontologo"]');
        const horaActualTurno = "<%= tur.getHora_turno()%>"; // Guardamos la hora que ya tiene el turno

        // Función para cargar horarios (la misma de antes)
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
                            // Si la hora que estamos generando es la que ya tenía el turno, la seleccionamos
                            if (horaLabel === horaActualTurno) {
                                opt.selected = true;
                            }
                            selectHora.add(opt);
                            minActual += 30;
                        }
                    })
                    .catch(err => console.error("Error al cargar horarios"));
        }

        // 1. ESCUCHAR CAMBIOS: Cuando el usuario cambia de odontólogo manualmente
        radiosOdontologos.forEach(radio => {
            radio.addEventListener('change', function () {
                cargarHorarios(this.value);
            });
        });

        // 2. EJECUCIÓN INICIAL: Cargar horarios del odontólogo que ya viene marcado (checked)
        const radioSeleccionado = document.querySelector('input[name="idOdontologo"]:checked');
        if (radioSeleccionado) {
            cargarHorarios(radioSeleccionado.value);
        }
    });
</script>

<%@include file="components/bodyfinal.jsp" %>