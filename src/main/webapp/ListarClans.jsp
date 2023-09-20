<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="classes.Clan" %><%--
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
    <title>Listar clans</title>
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
            <th>ID do Clan</th>
            <th>Nome do Clan</th>
            <th>Tipo do Clan</th>
            <th>Número da capa</th>
            <th>Quantidade de membros</th>
            </tr>
    <%
        Clan clan = new Clan();
        listaDeClans = clan.recuperarTodosClans();
        if (listaDeClans != null && listaDeClans.size() > 0) {
            for (int i = 0; i < listaDeClans.size(); i++) {
                out.print("<tr>");
                    out.print("<td>"+listaDeClans.get(i).getId()+"</td>");
                    out.print("<td>"+listaDeClans.get(i).getNome()+"</td>");
                    out.print("<td>"+listaDeClans.get(i).getTipo()+"</td>");
                    out.print("<td>"+listaDeClans.get(i).getNumeroCapa()+"</td>");
                    out.print("<td>"+listaDeClans.get(i).quantidadeMembrosNoClan(listaDeClans.get(i))+"</td>");
                    out.print("</tr>");
            }
        } else {
            //out.print("Nao existem clans adicionados ainda! Adicione um clan agora utilizando <a href='AdicionarClan.jsp'>esse formulário</a>");
        }

    %>
    </table>

</div>
