package logica;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import persistencia.ControladoraPersistencia;

public class Controladora {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    public int crearUsuario(String nombreUsuario, String contrasenia, String rol) {
        Usuario usu = new Usuario(); // se deja vacio los corchetes para que se generen la id's automaticamente ya que no las tengo
        usu.setNombreUsuario(nombreUsuario);
        usu.setContrasenia(contrasenia);
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

    public void editarUsuario(Usuario usu) {
        controlPersis.editarUsuario(usu);
    }

    public boolean comprobarIngreso(String usuario, String contrasenia) {

        boolean ingreso = false;

        List<Usuario> listaUsuarios = new ArrayList<Usuario>();
        listaUsuarios = controlPersis.getUsuarios();

        for (Usuario usu : listaUsuarios) {
            if (usu.getNombreUsuario().equals(usuario)) {
                if (usu.getContrasenia().equals(contrasenia)) {
                    ingreso = true;
                } else {
                    ingreso = false;
                }
            }
        }
        return ingreso;
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
