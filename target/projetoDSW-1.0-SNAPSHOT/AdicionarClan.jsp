<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Clan" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Adicionar clan</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">

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
                        <a class="nav-link" href="AdicionarEvento.jsp">Acompanhar evento</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="AcompanharEvento.jsp">Adicionar evento</a>
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
    <form method="post">
        <label class="form-label mt-4">Nome do clan</label>
        <input type="text" class="form-control" name="nomeClan" aria-describedby="nomeClanHelp"
               placeholder="Digite o nome do clan">
        <small id="nomeClanHelp" class="form-text text-muted"></small>

        <label class="form-label mt-4">Tipo de clan</label>
        <input type="text" class="form-control" name="tipoClan" aria-describedby="numeroCapaHelp"
               placeholder="O clan é de pure, med, zerk ou main?">
        <small id="tipoClanHelp" class="form-text text-muted"></small>

        <label class="form-label mt-4">Número da capa</label>
        <input type="text" class="form-control" name="numeroCapa" aria-describedby="numeroCapaHelp"
               placeholder="Digite o número da capa">
        <small id="capeHelp" class="form-text text-muted"></small>


        <button type="submit" class="btn btn-info" action="AdicionarClan.jsp">Registrar clan</button>
    </form>

    <%
        List<Clan> listaDeClans;
        String nomeClan = request.getParameter("nomeClan");
        String tipoClan = request.getParameter("tipoClan");
        String numeroCapa = request.getParameter("numeroCapa");
        //Clan clan = new Clan();
        //List<String> atividades = new ArrayList<>();
        if (session.getAttribute("listaClans") == null) {
            listaDeClans = new ArrayList<>();
        } else {
            listaDeClans = (List<Clan>) session.getAttribute("listaClans");
        }

        if (nomeClan != null && !nomeClan.isEmpty()) {
            if (tipoClan != null && !tipoClan.isEmpty()) {
                if (numeroCapa != null && !numeroCapa.isEmpty()) {
                    Clan clan = new Clan(nomeClan, tipoClan, Integer.parseInt(numeroCapa));
                    clan.adicionarClan(clan);
                }

            }
        }
        if (session.getAttribute("nomeClan") != null && session.getAttribute("listaClans") != null) {
            out.print("<a href='ListarClans.jsp'>Clique aqui para listar os clans registrados até agora</a>");
        }
    %>
</div>