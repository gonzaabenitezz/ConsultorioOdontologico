<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@include file="components/header.jsp" %>
<%@include file="components/bodyprimeraparte.jsp" %>

<h1>Alta Odontólogos</h1>
<p>Este es el apartado para dar de alta a los odontólogos del sistema.</p>

<%-- Bloque para campos vacíos --%>
<% if ("campos_vacios".equals(request.getParameter("error"))) { %>
<div class="alert alert-danger">
    Por favor, completa todos los campos obligatorios para continuar.
</div>
<% }%>

<p>Odontólogo</p>
<form class="user" action="SvOdontologos" method="POST">
    <div class="form-group col">
        <div class="col-sm-6 mb-3">
            <label for="dniodon">DNI Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="dni" name="dniOdon" 
                   placeholder="DNI" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Nombre Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="nombre" name="nombreOdon"
                   placeholder="Nombre" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Apellido Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="apellido" name="apellidoOdon"
                   placeholder="Apellido" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Teléfono Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="telefono" name="telefonoOdon"
                   placeholder="Teléfono" required="">
        </div>  
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Dirección Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="direccion" name="direccionOdon"
                   placeholder="Dirección" required="">
        </div> 
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Fecha de Nacimiento Odontólogo</label> 
            <input type="date" class="form-control form-control-user" id="fechaNac" name="fechaNacOdon"
                   placeholder="Fecha Nacimiento" required="">
        </div>
        <div class="col-sm-6 mb-3">
            <label for="dniodon">Especialidad Odontólogo</label>
            <input type="text" class="form-control form-control-user" id="especialidad" name="especialidadOdon"
                   placeholder="Especialidad" required="">
        </div> 
        <!-- Sector de Horario-->
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

    <button class="btn btn-primary btn-user btn-block" type="submit"> 
        Crear Odontólogo
    </button>
</form>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const selectInicio = document.getElementById('inicioHor');
        const selectFin = document.getElementById('finHor');

        const horaMin = 7;  // 07:00 AM
        const horaMax = 22; // 10:00 PM

        function generarOpciones() {
            // Limpiar selects
            selectInicio.innerHTML = "";
            selectFin.innerHTML = "";

            for (let h = horaMin; h <= horaMax; h++) {
                // Generar para la hora exacta (:00) y la media hora (:30)
                ["00", "30"].forEach(min => {
                    // Evitar 22:30 si el máximo es 22:00
                    if (h === horaMax && min === "30")
                        return;

                    let horaFormateada = h.toString().padStart(2, '0') + ":" + min;

                    // Lógica para Inicio: No puede seleccionar la última hora (22:00)
                    if (h < horaMax) {
                        selectInicio.add(new Option(horaFormateada, horaFormateada));
                    } else if (h === horaMax && min === "00") {
                        // Opcional: Si quieres que 22:00 sea inicio, quita este IF. 
                        // Pero según tu pedido, 22:00 no debería ser inicio.
                    }

                    // Lógica para Fin: Puede ser cualquier hora desde las 07:30
                    if (!(h === horaMin && min === "00")) {
                        selectFin.add(new Option(horaFormateada, horaFormateada));
                    }
                });
            }
        }

        generarOpciones();

        // Validación extra: El fin no puede ser menor o igual al inicio
        selectFin.addEventListener('change', function () {
            if (selectFin.value <= selectInicio.value) {
                alert("La hora de fin debe ser posterior a la hora de inicio");
                selectFin.selectedIndex = selectFin.options.length - 1;
            }
        });
    });
</script>

<%@include file="components/bodyfinal.jsp" %>
