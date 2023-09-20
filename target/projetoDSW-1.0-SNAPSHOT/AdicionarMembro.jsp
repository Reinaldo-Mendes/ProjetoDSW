<%@ page import="classes.Jogador" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>Adicionar membros</title>
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
    <form method="post">
        <label class="form-label mt-4">Apelido do membro</label>
        <input type="text" class="form-control" name="apelidoMembro" aria-describedby="apelidoMembroHelp"
               placeholder="Digite o nome do membro">
        <small id="apelidoMembroHelp" class="form-text text-muted"></small>

        <label class="form-label mt-4">Conta principal</label>
        <input type="text" class="form-control" name="contaPrincipal" aria-describedby="contaPrincipalHelp"
               placeholder="Qual o nome da conta principal?">
        <small id="nomeConta" class="form-text text-muted"></small>

        <label class="form-label mt-4">Rank</label>
        <input type="text" class="form-control" name="rankMembro" aria-describedby="rankMembroHelp"
               placeholder="Qual o rank atual do membro?">
        <small id="rankMembroHelp" class="form-text text-muted"></small>
        <br><br>
        <label style="margin-right: 10px;">Escolha um clan na lista</label>
        <select class="form-control" style="width: 250px;" name="clans" id="clans">
            <option value="-1">Clan</option>
            <%
                Clan clan = new Clan();
                List<Clan> todosClans = clan.recuperarTodosClans();
                for (int i=0; i<todosClans.size();i++){
                    out.print("<option value="+todosClans.get(i).getId()+ ">"+todosClans.get(i).getNome());
                }
            %>

        </select>
        <br><br>
        <button type="submit" class="btn btn-info" action="">Registrar membro</button>
    </form>
    <%
        String apelidoMembro = request.getParameter("apelidoMembro");
        String contaPrincipal = request.getParameter("contaPrincipal");
        String rankAtual = request.getParameter("rankMembro");
        String idClan = request.getParameter("clans");


        Clan c = new Clan();
        if(idClan != null)
        c.setId(Integer.parseInt(idClan));

        if (apelidoMembro != null && !apelidoMembro.isEmpty()) {
            if (contaPrincipal != null && !contaPrincipal.isEmpty()) {
                if (rankAtual != null && !rankAtual.isEmpty()) {
                    Jogador jogador = new Jogador(apelidoMembro, contaPrincipal, rankAtual, 0, 0, c);
                    jogador.adicionarJogador(jogador);
                }
            }
        }
            out.print("<a href='ListarMembros.jsp'>Clique aqui para listar os membros registrados até agora</a>");
    %>
</div>
</body>
</html>