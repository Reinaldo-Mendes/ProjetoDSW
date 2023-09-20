package classes;

import javax.persistence.*;
import java.util.List;

@Entity
public class Evento {
    String nome, descricao;
    String data;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    int totalMembrosComparecidos;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clan_id")
    Clan clan;

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Clan getClan() {
        return clan;
    }

    public void setClan(Clan clan) {
        this.clan = clan;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTotalMembrosComparecidos() {
        return totalMembrosComparecidos;
    }

    public void setTotalMembrosComparecidos(int totalMembrosComparecidos) {
        this.totalMembrosComparecidos = totalMembrosComparecidos;
    }

    public List<Jogador> getMembros() {
        return membros;
    }

    public void setMembros(List<Jogador> membros) {
        this.membros = membros;
    }

    @ManyToMany(mappedBy = "eventos")
    private List<Jogador> membros;

    public void adicionarEvento(Evento evento) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(evento);
        em.getTransaction().commit();
        System.out.println("Evento adicionado");
        emf.close();
        em.close();
    }

    public List<Evento> recuperarEvento(int id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select e from Evento e where id = : idClan";
        TypedQuery<Evento> typedQuery = em
                .createQuery(query, Evento.class)
                .setParameter("idClan", id);
        List<Evento> listaEvento;

        listaEvento = typedQuery.getResultList();
        //emf.close();
        //em.close();

        return listaEvento;
    }

    public List<Evento> recuperarTodosEventos(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select e from Evento e";
        TypedQuery<Evento> typedQuery = em
                .createQuery(query, Evento.class);
        List<Evento> listaEventos;

        listaEventos= typedQuery.getResultList();
        //emf.close();
        //em.close();
        return listaEventos;
    }

    public int retornarUltimoIdEvento(){
        int id = 0;
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query1 = "Select MAX(id) from Evento";
        Query query2 = em.
                createQuery(query1);
        id = (Integer) query2.getSingleResult();
        return id;
    }

}
