package logica;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import persistencia.ControladoraPersistencia;

public class Controladora {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    public void crearUsuario(String nombreUsuario, String contrasenia, String rol) {
        Usuario usu = new Usuario(); // se deja vacio los corchetes para que se generen la id's automaticamente ya que no las tengo
        usu.setNombreUsuario(nombreUsuario);
        usu.setContrasenia(contrasenia);
        usu.setRol(rol);

        controlPersis.crearUsuario(usu);
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

    
}
