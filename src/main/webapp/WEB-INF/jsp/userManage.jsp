<%@ include file="common/header.jspf" %>
<div class="container my-2">
    <div class="card">
        <div class="card-header ">
            <h3 class="text-center">Manage User</h3>

        </div>
        <div class="card-body">


            <form method="POST" action="/create/user">
                <div class="row">
                    <div class="col">
                        <div class="form-group mb-2">
                            <label for="date" class="sr-only">Select Date</label>
                            <input required type="text" name="username" class="form-control" placeholder="username"></input>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group mb-2">
                            <label for="date" class="sr-only">Select Date</label>
                            <input required type="password" name="password" id="date" class="form-control"
                                   placeholder="password"></input>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group mx-sm-3 mb-2">
                            <select required name='role'>

                                <option value="ROLE_USER">USER</option>
                                <option value="ROLE_ADMIN">ADMIN</option>
                            </select>

                        </div>
                    </div>
                    <div class="col">


                        <button type="submit" class="btn btn-primary btn-lg btn-block btn-sm mb-2">Create User</button>
                    </div>
                </div>
            </form>


            <table class="table table-striped" style="margin-top: 20px;">
                <thead>
                <tr>
                    <th scope="col">Username</th>
                    <th scope="col">Password</th>
                    <th scope="col">Role</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>

                        <td>${user.getName()}</td>
                        <td>${user.getPassword()}</td>
                        <td>${user.getRole()}</td>
                        <td>
                            <form method="POST" action="/delete/user">
                                <input type="hidden" value="${user.getId()}" name="userId">
                                <button type="submit" class="btn btn-primary btn-sm">delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>


            <%--            <form action="/stats" class="form-inline">--%>
            <%--                <div class="form-group mb-2">--%>
            <%--                    <label for="date" class="sr-only">Select Date</label>--%>
            <%--                    <input type="date" name="date" id="date" class="form-control" placeholder="Select Date"></input>--%>
            <%--                </div>--%>
            <%--                <div class="form-group mx-sm-3 mb-2">--%>
            <%--                    <select name='country'>--%>
            <%--                        <c:forEach items="${countries}" var="country">--%>
            <%--                            <option value="${country.key}">${country.value}</option>--%>
            <%--                        </c:forEach>--%>
            <%--                    </select>--%>

            <%--                </div>--%>
            <%--                <button type="submit" class="btn btn-primary mb-2">Confirm identity</button>--%>
            <%--            </form>--%>
        </div>
    </div>

</div>
</body>

</html>
