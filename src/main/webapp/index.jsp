<%@ page import="classes.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
    <link rel="stylesheet" href="loginstyle.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
          integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

</head>
<body>
<div class="container">
    <div class="content first-content">
        <div class="first-column">
            <h2 class="title title-primary">Bem vindo!</h2>
            <p class="description description-primary">Para começar a usar o sistema,</p>
            <p class="description description-primary">Por favor faça o login ao lado!</p>
        </div>
        <div class="second-column">
            <h2 class="title title-second">Login</h2>
            <div class="social-media">
                <ul class="list-social-media">
                    <a class="link-social-media" href="#">
                        <li class="item-social-media">
                            <i class="fab fa-facebook-f"></i>
                        </li>
                    </a>
                    <a class="link-social-media" href="#">
                        <li class="item-social-media">
                            <i class="fab fa-google-plus-g"></i>
                        </li>
                    </a>
                    <a class="link-social-media" href="#">
                        <li class="item-social-media">
                            <i class="fab fa-linkedin-in"></i>
                        </li>
                    </a>
                </ul>
            </div><!-- social media -->
            <p class="description description-second">ou utilize o usuario e senha:</p>
            <form class="form" method="post" action="index.jsp">
                <label class="label-input">
                    <i class="far fa-user icon-modify"></i>
                    <input type="text" placeholder="Nome" name="nome" id="nome">
                </label>
                <label class="label-input">
                    <i class="fas fa-lock icon-modify"></i>
                    <input type="password" placeholder="Senha" name="senha" id="senha">
                </label>

                <button class="btn btn-second" onclick="validatedLogin()">Login</button>
            </form>
            <%
                String senha = request.getParameter("senha");
                String nome = request.getParameter("nome");

                if(senha != null && nome != null && !nome.isEmpty() && !senha.isEmpty()){
                    Usuario user = new Usuario(nome, senha);
                    if(user.validarUsuario(nome, senha)){
                        session.setAttribute("nome", nome);
                        session.setAttribute("logado", "true");
                        response.sendRedirect("landing.jsp");
                    }
                }
            %>
        </div><!-- second column -->
    </div><!-- first content -->
</div>

</body>
</html>