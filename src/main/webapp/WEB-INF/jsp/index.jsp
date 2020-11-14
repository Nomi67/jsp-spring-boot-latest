<%@ include file="common/header.jspf" %>
<div class="container my-2">
    <div class="card" style="background-color: gainsboro;">
        <div class="card-body">

            <form action="/stats" >
                <div class="row">
                    <div class="col">
                        <div class="form-group mb-2">
                            <label for="date" class="sr-only">Select Date</label>
                            <input required type="date" name="date" id="date" class="form-control"
                                   placeholder="Select Date"></input>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group mx-sm-3 mb-2">
                            <select name='country'>
                                <c:forEach items="${countries}" var="country">
                                    <option value="${country.key}">${country.value}</option>
                                </c:forEach>
                            </select>

                        </div>
                    </div>
                    <div class="col"/>
                    <div class="col">

                        <button type="submit" class="btn btn-primary btn-lg btn-block btn-sm mb-2">Get Stats</button>
                    </div>
                </div>
            </form>


        </div>
    </div>
    <c:if test="${stats != null}">
    <div class="card ">
        <div class="card-header ">
            <h3 class="text-center">${countryName}</h3>

        </div>
        <div class="card-body ">
            <ul class="list-group ">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Date
                    <span>${stats.date}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Confirmed
                    <span>${stats.todayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Deaths
                    <span>${stats.todayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Confirmed
                    <span>${stats.todayNewConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Deaths
                    <span>${stats.todayNewDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Open Cases
                    <span>${stats.todayNewOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Recovered
                    <span>${stats.todayNewRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Open Cases
                    <span>${stats.todayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Recovered
                    <span>${stats.todayRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Confirmed
                    <span>${stats.todayVsYesterdayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Deaths
                    <span>${stats.todayVsYesterdayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Open Cases
                    <span>${stats.todayVsYesterdayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Recovered
                    <span>${stats.todayVsYesterdayRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Confirmed
                    <span>${stats.yesterdayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Deaths
                    <span>${stats.yesterdayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Open Cases
                    <span>${stats.yesterdayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Recovered
                    <span>${stats.yesterdayRecovered}</span>
                </li>

            </ul>
            <div class="row">
                <div class="col"></div>
                <div class="col"></div>
                <div class="col"></div>
                <div class="col">
                        <%--                    <form:form modelAttribute="stats" action="/save" method="POST">--%>
                        <%--                    <button type="submit" style="margin-top: 10px;"   class="btn btn-primary btn-lg btn-block btn-sm pull-right">Save</button>--%>
                        <%--                    </form:form>--%>
                    <form method="POST"
                          action="/save">

                        <input type="hidden" name="countryName" id="nameField" class="form-control"
                               value="${countryName}"/>
                        <input type="hidden" name="date" value="${stats.date}"/>
                        <input type="hidden" name="totalCases" value="${stats.todayConfirmed}"/>
                        <input type="hidden" name="totalDeaths" value="${stats.todayDeaths}"/>
                        <input type="hidden" name="newCases" value="${stats.todayNewConfirmed}"/>
                        <button type="submit" style="margin-top: 10px;"
                                class="btn btn-primary btn-lg btn-block btn-sm pull-right">Save
                        </button>
                    </form>
                </div>
            </div>

        </div>
        </c:if>
    </div>
</div>
</body>

</html>
