<%@ page import="classes.*" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: reina
  Date: 28/10/2021
  Time: 03:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Listar eventos</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">

    <%
        List<Clan> listaDeClans;
    %>


</head>
<body>
<%
    if(session.getAttribute("logado") == null){
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
                    if(nome == null){
                        response.sendRedirect("index.jsp");
                    }
                %>
                <a class="navbar-brand">Seja bem vindo,  <%= nome %></a>
                <a class="nav-link" href="https://discord.gg/MkDSV5GkpK">Discord</a>
            </div>
        </div>
    </nav>
</div>

<div class="container">

    <table style="width:100%">
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Descriçao</th>
            <th>Data</th>
            <th>Clan</th>
        </tr>

        <%
            Evento evento = new Evento();
            int idEvento = 0;
                String stringId = request.getParameter("eventoSelecionado");
                if(stringId != null) {
                    idEvento = Integer.parseInt(stringId);
                }

            List<Evento> eventos = evento.recuperarEvento(idEvento);
            if(eventos != null && eventos.size() > 0){
                for (int i = 0; i < eventos.size(); i++) {
                    out.print("<tr>");
                    out.print("<td>"+eventos.get(i).getId()+"</td>");
                    out.print("<td>"+eventos.get(i).getNome()+"</td>");
                    out.print("<td>"+eventos.get(i).getDescricao()+"</td>");
                    out.print("<td>"+eventos.get(i).getData()+"</td>");
                    out.print("<td>"+eventos.get(i).getClan().getNome()+"</td>");
                    out.print("</tr>");
                }
            }
        %>
    </table>

    <form method="post">
        <br><br>
        <label style="margin-right: 10px;">Escolha um evento na lista</label>
        <select name ="eventoSelecionado" class="form-control" style="width: 250px;" id="eventoSelecionado">
            <option value="-1">Evento</option>
            <%
                List<Evento> todosEventos = evento.recuperarTodosEventos();
                for (int i=0; i<todosEventos.size();i++){
                    out.print("<option value="+todosEventos.get(i).getId()+ ">"+todosEventos.get(i).getNome());
                }
            %>
        </select>

        <button type="submit" class="btn btn-info" action="ListarEventos.jsp">Listar eventos</button>
    </form>
    <table style="width:100%">
        <tr>
            <th>Conta Principal</th>
            <th>Força</th>
            <th>Ataque</th>
            <th>Defesa</th>
            <th>Vida</th>
            <th>Ranged</th>
            <th>Magia</th>
            <th></th>
        </tr>
        <%
            List<String> nomeMembros = new ArrayList<>();
            nomeMembros = (List<String>) session.getAttribute("nomeMembros");

            List<Jogador> listaMembros;
            listaMembros = (List<Jogador>) session.getAttribute("listaMembros");



            HashMap<String, ArrayList<Integer>> mapaMembroExperiencia1 = (HashMap<String, ArrayList<Integer>>) session.getAttribute("mapaMembroExperiencia");
            HashMap<String, ArrayList<Integer>> mapaMembroExperiencia2 = new HashMap<>();

            HashMap<String, ArrayList<Integer>> mapaDiferençaExperiencia = new HashMap<>();
            if(nomeMembros != null) {
                for (int i = 0; i < nomeMembros.size(); i++) {
                    Hiscores hi = new Hiscores(nomeMembros.get(i));
                    ArrayList<Integer> experienciaMembros = new ArrayList<>();
                    experienciaMembros.add(hi.getExperience(MySkills.STRENGTH));
                    experienciaMembros.add(hi.getExperience(MySkills.ATTACK));
                    experienciaMembros.add(hi.getExperience(MySkills.DEFENCE));
                    experienciaMembros.add(hi.getExperience(MySkills.HITPOINTS));
                    experienciaMembros.add(hi.getExperience(MySkills.RANGED));
                    experienciaMembros.add(hi.getExperience(MySkills.MAGIC));
                    mapaMembroExperiencia2.put(nomeMembros.get(i), experienciaMembros);
                }
            }
            //Calculando a diferença entre as experiências no ArrayList
            ArrayList<Integer> experienciaComeço;
            ArrayList<Integer> experienciaFinal;
            ArrayList<Integer> diferença = new ArrayList<>();



            for (String nomeNoMapa : mapaMembroExperiencia2.keySet()){
                ArrayList<Integer> listFinal, listInicial, listDiferença = new ArrayList<>();
                int diferençaDeExperiencia = 0;

                System.out.println("\nMembro atual: "+nomeNoMapa);
                listFinal = mapaMembroExperiencia2.get(nomeNoMapa);
                System.out.println("Arraylist da experiencia final: "+listFinal);
                listInicial = mapaMembroExperiencia1.get(nomeNoMapa);
                System.out.println("Arraylist da experiencia inicial: "+listInicial);
                for(int k = 0; k<listFinal.size();k++){
                     diferençaDeExperiencia = listFinal.get(k) - listInicial.get(k);
                    System.out.println("A diferença de experiencia da skill: "+k+" do membro: "+nomeNoMapa +" é: "+diferençaDeExperiencia);
                    listDiferença.add(diferençaDeExperiencia);
                }

                System.out.println("list de diferença agora: "+listDiferença+" para o membro: "+nomeNoMapa);
                mapaDiferençaExperiencia.put(nomeNoMapa, listDiferença);
            }


            /*if(nomeMembros != null) {
                for (int j = 0; j < nomeMembros.size(); j++) {
                    //Pegando a experiência no hashmap através do nome dos membros (key)
                    experienciaComeço = mapaMembroExperiencia1.get(nomeMembros.get(j));
                    experienciaFinal = mapaMembroExperiencia2.get(nomeMembros.get(j));

                    //A partir de agora, temos o nosso ArrayList com a diferença de experiencia após começar e terminar o evento
                    diferença.add(experienciaFinal.get(j) - experienciaComeço.get(j));
                }

                out.print("ArrayList diferenças: "+diferença);
                out.print("<br>");

                if(nomeMembros != null){
                    for (int i = 0; i < nomeMembros.size(); i++) {
                        mapaDiferençaExperiencia.put(nomeMembros.get(i), diferença);
                    }
                }
            }*/
            if(mapaDiferençaExperiencia != null) {
                for(String nomeNoMapa2 : mapaDiferençaExperiencia.keySet()){
                //for (int i = 0; i < nomeMembros.size(); i++) {
                    out.print("<tr>");
                    out.print("<td>" + nomeNoMapa2 + "</td>");
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(0) + "</td>"); // Força
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(1) + "</td>"); // Ataque
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(2) + "</td>"); // Defesa
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(3) + "</td>"); // Vida
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(4) + "</td>"); // Ranged
                    out.print("<td>" + mapaDiferençaExperiencia.get(nomeNoMapa2).get(5) + "</td>"); // Magia
                    out.print("</tr>");
                }
            }


        %>
    </table>
</div>
</body>
