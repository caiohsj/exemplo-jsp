<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            List<String> nomes = (List) application.getAttribute("nomes");
            
            String acao = request.getParameter("acao");
            
            if("editar".equals(acao)) {
                String index = request.getParameter("index");
                String nome = nomes.get(Integer.parseInt(index));
        %>
            <form method="POST">
                <input type="hidden" name="index" value="<%=index%>">
                <input type="hidden" name="acao" value="editar">
                <label for="nome">Nome</label>
                <input type="text" name="nome" value="<%=nome%>"/>
                <button type="submit">Salvar</button>
            </form>
        <% } else { %>
            <form method="POST">
                <input type="hidden" name="acao" value="salvar">
                <label for="nome">Nome</label>
                <input type="text" name="nome"/>
                <button type="submit">Salvar</button>
            </form>
        <% } %>

        <table>
            <thead>
            <th>ID</th>
            <th>Nome</th>
            <th>Ação</th>
        </thead>
        <tbody>
            <%
                
                if(nomes == null){
                    nomes = new ArrayList();
                }
                
                if(request.getMethod().equals("POST") && "salvar".equals(acao)){
                    String nome = request.getParameter("nome");
                    nomes.add(nome);
                    application.setAttribute("nomes", nomes);
                }
                
                if(request.getMethod().equals("POST") && "remover".equals(acao)) {
                    String index = request.getParameter("index");
                    nomes.remove(Integer.parseInt(index));
                    application.setAttribute("nomes", nomes);
                }
                
                if(request.getMethod().equals("POST") && "editar".equals(acao)) {
                    String index = request.getParameter("index");
                    String nome = request.getParameter("nome");
                    nomes.remove(Integer.parseInt(index));
                    nomes.add(Integer.parseInt(index), nome);
                    application.setAttribute("nomes", nomes);
                    response.sendRedirect(request.getContextPath() + "/");
                }
                
                for (int i = 0; i < nomes.size(); i++) {
                    %>
                    <tr>
                        <td style="color: red">
                            <%=i%>
                        </td>
                        <td style="color: red">
                            <%=nomes.get(i)%>
                        </td>
                        <td>
                            <form method="GET">
                                <input type="hidden" name="acao" value="editar">
                                <input type="hidden" name="index" value="<%=i%>">
                                <button>Editar</button>
                            </form>
                        </td>
                        <td>
                            <form method="POST">
                                <input type="hidden" name="acao" value="remover">
                                <input type="hidden" name="index" value="<%=i%>">
                                <button>Remover</button>
                            </form>
                        </td>
                    </tr>
                    <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
