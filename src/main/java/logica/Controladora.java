package logica;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import persistencia.ControladoraPersistencia;
import org.mindrot.jbcrypt.BCrypt;

public class Controladora {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    public int crearUsuario(String nombreUsuario, String contrasenia, String rol) {

        String contraHasheada = BCrypt.hashpw(contrasenia, BCrypt.gensalt());

        Usuario usu = new Usuario(); // se deja vacio los corchetes para que se generen la id's automaticamente ya que no las tengo
        usu.setNombreUsuario(nombreUsuario);
        usu.setContrasenia(contraHasheada);
        usu.setRol(rol);

        controlPersis.crearUsuario(usu);
        return usu.getId_usuario();

    }

    public List<Usuario> getUsuarios() {
        return controlPersis.getUsuarios();
    }

    public void borrarUsuario(int id) {
        controlPersis.borrarUsuario(id);
    }

    public Usuario traerUsuario(int id) {
        return controlPersis.traerUsuario(id);
    }

    public void editarUsuario(Usuario usu, String contrasenia) {

        if (contrasenia != null && !contrasenia.trim().isEmpty()) {
            String contraHasheada = BCrypt.hashpw(contrasenia, BCrypt.gensalt());
            usu.setContrasenia(contraHasheada);
        } else {
            Usuario usuAnterior = controlPersis.traerUsuario(usu.getId_usuario());
            usu.setContrasenia(usuAnterior.getContrasenia());
        }

        controlPersis.editarUsuario(usu);
    }

    public Usuario comprobarIngreso(String usuario, String contrasenia) {

        List<Usuario> listaUsuarios = controlPersis.getUsuarios();

        for (Usuario usu : listaUsuarios) {
            if (usu.getNombreUsuario().equals(usuario)) {
                if (BCrypt.checkpw(contrasenia, usu.getContrasenia())) {
                    return usu; // Devuelve el usuario válido    
                }
            }
        }
        return null;
    }

    public void borrarUsuarioIntegrado(int id) {

        Usuario usu = controlPersis.traerUsuario(id);
        String rolUsu = usu.getRol();

        switch (rolUsu) {
            case "odonto":
                List<Odontologo> listaOdontologo = getOdontologos();
                for (Odontologo odon : listaOdontologo) {
                    if (odon.getUnUsuario() != null && odon.getUnUsuario().getId_usuario() == id) {
                        this.borrarOdontologoIntegral(odon.getId());
                        return;
                    }
                }   break;
            case "secre":
                List<Secretario> listaSecretario = getSecretarios();
                for (Secretario secre : listaSecretario) {
                    if (secre.getUnUsuario() != null && secre.getUnUsuario().getId_usuario() == id) {
                        this.borrarSecretarioIntegral(secre.getId());
                        return;
                    }
                }   break;
            case "admin":
                this.borrarUsuario(id);
                break;
            default:
                break;
        }

    }

    public void crearPacienteYResponsable(String dni, String nombre, String apellido, String telefono, String direccion,
            Date fechaNac, boolean tieneOS, String tipoSangre, String dniRes, String nombreRes, String apellidoRes,
            String telefonoRes, String direccionRes, Date fechaNacRes, String tipoRes) {

        Paciente pas = new Paciente();

        if (dniRes != null && !dniRes.isEmpty()) {
            Responsable resp = new Responsable();
            resp.setDni(dniRes);
            resp.setNombre(nombreRes);
            resp.setApellido(apellidoRes);
            resp.setTelefono(telefonoRes);
            resp.setDireccion(direccionRes);
            resp.setFecha_nac(fechaNacRes);
            resp.setTipo_resp(tipoRes);

            controlPersis.crearResponsable(resp);
            pas.setUnResponsable(resp);
        }

        pas.setDni(dni);
        pas.setNombre(nombre);
        pas.setApellido(apellido);
        pas.setTelefono(telefono);
        pas.setDireccion(direccion);
        pas.setFecha_nac(fechaNac);
        pas.setTiene_OS(tieneOS);
        pas.setTipoSangre(tipoSangre);

        controlPersis.crearPaciente(pas);
    }

    public List<Paciente> getPacientes() {
        return controlPersis.getPacientes();
    }

    public void borrarPaciente(int id) {
        controlPersis.borrarPaciente(id);
    }

    public Paciente traerPaciente(int id) {
        return controlPersis.traerPaciente(id);
    }

    public void editarPaciente(Paciente pas) {
        controlPersis.editarPaciente(pas);
    }

    public Responsable traerResponsable(int idRes) {
        return controlPersis.traerResponsable(idRes);
    }

    public void editarResponsable(Responsable resp) {
        controlPersis.editarResponsable(resp);
    }

    public void borrarResponsable(int idresp) {
        controlPersis.borrarResponsable(idresp);
    }

    public void borrarPacienteResponsableIntegral(int id) {

        controlPersis.borrarTurnoPorPaciente(id);

        Paciente pas = controlPersis.traerPaciente(id);

        if (pas != null) {
            int idResp = (pas.getUnResponsable() != null) ? pas.getUnResponsable().getId() : -1;

            controlPersis.borrarPaciente(id);

            if (idResp != -1) {
                controlPersis.borrarResponsable(idResp);
            }
        }
    }

