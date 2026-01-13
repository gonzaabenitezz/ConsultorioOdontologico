<%@page import="java.util.List"%>
<%@page import="logica.Horario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="logica.Odontologo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Editar Odontólogos</h1>
<p>Este es el apartado para editar a los odontologos del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, no dejar ningún campo vacío para continuar. 
</div>
<% } %>

<% Odontologo odon = (Odontologo) request.getSession().getAttribute("odonEditar"); %>
<%Horario hor = (Horario) request.getSession().getAttribute("horEditar"); %>


<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");%>
<% String fechaFormateada = formatter.format(odon.getFecha_nac());%>


<p>Odontologo</p>
<form class="user" action="SvEditOdontologos" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Odontologo</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniOdon" 
                   placeholder="DNI" value="<%=odon.getDni()%>" required=""> 
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Odontologo</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreOdon"
                   placeholder="Nombre" value="<%=odon.getNombre()%>" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Odontologo</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoOdon"
                   placeholder="Apellido" value="<%=odon.getApellido()%>" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Odontologo</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoOdon"
                   placeholder="Teléfono" value="<%=odon.getTelefono()%>" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Odontologo</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionOdon"
                   placeholder="Dirección" value="<%=odon.getDireccion()%>" required="">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Odontologo</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacOdon"
                   placeholder="Fecha Nacimiento" value="<%=fechaFormateada%>" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Especialidad Odontologo</label>
            <input type="text" class="form-control form-control-user" id="especialidad" name="especialidadOdon"
                   placeholder="Especialidad" value="<%=odon.getEspecialidad()%>" required="">
        </div> 
        <!-- Sector de Horario -->
        <div class="row px-3">
            <div class="col-sm-6 mb-3">
                <label for="inicioHorOdon">Inicio de Horario</label> 
                <select class="form-control" id="inicioHor" name="inicioHorOdon" required>
                </select>
            </div>
            <div class="col-sm-6 mb-3">
                <label for="finHorOdon">Fin de Horario</label>
                <select class="form-control" id="finHor" name="finHorOdon" required>
                </select>
            </div> 
        </div>
    </div>

    <button class="btn btn-primary btn-user btn-block" type="submit"> <!-- solo agregue el type="submit" -->
        Editar Odontólogo
    </button>
</form>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const selectInicio = document.getElementById('inicioHor');
        const selectFin = document.getElementById('finHor');

        // Obtenemos los valores que ya tiene el odontólogo (limpiando segundos si existen)
                           const valorActualInicio = "<%= hor.getHorario_inicio()%>".substring(0, 5);
                           const valorActualFin = "<%= hor.getHorario_fin()%>".substring(0, 5);

        const horaMin = 7;  // 07:00 AM
        const horaMax = 22; // 10:00 PM

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

        // Validación para evitar que el fin sea menor al inicio
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