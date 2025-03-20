<%-- navbar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    nav {
        background-color: #333;
        padding: 1rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .brand {
        color: white;
        font-family: Arial, sans-serif;
        font-size: 1.5rem;
        text-decoration: none;
        margin-left: 20px;
    }
    ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        display: flex;
    }
    li a {
        color: white;
        text-decoration: none;
        font-family: Arial, sans-serif;
        padding: 10px 20px;
    }
    li a:hover {
        background-color: #555555;
        border-radius: 5px;
    }
</style>
<nav>
    <a href="#" class="brand">Megacitycab</a>
    <ul>
        <li><a href="<%= request.getContextPath() %>/dashboard">Booki</a></li>
        <li><a href="<%= request.getContextPath() %>/drivers">Drivers</a></li>
        <li><a href="<%= request.getContextPath() %>/vehicles">Vehicles</a></li>
        <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
    </ul>
</nav>