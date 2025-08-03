package persistencia;

//import java.util.ArrayList; si no anda es por esto 13.57 21.03.2025
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logica.Horario;
import logica.Odontologo;
import logica.Paciente;
import logica.Responsable;
import logica.Secretario;
import logica.Turno;
import logica.Usuario;
import persistencia.exceptions.NonexistentEntityException;

public class ControladoraPersistencia {

    HorarioJpaController horaJPA = new HorarioJpaController();
    OdontologoJpaController odontoJPA = new OdontologoJpaController();
    PacienteJpaController pacJPA = new PacienteJpaController();
    PersonaJpaController persJPA = new PersonaJpaController();
    ResponsableJpaController resJPA = new ResponsableJpaController();
    SecretarioJpaController secreJPA = new SecretarioJpaController();
    TurnoJpaController turnJPA = new TurnoJpaController();
    UsuarioJpaController usuJPA = new UsuarioJpaController();

    public ControladoraPersistencia() {
    }

    public int crearUsuario(Usuario usu) {
        usuJPA.create(usu);
        return usu.getId_usuario();
        
    }

    public List<Usuario> getUsuarios() {
        return usuJPA.findUsuarioEntities();
    }

    public void borrarUsuario(int id) {
        try {
            usuJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Usuario traerUsuario(int id) {
        return usuJPA.findUsuario(id);
    }

    public void editarUsuario(Usuario usu) {
        try {
            usuJPA.edit(usu);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearPaciente(Paciente pas) {
        pacJPA.create(pas);
    }

    public List<Paciente> getPacientes() {
        return pacJPA.findPacienteEntities();
    }

    public void borrarPaciente(int id) {
        try {
            pacJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Paciente traerPaciente(int id) {
        return pacJPA.findPaciente(id);
    }

    public void editarPaciente(Paciente pas) {
        try {
            pacJPA.edit(pas);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearResponsable(Responsable resp) {
        resJPA.create(resp);
    }

    public Responsable traerResponsable(int idRes) {
        return resJPA.findResponsable(idRes); //ESTO SE USA???
    }

    public void editarResponsable(Responsable resp) {   //   SvEditarPacientes/controladora
        try {
            resJPA.edit(resp);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void borrarResponsable(int idresp) {
        try {
            resJPA.destroy(idresp);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearOdontologo(Odontologo odon) {
        odontoJPA.create(odon);
    }

    public List<Odontologo> getOdontologos() {
        return odontoJPA.findOdontologoEntities();
    }

    public void borrarOdontologo(int id) {
        try {
            odontoJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Odontologo traerOdontologo(int id) {
        return odontoJPA.findOdontologo(id);
    }

    public void editarOdontologo(Odontologo odon) {
        try {
            odontoJPA.edit(odon);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearSecretario(Secretario secre) {
        secreJPA.create(secre);
    }

    public List<Secretario> getSecretarios() {
        return secreJPA.findSecretarioEntities();
    }

    public void borrarSecretario(int id) {
        try {
            secreJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Secretario traerSecretario(int id) {
        return secreJPA.findSecretario(id);
    }

    public void editarSecretario(Secretario secre) {
        try {
            secreJPA.edit(secre);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int crearHorario(Horario hor) {
        horaJPA.create(hor);
        return hor.getId_horario();
    }

    public Horario traerHorario(int idHor) {
        return horaJPA.findHorario(idHor);
    }

    public List<Horario> getHorarios() {
        return horaJPA.findHorarioEntities();
    }

    public void editarHorarios(Horario hor) {
        try {
            horaJPA.edit(hor);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void borrarHorario(Integer id) {
        try {
            horaJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void crearTurno(Turno tur) {
        
        turnJPA.create(tur);
        
    }

    public List<Turno> getTurnos() {
    
        return turnJPA.findTurnoEntities();
    
    }

    public void borrarTurno(int id) {
        try {
            turnJPA.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Turno traerTurno(int id) {
        return turnJPA.findTurno(id);
    }

    public void editarTurno(Turno tur) {
        try {
            turnJPA.edit(tur);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }



}
