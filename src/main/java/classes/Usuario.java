package classes;

import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.*;
import java.util.List;


@Entity
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String nome;
    String senha;



    public Usuario (String nome, String senha){
        this.nome = nome;
        this.senha = senha;
    }

    public Usuario() {

    }


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }



    public boolean validarUsuario(String usuario, String senha) {
        boolean validado = false;
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select u from Usuario u where nome = : nomeUsuario";
        TypedQuery<Usuario> typedQuery = em
                .createQuery(query, Usuario.class)
                .setParameter("nomeUsuario", usuario);

        Usuario user = typedQuery.getSingleResult();
        if(user != null && user.getSenha().equals(senha)){
            validado = true;
        }


        //emf.close();
        //em.close();
        return validado;
    }
}
