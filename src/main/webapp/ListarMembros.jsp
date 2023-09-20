<%@ page import="classes.Jogador" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: reina
  Date: 29/10/2021
  Time: 13:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Listar membros</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">

    <%
        List<Jogador> listaDeMembros;
    %>

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
            List<Jogador> listaDeMembros1;
            Jogador j1 = new Jogador();
            listaDeMembros1 = j1.recuperarTodosJogadores();
        %>
        <table style="width:100%">
            <tr>
                <th>ID</th>
                <th>Apelido</th>
                <th>Conta Principal</th>
                <th>Rank atual</th>
                <th>Clan</th>

            </tr>
            <% for (int i = 0; i < listaDeMembros1.size(); i++) {
                out.print("<tr>");
                out.print("<td>" + listaDeMembros1.get(i).getId() + "</td>");
                out.print("<td>" + listaDeMembros1.get(i).getApelido() + "</td>");
                out.print("<td>" + listaDeMembros1.get(i).getContaPrincipal() + "</td>");
                out.print("<td>" + listaDeMembros1.get(i).getRanking() + "</td>");
                out.print("<td>" + listaDeMembros1.get(i).getClan().getNome() + "</td>");
                out.print("<th>Editar</th>");
                out.print("<th>Excluir</th>");
                out.print("</tr>");
            }
            %>
        </table>


    </div>


</div>
</body>
</html>
