.import "../../ui/UColors.js" as Colors

function getDeviceValuesParams (period) {
    period = period || "hour";

    var from = ""
    var to = ""
    var interval = ""

    switch (period) {
    case "hour":
        from = new Date().setMinutes(0, 0, 0);
        interval = "5min"
        break;
    case "today":
        from = new Date().setHours(0, 0, 0, 0);
        interval = "30min"
        break;
    case "week":
        from = new Date();
        from = new Date(from).setDate(from.getDate() - from.getDay());
        from = new Date(from).setHours(0, 0, 0, 0);
        interval = "1day"
        break;
    case "month":
        from = new Date().setDate(1)
        from = new Date(from).setHours(0, 0, 0, 0);
        interval = "1day"
        break;
    case "year":
        from = new Date().setMonth(0)
        from.setHours(0, 0, 0, 0);
        interval = "1month"
        break;
    }

    to = new Date().getTime()

    return {
        "from": String(from),
        "to": String(to),
        "interval": interval
    }
}

function deviceValuesToChartData(model, period) {
    var chartData = {
        "labels": [],
        "data": []
    };

    if (!model)
        return chartData;

    for (var i = 0; i < model.rowCount; i++) {
        var stat = model.get(i);
        chartData["labels"].push(timestampToLabel(stat.timestamp, period));
        chartData["data"].push(Number(stat.data));
    }

    return chartData;
}

function timestampToLabel(timestamp, period) {
    var currentDate = new Date(timestamp);

    switch (period) {
    case "hour":
        return Qt.formatDateTime(currentDate, "mm:ss");
    case "today":
        return Qt.formatDateTime(currentDate, "hh:mm");
    case "week":
        return Qt.formatDateTime(currentDate, "ddd");
    case "month":
        return Qt.formatDateTime(currentDate, "dd/MM");
    case "year":
        return Qt.formatDateTime(currentDate, "MMM");
    }
}
