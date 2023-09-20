package classes;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Jogador {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String apelido;
    String ranking;
    String contaPrincipal;
    double porcentagemComparecimento;
    int numeroEventosComparecidos;

   //int expForça, expAtaque, expDefesa, expVida, expRanged, expMagia;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clan_id")
    Clan clan;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "evento_membros",
            joinColumns = {
            @JoinColumn(name = "jogador_id")}, inverseJoinColumns =
            {@JoinColumn(name = "evento_id")})
    List<Evento> eventos;

    public Jogador(String apelido, String conta, String rankAtual, double porcentagemComparecimento, int numeroEventosComparecidos, Clan clan) {
        this.apelido = apelido;
        this.contaPrincipal = conta;
        this.ranking = rankAtual;
        this.porcentagemComparecimento = porcentagemComparecimento;
        this.numeroEventosComparecidos = numeroEventosComparecidos;
        this.clan = clan;

    }
    public List<Evento> getEventos() {
        return eventos;
    }

    public void setRanking(String ranking) {
        this.ranking = ranking;
    }



    public void setEventos(List<Evento> eventos) {
        this.eventos = eventos;
    }

    public Jogador(String apelido, String conta, String rankAtual, double porcentagemComparecimento, int numeroEventosComparecidos) {
        this.apelido = apelido;
        this.contaPrincipal = conta;
        this.ranking = rankAtual;
        this.porcentagemComparecimento = porcentagemComparecimento;
        this.numeroEventosComparecidos = numeroEventosComparecidos;

    }

    public Jogador() {
    }

    public String getContaPrincipal() {
        return contaPrincipal;
    }

    public void setContaPrincipal(String contaPrincipal) {
        this.contaPrincipal = contaPrincipal;
    }

    public String getApelido() {
        return apelido;
    }

    public void setApelido(String apelido) {
        this.apelido = apelido;
    }

    public Clan getClan() {
        return this.clan;
    }

    public void setClan(Clan clan) {
        this.clan = clan;
    }

    public String getRanking() {
        return ranking;
    }

    public void setRank(String rank) {
        this.ranking = rank;
    }

    public double getPorcentagemComparecimento() {
        return porcentagemComparecimento;
    }

    public void setPorcentagemComparecimento(double porcentagemComparecimento) {
        this.porcentagemComparecimento = porcentagemComparecimento;
    }

    public int getNumeroEventosComparecidos() {
        return numeroEventosComparecidos;
    }

    public void setNumeroEventosComparecidos(int numeroEventosComparecidos) {
        this.numeroEventosComparecidos = numeroEventosComparecidos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void adicionarJogador(Jogador membro) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(membro);
        em.getTransaction().commit();
        System.out.println("Membro adicionado");
        //emf.close();
        //em.close();
    }


    public static List<Jogador> recuperarJogadoresPorClan(Clan id) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select j from Jogador j where j.clan = : idClan";
        TypedQuery<Jogador> typedQuery = em
                .createQuery(query, Jogador.class)
                .setParameter("idClan", id);
        List<Jogador> lista;

        lista = typedQuery.getResultList();
        //emf.close();
        //em.close();

        return lista;
    }


    public List<Jogador> recuperarTodosJogadores() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();
        String query = "Select j from Jogador j";
        TypedQuery<Jogador> typedQuery = em
                .createQuery(query, Jogador.class);
        List<Jogador> lista;

        lista = typedQuery.getResultList();
        //emf.close();
        //em.close();

        return lista;
    }



}