    public void borrarTurnoPorPaciente(int id) {
        controlPersis.borrarTurnoPorPaciente(id);
    }

    public void crearOdontologo(String dniOdon, String nombreOdon, String apellidoOdon,
            String telefonoOdon, String direccionOdon, Date fechaNacOdon, String especialidadOdon, int unUsuario, int unHorario) {

        Odontologo odon = new Odontologo();

        odon.setDni(dniOdon);
        odon.setNombre(nombreOdon);
        odon.setApellido(apellidoOdon);
        odon.setTelefono(telefonoOdon);
        odon.setDireccion(direccionOdon);
        odon.setFecha_nac(fechaNacOdon);
        odon.setEspecialidad(especialidadOdon);
        odon.setUnUsuario(traerUsuario(unUsuario));
        odon.setUnHorario(traerHorario(unHorario));

        controlPersis.crearOdontologo(odon);

    }

    public List<Odontologo> getOdontologos() {
        return controlPersis.getOdontologos();
    }

    public void borrarOdontologo(int id) {
        controlPersis.borrarOdontologo(id);
    }

    public Odontologo traerOdontologo(int id) {
        return controlPersis.traerOdontologo(id);
    }

    public void editarOdontologo(Odontologo odon) {
        controlPersis.editarOdontologo(odon);
    }

    public void borrarOdontologoIntegral(int id) {

        controlPersis.borrarTurnosPorOdontologo(id);

        Odontologo odon = controlPersis.traerOdontologo(id);

        if (odon != null) {
            int idUsuario = (odon.getUnUsuario() != null) ? odon.getUnUsuario().getId_usuario() : -1;
            int idHorario = (odon.getUnHorario() != null) ? odon.getUnHorario().getId_horario() : -1;

            controlPersis.borrarOdontologo(id);

            if (idUsuario != -1) {
                controlPersis.borrarUsuario(idUsuario);
            }
            if (idHorario != -1) {
                controlPersis.borrarHorario(idHorario);
            }
        }
    }

    public void borrarTurnosPorOdontologo(int id) {
        // 1. Ejecutamos el borrado masivo que pusiste arriba
        controlPersis.borrarTurnosPorOdontologo(id);

    }

    public void crearSecretario(String dni, String nombre, String apellido, String telefono, String direccion, Date fechaNac, String sector, int unUsuario) {
        Secretario secre = new Secretario();

        secre.setDni(dni);
        secre.setNombre(nombre);
        secre.setApellido(apellido);
        secre.setTelefono(telefono);
        secre.setDireccion(direccion);
        secre.setFecha_nac(fechaNac);
        secre.setSector(sector);
        secre.setUnUsuario(traerUsuario(unUsuario));
        //System.out.println(" ----------------------------------------- ID DEL USUARIO desde la CONTROLADORA " + unUsuario);

        controlPersis.crearSecretario(secre);
    }

    public List<Secretario> getSecretarios() {
        return controlPersis.getSecretarios();
    }

    public void borrarSecretario(int id) {
        controlPersis.borrarSecretario(id);
    }

    public Secretario traerSecretario(int id) {
        return controlPersis.traerSecretario(id);
    }

    public void editarSecretario(Secretario secre) {
        controlPersis.editarSecretario(secre);
    }

    public void borrarSecretarioIntegral(int id) {
        Secretario secre = controlPersis.traerSecretario(id);

        if (secre != null) {
            int idUsuario = (secre.getUnUsuario() != null) ? secre.getUnUsuario().getId_usuario() : -1;

            controlPersis.borrarSecretario(id);

            if (idUsuario != -1) {
                controlPersis.borrarUsuario(idUsuario);
            }
        }
    }

    public int crearHorario(String inicioHorarioOdon, String finHorarioOdon) {
        Horario hor = new Horario();
        hor.setHorario_inicio(inicioHorarioOdon);
        hor.setHorario_fin(finHorarioOdon);

        controlPersis.crearHorario(hor);
        return hor.getId_horario();
    }

    public Horario traerHorario(int idHor) {
        return controlPersis.traerHorario(idHor);
    }

    public List<Horario> getHorarios() {
        return controlPersis.getHorarios();
    }

    public void editarHorarios(Horario hor) {
        controlPersis.editarHorarios(hor);
    }

    public void borrarHorario(Integer id) {
        controlPersis.borrarHorario(id);
    }

    public void crearTurno(int idPaciente, int idOdontologo, Date fechaTurno, String horaTurno, String afeccion) {

        Turno tur = new Turno();
        Paciente pac = traerPaciente(idPaciente);
        Odontologo odon = traerOdontologo(idOdontologo);

        tur.setPacien(pac);
        tur.setOdonto(odon);
        tur.setFecha_turno(fechaTurno);
        tur.setHora_turno(horaTurno);
        tur.setAfeccion(afeccion);

        controlPersis.crearTurno(tur);
    }

    public List<Turno> getTurnos() {

        return controlPersis.getTurnos();

    }

    public void borrarTurno(int id) {
        controlPersis.borrarTurno(id);
    }

    public Turno traerTurno(int id) {
        return controlPersis.traerTurno(id);
    }

    public void editarTurno(Turno tur) {
        controlPersis.editarTurno(tur);
    }
}
