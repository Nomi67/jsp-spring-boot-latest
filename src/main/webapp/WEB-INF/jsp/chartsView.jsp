<%@ include file="common/header.jspf" %>
<script type="text/javascript">
    window.onload = function () {

        var dps = [[]];
        var chart = new CanvasJS.Chart("chartContainer", {
            theme: "light2", // "light1", "dark1", "dark2"
            exportEnabled: true,
            animationEnabled: true,
            title: {
                text: "Covid Visuals"
            },
            data: [{
                type: "pie",
                showInLegend: "true",
                legendText: "{label}",
                yValueFormatString: "#,###\"\"",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}",
                dataPoints: dps[0]
            }]
        });

        var yValue;
        var label;

        <c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
        <c:forEach items="${dataPoints}" var="dataPoint">
        yValue = parseFloat("${dataPoint.y}");
        label = "${dataPoint.label}";
        dps[parseInt("${loop.index}")].push({
            label: label,
            y: yValue,
        });
        </c:forEach>
        </c:forEach>

        chart.render();
    }
</script>
<div class="container my-2">
    <div class="card " style="background-color: gainsboro;">
        <div class="card-body">
            <form action="/canvasjschart">
                <div class="row">
                    <div class="col">
                        <div class="form-group mb-2">
                            <div class="form-group mx-sm-3 mb-2">
                                <select name='country'>
                                    <c:forEach items="${countries}" var="country">
                                        <option value="${country}">${country}</option>
                                    </c:forEach>
                                </select>

                            </div>
                        </div>
                    </div>
                    <div class="col"></div>
                    <div class="col"></div>
                    <div class="col">
                        <button type="submit" class="btn btn-primary btn-lg btn-block btn-sm mb-2">Get Stats</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="shadow-sm p-3 mb-5 bg-white rounded">

        <div id="chartContainer" style="height: 370px; width: 100%;"></div>
    </div>
</div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>