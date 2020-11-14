<%--<%@ include file="common/header.jspf"%>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Events</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
</head>

<body>
<div class="container my-2 align-self-center " style="margin-top: 10%;">
    <div class="row ">
        <div class="col"></div>
    <form:form method="POST"
           action="/login" modelAttribute="user"  class="col shadow p-3 mb-5 bg-white rounded">
        <h3 class="text-center form-heading">Login</h3>
        <div class="form-group">
            <form:label path="name" for="nameField" >Email address</form:label>
            <form:input type="text" path="name" id="nameField" class="form-control"  ></form:input>
        </div>
        <div class="form-group">
            <form:label path="password" for="passwordField" >Password</form:label>
            <form:input type="password"  id="passwordField" path="password" class="form-control"></form:input>
        </div>

        <input type="submit" class="btn btn-primary"></input>
    </form:form>
        <div class="col"/>
    </div>

</div>
</body>
</html>