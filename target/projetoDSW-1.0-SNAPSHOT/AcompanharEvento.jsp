<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: reina
  Date: 29/10/2021
  Time: 13:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Acompanhar evento</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%
    if (session.getAttribute("logado") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<div class="bs-component">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="landing.jsp">Projeto</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01"
                    aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor02">
                <ul class="navbar-nav me-auto">


                    <li class="nav-item">
                        <a class="nav-link" href="AdicionarClan.jsp">Adicionar clan</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="ListarClans.jsp">Lista de clans</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="DetalharClan.jsp">Detalhar clan</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="AdicionarMembro.jsp">Adicionar membro</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="ListarMembros.jsp">Lista de Membros</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="AdicionarEvento.jsp">Adicionar evento</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="AcompanharEvento.jsp">Acompanhar evento</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="ListarEventos.jsp">Lista de Eventos</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">Sobre</a>
                    </li>
                </ul>
                <%
                    String nome = (String) session.getAttribute("nome");
                    if (nome == null) {
                        response.sendRedirect("index.jsp");
                    }

                %>
                <a class="navbar-brand">Seja bem vindo,  <%= nome %>
                </a>
                <a class="nav-link" href="https://discord.gg/MkDSV5GkpK">Discord</a>
            </div>
        </div>
    </nav>
</div>

<div class="container">


    <div class="container">
        <%
            String tituloEvento = request.getParameter("tituloEvento");
            String descricaoEvento = request.getParameter("descricaoEvento");
            String dataEvento = request.getParameter("dataEvento");
            String idClan = request.getParameter("clans");
            int idEvento = 0;
            Clan clan = new Clan();

            if(idClan != null){
                int clanId = Integer.parseInt(idClan);
                clan.setId(clanId);
            }

            Hiscores hiscores;
            List<Jogador> membros = null;
            List<String> nomeMembros = new ArrayList<>();

            if (tituloEvento != null && !tituloEvento.isEmpty()) {
                if (descricaoEvento != null && !descricaoEvento.isEmpty()) {
                    if (dataEvento != null && !dataEvento.isEmpty()) {
                        Evento evento = new Evento();
                        evento.setNome(tituloEvento);
                        evento.setDescricao(descricaoEvento);
                        evento.setData(dataEvento);
                        //idEvento = evento.retornarUltimoIdEvento();

                        clan = clan.recuperarClan(Integer.parseInt(idClan)).get(0);
                        evento.setClan(clan);

                        evento.adicionarEvento(evento);

                        membros = Jogador.recuperarJogadoresPorClan(clan);
                        nomeMembros = new ArrayList<>();
                        for(int i=0; i<membros.size();i++){
                            nomeMembros.add(membros.get(i).getContaPrincipal());
                        }


                    }
                }
            }
        %>
        <table style="width:100%">
            <tr>
                <th>Título</th>
                <th>Descriçao</th>
                <th>Data</th>
                <th>Clan</th>

            </tr>
            <%

                out.print("<tr>");
                out.print("<td>" + tituloEvento + "</td>");
                out.print("<td>" +descricaoEvento + "</td>");
                out.print("<td>" + dataEvento + "</td>");
                if(idClan != null)
                out.print("<td>" + clan.recuperarClan(Integer.parseInt(idClan)).get(0).getNome()+ "</td>");
                out.print("</tr>");

            %>
        </table>

        <form method="post" action="ListarEventos.jsp">
            <button type="submit" class="btn btn-info" action="ListarEventos.jsp">Terminar evento</button>
        </form>
        <%
            out.print("<br><br><br>");

            //Hashmap para guardar o nome das contas principais dos membros e a experiência nas habilidades desejadas
            HashMap<String, ArrayList<Integer>> mapaMembroExperiencia = new HashMap<>();
            for(int i=0; i<nomeMembros.size();i++){
                //Método que acessa a API do runescape para puxar os dados do hiscores
                Hiscores hi = new Hiscores(nomeMembros.get(i));
                //Guardando toda a experiencia desejada em um arrayList
                ArrayList<Integer> experienciaMembros = new ArrayList<>();
                experienciaMembros.add(hi.getExperience(MySkills.STRENGTH));
                experienciaMembros.add(hi.getExperience(MySkills.ATTACK));
                experienciaMembros.add(hi.getExperience(MySkills.DEFENCE));
                experienciaMembros.add(hi.getExperience(MySkills.HITPOINTS));
                experienciaMembros.add(hi.getExperience(MySkills.RANGED));
                experienciaMembros.add(hi.getExperience(MySkills.MAGIC));
                //Adicionando o nome e a experiencia em um hashmap
                mapaMembroExperiencia.put(nomeMembros.get(i), experienciaMembros);
            }
            //out.print("Nome membros: "+nomeMembros);
            /*for (Map.Entry mapElement: mapaMembroExperiencia.entrySet()){
                out.print("Nome membro: "+mapElement.getKey());
                out.print("<br>");
                out.print("Experiencia: "+mapElement.getValue());
                out.print("<br>");
            }*/
            session.setAttribute("nomeMembros", nomeMembros);
            session.setAttribute("listaMembros", membros);
            session.setAttribute("mapaMembroExperiencia", mapaMembroExperiencia);

        %>
    </div>




</div>
</body>
</html>
