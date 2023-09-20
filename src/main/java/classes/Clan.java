package classes;

import javax.persistence.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Clan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    String nome, tipo;
    int numeroCapa;

    @OneToMany(mappedBy = "clan", cascade = CascadeType.ALL)
    private List<Jogador> jogadores = new ArrayList<>();

    public Clan(String nome){
        this.nome = nome;
    }

    public Clan (String nome, String tipo, int numeroCapa){
        this.nome = nome;
        this.tipo = tipo;
        this.numeroCapa = numeroCapa;
    }
    public Clan(){
        System.out.println("Objeto clan criado");
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumeroCapa() {
        return numeroCapa;
    }

    public void setNumeroCapa(int numeroCapa) {
        this.numeroCapa = numeroCapa;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }


    public void adicionarClan(Clan clan){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(clan);
        em.getTransaction().commit();
        System.out.println("Clan adicionado");
        emf.close();
        em.close();
    }

    public List<Clan> recuperarClan(int id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select c from Clan c where id = : idClan";
        TypedQuery<Clan> typedQuery = em
                .createQuery(query, Clan.class)
                .setParameter("idClan", id);
        List<Clan> listaDoClan;

        listaDoClan = typedQuery.getResultList();
        //emf.close();
        //em.close();

        return listaDoClan;
    }

    //Nao retorna o número real
    /*public int quantidadeMembrosNoClan(Clan id) {
        int quantidade;
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select count(*) from Jogador j where j.clan = : idClan";
        Query query2 = em.
                createQuery(query).
                setParameter("idClan", id);

        quantidade = query2.getFirstResult();
           emf.close();
        em.close();
        return quantidade;
    }*/

    //Workaround para pegar a quantidade de membros de um clan
    public int quantidadeMembrosNoClan(Clan id){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select j from Jogador j  where j.clan =: idClan";
        TypedQuery<Jogador> typedQuery = em
                .createQuery(query, Jogador.class).
                setParameter("idClan", id);
        List<Jogador> listaMembros;

        listaMembros = typedQuery.getResultList();
        int quantidade = listaMembros.size();
        //emf.close();
        //em.close();

        return quantidade;
    }



    public List<Clan> recuperarTodosClans(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("projetoDSW");
        EntityManager em = emf.createEntityManager();

        String query = "Select c from Clan c";
        TypedQuery<Clan> typedQuery = em
                .createQuery(query, Clan.class);
        List<Clan> listaDoClan;

        listaDoClan = typedQuery.getResultList();
        //emf.close();
        //em.close();
        return listaDoClan;
    }
}
